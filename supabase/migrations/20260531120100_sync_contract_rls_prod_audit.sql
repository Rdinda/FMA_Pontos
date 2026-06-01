-- Sync Contract — auditoria RLS pós Fase A (RF-B11)
-- Idempotente: reforça revogações e políticas alinhadas ao RF-A07

REVOKE INSERT, UPDATE, DELETE ON public.categories FROM anon;
REVOKE INSERT, UPDATE, DELETE ON public.lyrics FROM anon;
REVOKE INSERT, UPDATE, DELETE ON public.lyric_play_stats FROM anon;

-- Garantir leitura pública só de registros ativos (tabelas base; views sync_* incluem tombstones)
DROP POLICY IF EXISTS "Read Categories" ON public.categories;
CREATE POLICY "Read Categories" ON public.categories
  FOR SELECT USING (is_deleted = false);

DROP POLICY IF EXISTS "Read Lyrics" ON public.lyrics;
CREATE POLICY "Read Lyrics" ON public.lyrics
  FOR SELECT USING (is_deleted = false);

-- Stats: somente leitura anon/authenticated; escrita via RPC SECURITY DEFINER
REVOKE INSERT, UPDATE ON public.lyric_play_stats FROM authenticated;

DROP POLICY IF EXISTS "Users can insert play stats" ON public.lyric_play_stats;
DROP POLICY IF EXISTS "Users can update play stats" ON public.lyric_play_stats;
