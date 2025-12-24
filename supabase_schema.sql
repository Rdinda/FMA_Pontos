-- 1. Tabela de Categorias
CREATE TABLE IF NOT EXISTS public.categories (
    id text NOT NULL PRIMARY KEY,
    name text NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- 2. Tabela de Letras (Lyrics)
CREATE TABLE IF NOT EXISTS public.lyrics (
    id text NOT NULL PRIMARY KEY,
    category_id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    -- audio_url adicionado via ALTER abaixo para garantir migração
    
    CONSTRAINT lyrics_category_id_fkey 
        FOREIGN KEY (category_id) 
        REFERENCES public.categories(id)
        ON DELETE CASCADE
);

-- Migração: Adicionar coluna audio_url se não existir
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='lyrics' AND column_name='audio_url') THEN
        ALTER TABLE public.lyrics ADD COLUMN audio_url text;
    END IF;
END $$;

-- Restrição: Permitir apenas arquivos MP3 (verifica a extensão na URL)
ALTER TABLE public.lyrics DROP CONSTRAINT IF EXISTS check_audio_mp3;
ALTER TABLE public.lyrics ADD CONSTRAINT check_audio_mp3 CHECK (audio_url IS NULL OR audio_url ILIKE '%.mp3');

-- =====================================================
-- TABELA DE ROLES DE USUÁRIO
-- Roles: 'user', 'moderator', 'admin'
-- user: pode adicionar letras
-- moderator: pode adicionar/editar categorias e letras
-- admin: pode tudo (incluindo deletar)
-- =====================================================
CREATE TABLE IF NOT EXISTS public.user_roles (
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email text NOT NULL,
    role text NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'moderator', 'admin')),
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Índice para busca por email
CREATE INDEX IF NOT EXISTS idx_user_roles_email ON public.user_roles(email);

-- Função para obter role do usuário atual
CREATE OR REPLACE FUNCTION public.get_user_role()
RETURNS text AS $$
BEGIN
  RETURN COALESCE(
    (SELECT role FROM public.user_roles WHERE id = auth.uid()),
    'user'  -- default para novos usuários
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Função para verificar se usuário tem pelo menos a role especificada
CREATE OR REPLACE FUNCTION public.has_role(required_role text)
RETURNS boolean AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RLS para user_roles (apenas admin pode gerenciar, usuários podem ver a própria)
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own role" ON public.user_roles;
CREATE POLICY "Users can view own role" ON public.user_roles
FOR SELECT USING (id = auth.uid());

DROP POLICY IF EXISTS "Admins can manage roles" ON public.user_roles;
CREATE POLICY "Admins can manage roles" ON public.user_roles
FOR ALL USING (public.has_role('admin'));

-- Índices para categories e lyrics
CREATE INDEX IF NOT EXISTS idx_lyrics_category_id ON public.lyrics(category_id);

-- Permissões (RLS)
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lyrics ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- POLÍTICAS DE ACESSO - Categories
-- Leitura: Pública (todos podem ver)
-- INSERT/UPDATE: moderator ou admin
-- DELETE: apenas admin
-- =====================================================

DROP POLICY IF EXISTS "Public Access Categories" ON public.categories;

-- SELECT: Público
DROP POLICY IF EXISTS "Read Categories" ON public.categories;
CREATE POLICY "Read Categories" ON public.categories 
FOR SELECT USING (true);

-- INSERT: Moderator ou Admin (não anônimos)
DROP POLICY IF EXISTS "Insert Categories" ON public.categories;
CREATE POLICY "Insert Categories" ON public.categories 
FOR INSERT WITH CHECK (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('moderator')
);

-- UPDATE: Moderator ou Admin
DROP POLICY IF EXISTS "Update Categories" ON public.categories;
CREATE POLICY "Update Categories" ON public.categories 
FOR UPDATE USING (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('moderator')
);

-- DELETE: Apenas Admin
DROP POLICY IF EXISTS "Delete Categories" ON public.categories;
CREATE POLICY "Delete Categories" ON public.categories 
FOR DELETE USING (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('admin')
);

-- =====================================================
-- POLÍTICAS DE ACESSO - Lyrics
-- Leitura: Pública (todos podem ver)
-- INSERT: user, moderator ou admin
-- UPDATE: moderator ou admin
-- DELETE: apenas admin
-- =====================================================

DROP POLICY IF EXISTS "Public Access Lyrics" ON public.lyrics;

-- SELECT: Público
DROP POLICY IF EXISTS "Read Lyrics" ON public.lyrics;
CREATE POLICY "Read Lyrics" ON public.lyrics 
FOR SELECT USING (true);

-- INSERT: User, Moderator ou Admin (não anônimos)
DROP POLICY IF EXISTS "Insert Lyrics" ON public.lyrics;
CREATE POLICY "Insert Lyrics" ON public.lyrics 
FOR INSERT WITH CHECK (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('user')
);

-- UPDATE: Moderator ou Admin
DROP POLICY IF EXISTS "Update Lyrics" ON public.lyrics;
CREATE POLICY "Update Lyrics" ON public.lyrics 
FOR UPDATE USING (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('moderator')
);

-- DELETE: Apenas Admin
DROP POLICY IF EXISTS "Delete Lyrics" ON public.lyrics;
CREATE POLICY "Delete Lyrics" ON public.lyrics 
FOR DELETE USING (
  auth.role() = 'authenticated' 
  AND (auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE
  AND public.has_role('admin')
);


-- 3. Configuração do Storage (Bucket 'audio')
-- Garante que o bucket existe
INSERT INTO storage.buckets (id, name, public) 
VALUES ('audio', 'audio', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas de Storage para o bucket 'audio'

-- SELECT: Público
DROP POLICY IF EXISTS "Public Select Audio" ON storage.objects;
CREATE POLICY "Public Select Audio" ON storage.objects
FOR SELECT TO public
USING (bucket_id = 'audio');

-- INSERT: User, Moderator ou Admin
DROP POLICY IF EXISTS "Upload Audio" ON storage.objects;
DROP POLICY IF EXISTS "Upload MP3 Only" ON storage.objects;
CREATE POLICY "Upload Audio" ON storage.objects
FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'audio' AND name ILIKE '%.mp3' AND public.has_role('user'));

-- UPDATE: Moderator ou Admin
DROP POLICY IF EXISTS "Update Audio" ON storage.objects;
DROP POLICY IF EXISTS "Public Manage Audio" ON storage.objects;
CREATE POLICY "Update Audio" ON storage.objects
FOR UPDATE TO authenticated
USING (bucket_id = 'audio' AND public.has_role('moderator'));

-- DELETE: Apenas Admin
DROP POLICY IF EXISTS "Delete Audio" ON storage.objects;
CREATE POLICY "Delete Audio" ON storage.objects
FOR DELETE TO authenticated
USING (bucket_id = 'audio' AND public.has_role('admin'));

-- =====================================================
-- AUTOMAÇÃO DE ROLES
-- =====================================================

-- Trigger para criar user_roles automaticamente quando um usuário se registra
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.user_roles (id, email, role)
  VALUES (new.id, new.email, 'user')
  ON CONFLICT (id) DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Remove a trigger se já existir para recriar
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Policy de Backup: Permitir que o próprio usuário crie sua role 'user' via API (caso a trigger falhe)
DROP POLICY IF EXISTS "Users can create own user role" ON public.user_roles;
CREATE POLICY "Users can create own user role" ON public.user_roles
FOR INSERT TO authenticated
WITH CHECK (auth.uid() = id AND role = 'user');

-- =====================================================
-- HABILITAR REALTIME
-- =====================================================
-- Importante: Isso precisa ser rodado para que o app receba atualizações de roles em tempo real.
-- Verifique se 'supabase_realtime' está na lista de publicações ativas.

ALTER PUBLICATION supabase_realtime ADD TABLE public.user_roles;

-- =====================================================
-- CORREÇÃO (BACKFILL)
-- Insere roles para usuários que já existem mas não têm registro em user_roles
-- =====================================================
INSERT INTO public.user_roles (id, email, role)
SELECT id, email, 'user'
FROM auth.users
WHERE id NOT IN (SELECT id FROM public.user_roles)
ON CONFLICT (id) DO NOTHING;
