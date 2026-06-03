-- Favoritos por usuário (Gostei) — apenas contas não anônimas via RLS

CREATE TABLE IF NOT EXISTS public.user_favorites (
  user_id uuid NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
  lyric_id text NOT NULL REFERENCES public.lyrics (id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, lyric_id)
);

CREATE INDEX IF NOT EXISTS idx_user_favorites_user_id
  ON public.user_favorites (user_id);

ALTER TABLE public.user_favorites ENABLE ROW LEVEL SECURITY;

-- Bloqueia sessão anônima do Supabase; só login Google/email real
CREATE POLICY "user_favorites_select_own"
  ON public.user_favorites
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid()
    AND coalesce((auth.jwt () ->> 'is_anonymous')::boolean, false) = false
  );

CREATE POLICY "user_favorites_insert_own"
  ON public.user_favorites
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = auth.uid()
    AND coalesce((auth.jwt () ->> 'is_anonymous')::boolean, false) = false
  );

CREATE POLICY "user_favorites_delete_own"
  ON public.user_favorites
  FOR DELETE
  TO authenticated
  USING (
    user_id = auth.uid()
    AND coalesce((auth.jwt () ->> 'is_anonymous')::boolean, false) = false
  );

GRANT SELECT, INSERT, DELETE ON public.user_favorites TO authenticated;
