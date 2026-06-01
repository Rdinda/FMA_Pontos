-- Sync Contract — Fase A (002-sync-contract)
-- is_deleted, views sync_*, RLS leitura/escrita, RPC increment_play_count

-- =====================================================
-- T001 — is_deleted + índices updated_at
-- =====================================================

ALTER TABLE public.categories
  ADD COLUMN IF NOT EXISTS is_deleted boolean NOT NULL DEFAULT false;

ALTER TABLE public.lyrics
  ADD COLUMN IF NOT EXISTS is_deleted boolean NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_categories_updated_at
  ON public.categories (updated_at);

CREATE INDEX IF NOT EXISTS idx_lyrics_updated_at
  ON public.lyrics (updated_at);

-- =====================================================
-- T002 — views sync_* (owner bypasses RLS on base table)
-- =====================================================

CREATE OR REPLACE VIEW public.sync_categories
WITH (security_invoker = false) AS
SELECT
  id,
  name,
  code,
  updated_at,
  is_deleted
FROM public.categories;

CREATE OR REPLACE VIEW public.sync_lyrics
WITH (security_invoker = false) AS
SELECT
  id,
  category_id,
  title,
  content,
  audio_url,
  youtube_link,
  sequence_number,
  updated_at,
  is_deleted
FROM public.lyrics;

GRANT SELECT ON public.sync_categories TO anon, authenticated;
GRANT SELECT ON public.sync_lyrics TO anon, authenticated;

-- =====================================================
-- T003 — RLS: ocultar tombstones na leitura base; stats só via RPC
-- =====================================================

DROP POLICY IF EXISTS "Read Categories" ON public.categories;
CREATE POLICY "Read Categories" ON public.categories
  FOR SELECT USING (is_deleted = false);

DROP POLICY IF EXISTS "Read Lyrics" ON public.lyrics;
CREATE POLICY "Read Lyrics" ON public.lyrics
  FOR SELECT USING (is_deleted = false);

-- Escrita direta em lyric_play_stats: apenas RPC SECURITY DEFINER
REVOKE INSERT, UPDATE ON public.lyric_play_stats FROM authenticated;

DROP POLICY IF EXISTS "Users can insert play stats" ON public.lyric_play_stats;
DROP POLICY IF EXISTS "Users can update play stats" ON public.lyric_play_stats;

-- INSERT/UPDATE/DELETE em categories/lyrics: políticas baseline (20251226) já bloqueiam anônimo

-- =====================================================
-- T004 — RPC increment_play_count (garantir em prod)
-- =====================================================

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
