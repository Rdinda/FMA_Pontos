# Legacy Impact: 002-sync-contract

> Data: `2026-05-31`
> Feature: `002-sync-contract`
> Rodada: M1 Fase A (T001–T008)

## Tabela de impacto

| Arquivo afetado | Componente (`architecture.md`) | Tipo | Severidade | Justificativa |
|-----------------|--------------------------------|------|------------|---------------|
| `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | Supabase Postgres | `delta-de-dados` | **CRITICAL** | Colunas `is_deleted`, views `sync_*`, RLS leitura e bloqueio escrita stats |
| `lib/models/category.dart` | Domain Models | `delta-de-contrato-externo` | **HIGH** | `toSupabaseMap` passa a enviar `is_deleted` no PUSH |
| `lib/models/lyric.dart` | Domain Models | `delta-de-contrato-externo` | **HIGH** | idem |
| `lib/services/supabase_service.dart` | Sync / SupabaseService | `regra-alterada` | **HIGH** | PULL incremental usa `sync_categories`/`sync_lyrics` |
| `lib/services/sync_repository.dart` | Sync | `regra-alterada` | **MEDIUM** | Comportamento tombstone já existente; validado contra RF-A05 |

## Diff conceitual por componente

### Supabase Postgres

- Acervo remoto ganha soft delete explícito (`is_deleted`) alinhado ao SQLite.
- Leitura UI/PostgREST nas tabelas base oculta tombstones; canal de sync lê tombstones via views.
- Incremento de plays deixa de aceitar INSERT/UPDATE client em `lyric_play_stats`; caminho oficial é RPC `increment_play_count`.

### SupabaseService

- `fetchCategories`/`fetchLyrics` (incremental) apontam para views; requer migration deployada (404 se ausente).

### Modelos Category/Lyric

- Payload de upsert inclui `is_deleted`, permitindo propagar estado de exclusão lógica no remoto.

## Preservadas

- 🟢 Offline-first: SQLite continua fonte operacional imediata.
- 🟢 Filtro local `is_deleted = 0` em listagens.
- 🟢 RBAC client (`AuthService.can*`) inalterado nesta rodada.
- 🟢 `Category.fromMap` / `Lyric.fromMap` já liam `is_deleted`.
- 🟢 Push/pull com `last_sync_timestamp` (comportamento legado mantido até M2).
- 🟢 Fallback de stats em `PlayStatsService` permanece até Fase C restringir client-side.

## Modificadas

- 🟢 **Pull incremental** — passa a depender de views `sync_*` e de `is_deleted` remoto (antes: tabelas base sem coluna remota).
- 🟢 **Soft delete remoto** — deixou de ser no-op/falha silenciosa; coluna e mapas Dart alinhados.
- 🟢 **Estatísticas** — escrita direta em `lyric_play_stats` revogada no Postgres após deploy; app ainda tem fallback até T028.
