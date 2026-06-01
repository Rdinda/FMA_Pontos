# Actions: Contrato de Sincronização (Sync Contract)

> Identificador: `002-sync-contract`
> Data: `2026-05-31`
> Roadmap: `_reversa_forward/002-sync-contract/roadmap.md`

## Resumo

| Métrica | Valor |
|---------|-------|
| Total de ações | 37 |
| Paralelizáveis (`[//]`) | 9 |
| Maior cadeia de dependência | 16 (T001 → T002 → T003 → T004 → T005 → T007 → T008 → T010 → T011 → T012 → T013 → T021 → T029 → T030 → T031 → T032) |

## Fase 1, Preparação

> Milestone **M1** — Postgres (`is_deleted`, views `sync_*`, RLS escrita, RPC stats).

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T001 | Migration Fase A: adicionar `is_deleted` em `categories`/`lyrics` + índices `updated_at` (RF-A01, RF-A02) | - | - | `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | 🟢 | `[X]` |
| T002 | Na mesma migration: criar views `sync_categories`/`sync_lyrics` SECURITY DEFINER + `GRANT SELECT` anon/authenticated (RF-A03) | T001 | - | `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | 🟢 | `[X]` |
| T003 | Na mesma migration: policies SELECT com `is_deleted=false`; INSERT/UPDATE/DELETE RBAC; revogar INSERT anônimo; restringir escrita direta em `lyric_play_stats` (RF-A07) | T002 | - | `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | 🟢 | `[X]` |
| T004 | Na mesma migration: `CREATE OR REPLACE` RPC `increment_play_count` + `GRANT EXECUTE` authenticated (RF-A06) | T003 | - | `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | 🟢 | `[X]` |
| T005 | `Category.toSupabaseMap()` inclui `is_deleted` quando aplicável (RF-A04) | T004 | `[//]` | `lib/models/category.dart` | 🟢 | `[X]` |
| T006 | `Lyric.toSupabaseMap()` inclui `is_deleted` quando aplicável (RF-A04) | T004 | `[//]` | `lib/models/lyric.dart` | 🟢 | `[X]` |
| T007 | `SupabaseService.fetchCategories`/`fetchLyrics` consultam views `sync_*`; `fromMap` desserializa `is_deleted` remoto (RF-A03, RF-A05) | T005, T006 | - | `lib/services/supabase_service.dart` | 🟢 | `[X]` |
| T008 | `SyncRepository`: PULL de tombstone remoto (`is_deleted=true`) dispara `hardDelete*` local; PUSH soft delete propaga (RF-A05) | T007 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |

## Fase 2, Testes

> Estrutura e cenários de `RF-C07`; implementação completa após núcleo Fase C.

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T009 | Criar `play_stats_sync_test.dart` com mocks de sessão/rede e casos: anônimo offline não enfileira; autenticado enfileira (esqueleto) | T004 | - | `test/unit/play_stats_sync_test.dart` | 🟡 | `[X]` |

## Fase 3, Núcleo

### 3a — Milestone **M2** (LWW, gate Auth/RBAC, cursor, upsert)

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T010 | Substituir merge por campo por LWW record-level em `SyncMerge` (snapshot inteiro vence por `updated_at`) (RF-B01) | T008 | `[//]` | `lib/services/sync_merge.dart` | 🟢 | `[X]` |
| T011 | `syncData`: PUSH-first — todos `is_synced=0` antes de qualquer PULL (RF-B02) | T010 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T012 | PULL: não sobrescrever dirty local quando `local.updated_at > remote.updated_at` (RF-B03) | T011 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T013 | Validar/garantir segundo PUSH após PULL que re-marca pendentes (RF-B04) | T012 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T014 | Injetar `AuthService` em `SyncRepository` (construtor/DI) para gates `can*`/`isAnonymous` (D-10) | T008 | `[//]` | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T015 | `_pushPendingChanges`: ignorar linhas se anônimo, sem `can*` da operação ou `is_active=false` (RF-B05, RF-B08, RF-B09) | T014 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T016 | Wrappers `add*`/`update*`/`delete*`: validar permissão antes de `is_synced=0` (RF-B06) | T015 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T017 | Remover `\|\| isAnonymous` do gate de edição em `LyricViewScreen` (RF-B07) | T014 | `[//]` | `lib/screens/lyric_view_screen.dart` | 🟢 | `[X]` |
| T018 | Remover `\|\| isAnonymous` do gate de edição em `CategoryScreen` (RF-B07) | T014 | `[//]` | `lib/screens/category_screen.dart` | 🟢 | `[X]` |
| T019 | Preservar invariante `local_audio_path` no PULL quando `audio_url` inalterada; invalidar se URL mudou (RF-B10) | T012 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T020 | Cursor seguro: `last_sync_timestamp` só após PUSH+PULL completos com sucesso (RF-B12) | T013 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T021 | Getters `pendingCategoriesCount`, `pendingLyricsCount`, `lastSyncAt`, `lastSyncError` (RF-B13, RF-B14) | T020 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T022 | Substituir falhas silenciosas de sync por estado observável (`lastSyncError`, sem avanço de cursor) (RF-B14) | T020 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T023 | `DatabaseHelper.upsertCategory`/`upsertLyric`: não forçar `is_deleted=0` em tombstone (RF-B15) | - | `[//]` | `lib/database/db_helper.dart` | 🟢 | `[X]` |
| T024 | `AuthService`: disparar `syncData()` após login Google bem-sucedido (RF-B16) | T015 | - | `lib/services/auth_service.dart` | 🟢 | `[X]` |
| T025 | Garantir PULL sem gate editorial para anônimo e autenticado (RF-B17) | T015 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |

### 3b — Milestone **M3** (fila offline stats + flush)

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T026 | SQLite v6: tabela `pending_access_events` + índice `(is_flushed, id)` em `_upgradeDB` (RF-C01) | T023 | - | `lib/database/db_helper.dart` | 🟢 | `[X]` |
| T027 | Offline: `incrementAccessCount` enfileira só sessão autenticada não anônima (RF-C02) | T026 | - | `lib/services/play_stats_service.dart` | 🟢 | `[X]` |
| T028 | Online: manter RPC `increment_play_count` para autenticados não anônimos; remover/evitar fallback INSERT direto em `lyric_play_stats` (RF-C03) | T004, T027 | - | `lib/services/play_stats_service.dart` | 🟢 | `[X]` |
| T029 | Implementar `flushPendingAccessEvents()`: N RPCs individuais, marcar `is_flushed=1` (RF-C04, RF-C05) | T028 | - | `lib/services/play_stats_service.dart` | 🟢 | `[X]` |
| T030 | `SyncRepository`: chamar flush após PUSH acervo e antes do PULL (RN-09) | T029, T013 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T031 | Flush na reconexão via `syncData`/`_initConnectivity` existente (RN-09) | T030 | - | `lib/services/sync_repository.dart` | 🟢 | `[X]` |
| T032 | Expor `pendingAccessEventsCount` para diagnóstico (RF-C06) | T029 | - | `lib/services/play_stats_service.dart` | 🟢 | `[X]` |
| T033 | Completar testes: enqueue offline → flush → `play_count`; bloqueio anônimo (RF-C07) | T009, T027, T029, T031 | - | `test/unit/play_stats_sync_test.dart` | 🟡 | `[X]` |

## Fase 4, Integração

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T034 | Migration corretiva RLS prod se auditoria pós-deploy divergir de RF-A07 (RF-B11) | T004 | - | `supabase/migrations/20260531120100_sync_contract_rls_prod_audit.sql` | 🟡 | `[X]` |
| T035 | Validar contratos PostgREST: fetch incremental `sync_*`, RPC stats, mutações RLS (smoke manual conforme `interfaces/*`) | T008, T030 | - | `_reversa_forward/002-sync-contract/smoke-checklist.md` | 🟢 | `[X]` |

## Fase 5, Polimento

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T036 | Atualizar `architecture-contract.md` seção S-04 para LWW record-level (RF-B18) | T010 | `[//]` | `_reversa_sdd/architecture-contract.md` | 🟢 | `[X]` |
| T037 | Atualizar `data-dictionary.md` com `is_deleted`, views `sync_*`, RPC e `pending_access_events` pós-deploy (M1.8) | T004, T026 | `[//]` | `_reversa_sdd/database/data-dictionary.md` | 🟡 | `[X]` |

## Notas de execução

<!--
Reservado para /reversa-coding.
-->

### Ordem sugerida para agente único

1. **M1 Postgres:** T001 → T002 → T003 → T004 (aplicar migration staging/prod antes do app que usa views).
2. **M1 Dart:** T005 ∥ T006 → T007 → T008.
3. **M2 núcleo:** T010 ∥ T014 → T011 → T012 → T019 → T013 → T020 → T021 → T022; T015 → T016 → T024 → T025; T017 ∥ T018; T023 cedo se conflito tombstone local.
4. **M3 stats:** T026 → T027 → T028 → T029 → T030 → T031 → T032; T033 fecha RF-C07.
5. **Integração/polimento:** T034 (condicional), T035 smoke; T036 ∥ T037.

### Milestones ↔ tarefas

| Milestone | Tarefas |
|-----------|---------|
| M1 Fase A | T001–T008, T037 (doc) |
| M2 Fase B | T010–T025, T034, T036 |
| M3 Fase C | T026–T033, T009 |

### Grupos paralelos seguros (após dependências satisfeitas)

| Grupo | Tarefas | Condição |
|-------|---------|----------|
| G1 | T005, T006 | Após T004 |
| G2 | T010, T014 | Após T008 |
| G3 | T017, T018 | Após T014 |
| G4 | T036, T037 | Após T010 / T026 respectivamente |

### Interfaces de referência

| Tarefa | Contrato |
|--------|----------|
| T007, T035 | `interfaces/sync-incremental-fetch.md` |
| T004, T028, T029 | `interfaces/increment_play_count.md` |
| T003, T015, T035 | `interfaces/acervo-mutations-rls.md` |

## Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial gerada por `/reversa-to-do` | reversa |
