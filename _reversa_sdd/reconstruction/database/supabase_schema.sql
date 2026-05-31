-- Supabase Remote Schema for FMA_Pontos

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table: public.categories
CREATE TABLE public.categories (
    id text PRIMARY KEY,
    name text NOT NULL,
    code text UNIQUE NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now()
);

-- Table: public.lyrics
CREATE TABLE public.lyrics (
    id text PRIMARY KEY,
    category_id text NOT NULL REFERENCES public.categories(id),
    title text NOT NULL,
    content text NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    audio_url text,
    youtube_link text,
    sequence_number integer NOT NULL DEFAULT 0
);

-- Table: public.user_roles
CREATE TABLE public.user_roles (
    id uuid PRIMARY KEY, -- References auth.users(id)
    email text NOT NULL,
    role text NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'moderator', 'admin')),
    is_active boolean NOT NULL DEFAULT true,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

-- Table: public.lyric_play_stats
CREATE TABLE public.lyric_play_stats (
    lyric_id text PRIMARY KEY REFERENCES public.lyrics(id) ON DELETE CASCADE,
    play_count integer NOT NULL DEFAULT 0,
    last_played_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now()
);

-- Table: public.audit_logs
CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL PRIMARY KEY,
    table_name text NOT NULL,
    record_id text NOT NULL,
    action text NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
    old_data jsonb,
    new_data jsonb,
    user_id uuid,
    user_email text,
    created_at timestamp with time zone DEFAULT now()
);

-- Function: public.audit_trigger_func
CREATE OR REPLACE FUNCTION public.audit_trigger_func() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.audit_logs (table_name, record_id, action, old_data, new_data, user_id, user_email)
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

-- Triggers for Audit Logs
CREATE OR REPLACE TRIGGER audit_categories
    AFTER INSERT OR DELETE OR UPDATE ON public.categories
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE OR REPLACE TRIGGER audit_lyrics
    AFTER INSERT OR DELETE OR UPDATE ON public.lyrics
    FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

-- Helper Function for RBAC check
CREATE OR REPLACE FUNCTION public.has_role(required_role text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
    user_role text;
BEGIN
    SELECT role INTO user_role FROM public.user_roles WHERE id = auth.uid() AND is_active = true;
    IF user_role IS NULL THEN
        RETURN false;
    END IF;
    
    IF required_role = 'admin' THEN
        RETURN user_role = 'admin';
    ELSIF required_role = 'moderator' THEN
        RETURN user_role IN ('admin', 'moderator');
    ELSE
        RETURN user_role IN ('admin', 'moderator', 'user');
    END IF;
END;
$$;
