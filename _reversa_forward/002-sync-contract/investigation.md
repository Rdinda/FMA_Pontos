# Investigation: 002-sync-contract

> Data: `2026-05-31`
> Requirements: `_reversa_forward/002-sync-contract/requirements.md`
> Âncora: `_reversa_sdd/sync-contract.md`

## 1. Objetivo da investigação

Validar o delta entre código legado, schema Postgres (backup 2026-01-21) e contrato normativo alvo; escolher padrões Supabase/Flutter para tombstones, LWW, RBAC no sync e fila offline de stats.

## 2. Estado atual do legado

### SyncRepository (`lib/services/sync_repository.dart`)

- Ciclo: `_pushPendingChanges` → PULL incremental → segundo PUSH → `last_sync_timestamp = now()` → download MP3.
- **Gap G7:** cursor avança no `try` mesmo se PULL falhar parcialmente (sem rollback).
- **Gap G5:** `_pushPendingChanges` não consulta `AuthService`; envia todas linhas `is_synced=0`.
- PULL trata `cat.isDeleted` / `lyric.isDeleted` com `hardDelete*` — correto localmente, mas remoto **não retorna** tombstones (sem coluna + SELECT policy futura filtrará).
- Conflitos dirty: delega a `SyncMerge.mergeCategory/mergeLyric` (merge por campo).

### SyncMerge (`lib/services/sync_merge.dart`)

- `_pickField` compara `updated_at` **por atributo**; `_maxDateTime` no `updated_at` merged.
- Diverge de RN-02 (LWW record-level): versões híbridas possíveis (título local + conteúdo remoto).

### SupabaseService (`lib/services/supabase_service.dart`)

- `fetchCategories/fetchLyrics`: `.from('categories'|'lyrics').select()` + `.gt('updated_at', since)`.
- `deleteCategory/deleteLyric`: UPDATE `is_deleted=true` — **Postgres rejeita ou ignora** coluna inexistente (G1).
- Fetch by id usa tabelas base (OK para LWW no PUSH).

### Models (`lib/models/category.dart`, `lib/models/lyric.dart`)

- `toSupabaseMap()` **omite** `is_deleted` (G10); `fromMap` já lê `is_deleted`.

### DatabaseHelper (`lib/database/db_helper.dart`)

- Versão **5**; `is_deleted` local presente.
- `upsertCategory/upsertLyric`: forçam `'is_deleted': 0` no map (G9) — risco de ressuscitar tombstone.

### PlayStatsService (`lib/services/play_stats_service.dart`)

- Online: RPC `increment_play_count` + fallback SELECT/INSERT/UPDATE direto em `lyric_play_stats`.
- Offline: falha silenciosa (`debugPrint`) — **sem fila** (G3).
- RPC ausente em prod backup (G4); presente no repo `20251226191350_initial_schema.sql`.

### AuthService (`lib/services/auth_service.dart`)

- Getters `canAddLyrics`, `canEditLyrics`, etc. implementados via `hasRole`.
- `isAnonymous` quando user null ou JWT anônimo.
- **Sem** `syncData()` pós-login Google (G12).

### Telas com bypass anônimo

- `lyric_view_screen.dart`, `category_screen.dart`: padrão `canEditLyrics || isAnonymous` (G5) — permite edição local anônima.

### Postgres (`supabase/migrations/20251226191350_initial_schema.sql`)

| Objeto | Estado repo | Prod backup |
|--------|-------------|-------------|
| `categories.is_deleted` | Ausente | Ausente |
| `lyrics.is_deleted` | Ausente | Ausente |
| RLS escrita | `has_role` + bloqueio JWT anônimo | 🟡 pode divergir |
| `increment_play_count` | Definida + GRANT authenticated | Ausente |
| `lyric_play_stats` INSERT/UPDATE | Policy permissiva `WITH CHECK (true)` | Idem |

## 3. Alternativas avaliadas

### Q1 — Fetch incremental com tombstones pós-RLS

| Alternativa | Prós | Contras | Decisão |
|-------------|------|---------|---------|
| A. Views `sync_*` SECURITY DEFINER | UI pública filtrada; sync inclui tombstones; anon key lê view | Manutenção de views | **Escolhida** (clarify Q1) |
| B. Policy SELECT extra `authenticated` em tabelas base | Sem views | Anônimo precisa de policy complexa; tombstones expostos se policy errada | Descartada |
| C. Service role no client | Simples | **Inaceitável** — expõe secret | Descartada |

Referência: [Supabase RLS — security definer functions](https://supabase.com/docs/guides/database/postgres/row-level-security#use-security-definer-functions).

### Q2 — Resolução de conflito

| Alternativa | Prós | Contras | Decisão |
|-------------|------|---------|---------|
| A. LWW record-level | Simples; previsível; alinhado stakeholder | Perde merge parcial útil em teoria | **Escolhida** |
| B. Merge por campo (legado) | Preserva campos não conflitantes | Snapshots inconsistentes; decisão rejeitada | Descartada |
| C. CRDT / OT | Merge automático robusto | Over-engineering para acervo editorial | Descartada |

### Q3 — Flush stats offline

| Alternativa | Prós | Contras | Decisão |
|-------------|------|---------|---------|
| A. N × RPC `increment_play_count` | Idempotente por evento; RPC já existe | Latência com fila grande | **Escolhida v1** |
| B. Batch RPC `increment_play_count_bulk` | Performance | Nova função SQL; escopo extra | Won't v1 |
| C. INSERT direto client | Sem RPC | Bypassa RLS; inseguro | Descartada |

### Q4 — Gate stats offline

| Alternativa | Decisão |
|-------------|---------|
| Só autenticados não anônimos enfileiram | **Escolhida** |
| Todos enfileiram (incl. anônimo) | Descartada |

## 4. Padrões aplicáveis

- **Offline-first sync:** PUSH pending → PULL since cursor → reconcile (Martin Kleppmann / ADR 001).
- **Tombstone sync:** soft delete remoto com `updated_at` bump; PULL propaga delete terminal (RN-07).
- **SECURITY DEFINER views:** canal de leitura elevada só para sync incremental; GRANT SELECT a `anon` e `authenticated`.
- **Flutter Provider:** `SyncRepository` already `ChangeNotifier`; novos getters notificam UI admin/debug.
- **sqflite migration:** `_upgradeDB(oldVersion, newVersion)` pattern existente em `db_helper.dart`.

## 5. Evidências externas

| Fonte | Uso |
|-------|-----|
| `_reversa_sdd/sync-contract.md` | Contrato normativo completo |
| `db_cluster-21-01-2026@04-10-08.backup` | Estado prod sem `is_deleted` e sem RPC |
| `_reversa_sdd/database/data-dictionary.md` | Baseline colunas e gaps |
| `_reversa_sdd/adrs/001-offline-first-sync-soft-delete.md` | Soft delete local |
| `_reversa_sdd/permissions.md` | Matriz RBAC |
| `_reversa_sdd/openapi/supabase-consumed-surfaces.md` | Superfícies PostgREST afetadas |

## 6. Conclusões para implementação

1. **Fase A primeiro** — sem `is_deleted` remoto, delete PUSH é no-op/falha; stats RPC necessária antes flush Fase C.
2. **Views sync_*** são pré-requisito antes de RLS SELECT filtrar tombstones na tabela base.
3. **LWW** pode eliminar grande parte de `SyncMerge` ou reduzi-lo a helpers de comparação `updated_at`.
4. **Auth gate** deve ocorrer em dois pontos: UI (remover bypass) + `SyncRepository` wrappers e `_pushPendingChanges`.
5. **Testes** prioritários: LWW two-device simulado (mock Supabase), flush fila stats, bloqueio anônimo.

## 7. Histórico

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial | reversa |
