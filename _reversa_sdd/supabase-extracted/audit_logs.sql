-- Extraído de db_cluster-21-01-2026@04-10-08.backup (produção, 2026-01-21)
-- Fonte: backup indicado por Roberto — validação Pergunta 2

CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
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

CREATE FUNCTION public.audit_trigger_func() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
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

CREATE TRIGGER audit_categories
    AFTER INSERT OR DELETE OR UPDATE ON public.categories
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER audit_lyrics
    AFTER INSERT OR DELETE OR UPDATE ON public.lyrics
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

-- ACL (backup): GRANT SELECT ON audit_logs TO authenticated, anon;
-- INSERT via trigger SECURITY DEFINER; clientes não inserem diretamente.
