-- Lacunas Reversa (Roberto 2026-05-20): audit_logs, RPC play count, is_active, RLS anon

-- 1. Coluna is_active em user_roles
ALTER TABLE public.user_roles
  ADD COLUMN IF NOT EXISTS is_active boolean NOT NULL DEFAULT true;

-- 2. Remover INSERT anônimo (apenas autenticados escrevem)
DROP POLICY IF EXISTS "allow anon insert" ON public.categories;
DROP POLICY IF EXISTS "allow anon insert" ON public.lyrics;

-- 3. audit_logs (produção — versionar no repo)
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

CREATE OR REPLACE FUNCTION public.audit_trigger_func() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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

DROP TRIGGER IF EXISTS audit_categories ON public.categories;
CREATE TRIGGER audit_categories
    AFTER INSERT OR DELETE OR UPDATE ON public.categories
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

DROP TRIGGER IF EXISTS audit_lyrics ON public.lyrics;
CREATE TRIGGER audit_lyrics
    AFTER INSERT OR DELETE OR UPDATE ON public.lyrics
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

GRANT SELECT ON public.audit_logs TO authenticated;

-- 4. RPC increment_play_count
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
