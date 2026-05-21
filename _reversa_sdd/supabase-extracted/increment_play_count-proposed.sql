-- Proposta: RPC ausente no backup de produção (2026-01-21)
-- Alinha com PlayStatsService.incrementPlayCount — hoje usa fallback manual

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
