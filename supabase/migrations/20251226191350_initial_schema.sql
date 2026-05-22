-- 🕊️ FMA Pontos - Consolidated Supabase Schema Migration
-- Consolida as tabelas, RLS, políticas, triggers, storage e funções auxiliares.

-- =====================================================
-- 1. TABELAS E ÍNDICES
-- =====================================================

-- Categoria dos pontos/letras
CREATE TABLE IF NOT EXISTS public.categories (
    id text NOT NULL PRIMARY KEY,
    name text NOT NULL,
    code text NOT NULL UNIQUE,
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Letras de pontos
CREATE TABLE IF NOT EXISTS public.lyrics (
    id text NOT NULL PRIMARY KEY,
    category_id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    audio_url text,
    youtube_url text,
    youtube_link text,
    sequence_number integer NOT NULL DEFAULT 0,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    
    CONSTRAINT lyrics_category_id_fkey 
        FOREIGN KEY (category_id) 
        REFERENCES public.categories(id)
        ON DELETE CASCADE,
    CONSTRAINT check_audio_mp3 
        CHECK (audio_url IS NULL OR audio_url ILIKE '%.mp3')
);

CREATE INDEX IF NOT EXISTS idx_lyrics_category_id ON public.lyrics(category_id);

-- Perfis e Roles dos Usuários (RBAC)
CREATE TABLE IF NOT EXISTS public.user_roles (
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email text NOT NULL,
    role text NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'moderator', 'admin')),
    is_active boolean NOT NULL DEFAULT true,
    avatar_url text,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_roles_email ON public.user_roles(email);

-- Estatísticas de reprodução global por letra
CREATE TABLE IF NOT EXISTS public.lyric_play_stats (
    lyric_id text PRIMARY KEY REFERENCES public.lyrics(id) ON DELETE CASCADE,
    play_count integer NOT NULL DEFAULT 0,
    last_played_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_lyric_play_stats_count ON public.lyric_play_stats(play_count DESC);

-- Logs de Auditoria
CREATE TABLE IF NOT EXISTS public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    table_name text NOT NULL,
    record_id text NOT NULL,
    action text NOT NULL,
    old_data jsonb,
    new_data jsonb,
    user_id uuid,
    user_email text,
    created_at timestamp with time zone DEFAULT now(),
    
    CONSTRAINT audit_logs_action_check CHECK (
        action = ANY (ARRAY['INSERT'::text, 'UPDATE'::text, 'DELETE'::text])
    )
);

-- =====================================================
-- 2. FUNÇÕES AUXILIARES (SECURITY DEFINER)
-- =====================================================

-- Obter a role do usuário atual
CREATE OR REPLACE FUNCTION public.get_user_role()
RETURNS text 
LANGUAGE plpgsql 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN COALESCE(
    (SELECT role FROM public.user_roles WHERE id = auth.uid()),
    'user'  -- default para novos usuários
  );
END;
$$;

-- Verificar privilégios do usuário
CREATE OR REPLACE FUNCTION public.has_role(required_role text)
RETURNS boolean 
LANGUAGE plpgsql 
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  user_role text;
BEGIN
  user_role := public.get_user_role();
  
  IF required_role = 'user' THEN
    RETURN user_role IN ('user', 'moderator', 'admin');
  ELSIF required_role = 'moderator' THEN
    RETURN user_role IN ('moderator', 'admin');
  ELSIF required_role = 'admin' THEN
    RETURN user_role = 'admin';
  END IF;
  
  RETURN FALSE;
END;
$$;

-- Verificar se é administrador
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM user_roles 
    WHERE id = auth.uid() AND role = 'admin'
  );
$$;

-- Obter próximo sequence_number para ordenação de letras
CREATE OR REPLACE FUNCTION public.get_next_lyric_sequence(cat_id text)
RETURNS integer 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    max_seq integer;
BEGIN
    SELECT COALESCE(MAX(sequence_number), 0) INTO max_seq
    FROM public.lyrics
    WHERE category_id = cat_id;
    
    RETURN max_seq + 1;
END;
$$;

-- Trigger de Auditoria para inserir logs
CREATE OR REPLACE FUNCTION public.audit_trigger_func() 
RETURNS trigger
LANGUAGE plpgsql 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO audit_logs (table_name, record_id, action, old_data, new_data, user_id, user_email)
  VALUES (
    TG_TABLE_NAME,
    COALESCE(NEW.id::text, OLD.id::text),
    TG_OP,
    CASE WHEN TG_OP IN ('UPDATE', 'DELETE') THEN to_jsonb(OLD) END,
    CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN to_jsonb(NEW) END,
    auth.uid(),
    (SELECT email FROM auth.users WHERE id = auth.uid())
  );
  RETURN COALESCE(NEW, OLD);
END;
$$;

-- Incrementar contagem de reproduções (RPC)
CREATE OR REPLACE FUNCTION public.increment_play_count(p_lyric_id text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.lyric_play_stats (lyric_id, play_count, last_played_at, updated_at)
  VALUES (p_lyric_id, 1, now(), now())
  ON CONFLICT (lyric_id) DO UPDATE SET
    play_count = lyric_play_stats.play_count + 1,
    last_played_at = now(),
    updated_at = now();
END;
$$;

GRANT EXECUTE ON FUNCTION public.increment_play_count(text) TO authenticated;

-- Automatizar criação de user_roles no registro
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger 
LANGUAGE plpgsql 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.user_roles (id, email, role)
  VALUES (new.id, new.email, 'user')
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$;

-- =====================================================
-- 3. TRIGGERS
-- =====================================================

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

CREATE TRIGGER audit_categories
    AFTER INSERT OR DELETE OR UPDATE ON public.categories
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER audit_lyrics
    AFTER INSERT OR DELETE OR UPDATE ON public.lyrics
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

-- =====================================================
-- 4. ROW LEVEL SECURITY (RLS) E POLÍTICAS
-- =====================================================

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lyrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lyric_play_stats ENABLE ROW LEVEL SECURITY;

-- Permissões gerais
GRANT SELECT ON public.categories TO anon;
GRANT SELECT ON public.categories TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.categories TO authenticated;

GRANT SELECT ON public.lyrics TO anon;
GRANT SELECT ON public.lyrics TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.lyrics TO authenticated;

GRANT SELECT, INSERT, UPDATE ON public.user_roles TO authenticated;

GRANT SELECT ON public.lyric_play_stats TO anon;
GRANT SELECT ON public.lyric_play_stats TO authenticated;
GRANT INSERT, UPDATE ON public.lyric_play_stats TO authenticated;

GRANT SELECT ON public.audit_logs TO authenticated;

-- Políticas: user_roles
CREATE POLICY "Users can view own role" ON public.user_roles
    FOR SELECT USING (id = auth.uid());

CREATE POLICY "Admins can manage roles" ON public.user_roles
    FOR ALL USING (public.has_role('admin'));

CREATE POLICY "Users can create own user role" ON public.user_roles
    FOR INSERT TO authenticated WITH CHECK (auth.uid() = id AND role = 'user');

-- Políticas: categories
CREATE POLICY "Read Categories" ON public.categories 
    FOR SELECT USING (true);

CREATE POLICY "Insert Categories" ON public.categories 
    FOR INSERT WITH CHECK (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('moderator')
    );

CREATE POLICY "Update Categories" ON public.categories 
    FOR UPDATE USING (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('moderator')
    );

CREATE POLICY "Delete Categories" ON public.categories 
    FOR DELETE USING (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('admin')
    );

-- Políticas: lyrics
CREATE POLICY "Read Lyrics" ON public.lyrics 
    FOR SELECT USING (true);

CREATE POLICY "Insert Lyrics" ON public.lyrics 
    FOR INSERT WITH CHECK (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('user')
    );

CREATE POLICY "Update Lyrics" ON public.lyrics 
    FOR UPDATE USING (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('moderator')
    );

CREATE POLICY "Delete Lyrics" ON public.lyrics 
    FOR DELETE USING (
      auth.role() = 'authenticated' 
      AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
      AND public.has_role('admin')
    );

-- Políticas: lyric_play_stats
CREATE POLICY "Users can read play stats" ON public.lyric_play_stats 
    FOR SELECT USING (true);

CREATE POLICY "Users can insert play stats" ON public.lyric_play_stats 
    FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Users can update play stats" ON public.lyric_play_stats 
    FOR UPDATE TO authenticated USING (true);

-- =====================================================
-- 5. REALTIME E STORAGE
-- =====================================================

-- Adiciona user_roles à publicação de realtime
ALTER PUBLICATION supabase_realtime ADD TABLE public.user_roles;

-- Bucket de Storage 'audio'
INSERT INTO storage.buckets (id, name, public) 
VALUES ('audio', 'audio', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas do storage.objects para o bucket 'audio'
CREATE POLICY "Public Select Audio" ON storage.objects
    FOR SELECT TO public USING (bucket_id = 'audio');

CREATE POLICY "Upload Audio" ON storage.objects
    FOR INSERT TO authenticated WITH CHECK (
        bucket_id = 'audio' AND name ILIKE '%.mp3' AND public.has_role('user')
    );

CREATE POLICY "Update Audio" ON storage.objects
    FOR UPDATE TO authenticated USING (
        bucket_id = 'audio' AND public.has_role('moderator')
    );

CREATE POLICY "Delete Audio" ON storage.objects
    FOR DELETE TO authenticated USING (
        bucket_id = 'audio' AND public.has_role('admin')
    );

-- =====================================================
-- 6. BACKFILL DE ROLES
-- =====================================================
INSERT INTO public.user_roles (id, email, role)
SELECT id, email, 'user'
FROM auth.users
WHERE id NOT IN (SELECT id FROM public.user_roles)
ON CONFLICT (id) DO NOTHING;
