# Estatísticas / Mais Tocados — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Tabela `lyric_play_stats` com PK `lyric_id` FK para `lyrics`.
- [ ] 🟢 RLS: SELECT público; INSERT/UPDATE para `authenticated`.
- [ ] 🟢 Índice em `play_count DESC`.
- [ ] 🔴 Função RPC `increment_play_count(p_lyric_id)` (recomendado).
- [ ] 🟢 `AudioPlayerService` integrado ao app.
- [ ] 🟢 `DatabaseHelper.getLyricById` e `readAllCategories`.
- [ ] 🟢 Supabase inicializado; sessão (incl. anônima) para mutações.

## Tarefas — Backend

- [ ] T-01, Criar tabela `lyric_play_stats`
  - Origem no legado: `supabase/supabase_schema.sql`
  - Critério de pronto: colunas `lyric_id`, `play_count`, `last_played_at`, `updated_at`; ON DELETE CASCADE.
  - Confiança: 🟢

- [ ] T-02, Configurar RLS e policies de leitura/escrita
  - Origem no legado: schema SQL
  - Critério de pronto: SELECT `true`; INSERT/UPDATE authenticated.
  - Confiança: 🟢

- [ ] T-03, Criar índice de ranking
  - Origem no legado: `idx_lyric_play_stats_count`
  - Critério de pronto: btree em `play_count DESC`.
  - Confiança: 🟢

- [ ] T-04, Implementar RPC `increment_play_count` (lacuna)
  - Origem no legado: chamada em `play_stats_service.dart`; SQL ausente
  - Critério de pronto: upsert atômico incrementando contador e timestamps.
  - Confiança: 🔴

## Tarefas — PlayStatsService

- [ ] T-05, Implementar modelos `LyricPlayStats` e `LyricWithStats`
  - Origem no legado: `play_stats_service.dart`
  - Critério de pronto: `fromMap` com `lyric_id`, `play_count`, `last_played_at`.
  - Confiança: 🟢

- [ ] T-06, Implementar `incrementPlayCount` com RPC
  - Origem no legado: `play_stats_service.dart`
  - Critério de pronto: `rpc('increment_play_count', params: {p_lyric_id})`; catch chama fallback.
  - Confiança: 🟢

- [ ] T-07, Implementar `_incrementPlayCountFallback`
  - Origem no legado: `play_stats_service.dart`
  - Critério de pronto: select maybeSingle; update +1 ou insert com count=1; não relança erro.
  - Confiança: 🟢

- [ ] T-08, Implementar `getTopPlayed`
  - Origem no legado: `play_stats_service.dart`
  - Critério de pronto: query ordenada; join local por `getLyricById`; mapa de categorias; omitir lyrics ausentes.
  - Confiança: 🟢

- [ ] T-09, Implementar `getPlayCount` (opcional UI)
  - Origem no legado: `play_stats_service.dart`
  - Critério de pronto: retorna `play_count` ou 0; catch retorna 0.
  - Confiança: 🟡

## Tarefas — Integração Áudio

- [ ] T-10, Registrar incremento em `AudioPlayerService.play`
  - Origem no legado: `audio_player_service.dart` após `playMediaItem`
  - Critério de pronto: só quando `lyric.id` diferente da atual.
  - Confiança: 🟢

- [ ] T-11, Registrar incremento em `_playCurrentTrack`
  - Origem no legado: `audio_player_service.dart`
  - Critério de pronto: cada faixa de playlist incrementa ao iniciar.
  - Confiança: 🟢

## Tarefas — TopPlayedScreen

- [ ] T-12, Implementar carregamento inicial e estados
  - Origem no legado: `top_played_screen.dart`
  - Critério de pronto: loading, erro com retry, empty state, lista com refresh.
  - Confiança: 🟢

- [ ] T-13, Implementar lista ranqueada com destaque top 3
  - Origem no legado: `_buildLyricTile`
  - Critério de pronto: medalhas ranks 1-3; número para demais; highlight faixa atual.
  - Confiança: 🟢

- [ ] T-14, Implementar play/pause por item
  - Origem no legado: trailing IconButton + `AudioPlayerService`
  - Critério de pronto: play se não atual; pause se atual e playing.
  - Confiança: 🟢

- [ ] T-15, Implementar play all e snackbar
  - Origem no legado: `_playAllTopPlayed`
  - Critério de pronto: filtra com áudio; `playAll`; mensagem de quantidade ou erro se vazio.
  - Confiança: 🟢

- [ ] T-16, Implementar navegação para letra
  - Origem no legado: `onTap` → `LyricViewScreen`
  - Critério de pronto: passa `item.lyric`.
  - Confiança: 🟢

- [ ] T-17, Incluir `CategoryPlayerWidget` no rodapé
  - Origem no legado: `Column` body
  - Critério de pronto: player visível quando playlist ativa.
  - Confiança: 🟢

## Tarefas — Navegação

- [ ] T-18, Adicionar entrada Mais Tocados na Home
  - Origem no legado: `home_screen.dart` index 2
  - Critério de pronto: `Navigator.push(TopPlayedScreen())`.
  - Confiança: 🟢

## Ordem sugerida

1. T-01 → T-04 (Supabase)
2. T-05 → T-09 (PlayStatsService)
3. T-10 → T-11 (áudio)
4. T-12 → T-17 (UI)
5. T-18 (Home)
