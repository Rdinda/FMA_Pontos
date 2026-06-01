# Data Delta: 002-sync-contract

> Data: `2026-05-31`
> Baseline: `_reversa_sdd/database/data-dictionary.md`, `_reversa_sdd/sync-contract.md`, `lib/database/db_helper.dart` v5

## 1. Escopo

Delta conceitual sobre Postgres (Supabase), SQLite local e contratos de serialização Dart. Detalha migrations versionadas e upgrade local v5→v6.

## 2. Postgres / Supabase

### 2.1 Tabelas `public.categories` e `public.lyrics`

| Coluna | Antes | Depois | Migration |
|--------|-------|--------|-----------|
| `is_deleted` | **ausente** | `boolean NOT NULL DEFAULT false` | `20260531120000_sync_contract_phase_a.sql` |

**Índices novos:**

| Índice | Tabela | Coluna | Motivo |
|--------|--------|--------|--------|
| `idx_categories_updated_at` | `categories` | `updated_at` | PULL incremental + tombstones (RF-A02) |
| `idx_lyrics_updated_at` | `lyrics` | `updated_at` | idem |

**Campos removidos:** nenhum.

### 2.2 Views novas (SECURITY DEFINER)

| View | Definição resumida | Consumidor |
|------|-------------------|------------|
| `public.sync_categories` | `SELECT id, name, code, updated_at, is_deleted FROM categories` | `SupabaseService.fetchCategories(since:)` |
| `public.sync_lyrics` | `SELECT id, category_id, title, content, audio_url, youtube_link, sequence_number, updated_at, is_deleted FROM lyrics` | `SupabaseService.fetchLyrics(since:)` |

- `GRANT SELECT ON sync_categories, sync_lyrics TO anon, authenticated`
- Função owner com `SECURITY DEFINER` + `SET search_path = public`

### 2.3 RLS — policies alteradas

| Tabela | Policy | Mudança |
|--------|--------|---------|
| `categories` | `Read Categories` | `USING (is_deleted = false)` — oculta tombstones na leitura UI/PostgREST direto |
| `lyrics` | `Read Lyrics` | idem |
| `categories` | Insert/Update/Delete | Confirmar bloqueio JWT anônimo + `has_role` (baseline repo) |
| `lyrics` | Insert/Update/Delete | idem |
| `lyric_play_stats` | Insert/Update client | **Revogar** ou restringir; incremento só via RPC SECURITY DEFINER |

**Nota:** Escritas continuam nas **tabelas base**; apenas fetch incremental usa views.

### 2.4 RPC

| Função | Antes (prod backup) | Depois | Migration |
|--------|---------------------|--------|-----------|
| `increment_play_count(p_lyric_id text)` | Ausente | CREATE + GRANT EXECUTE TO authenticated | Fase A |

Assinatura alinhada a `_reversa_sdd/supabase-extracted/increment_play_count-proposed.sql`.

### 2.5 Objetos fora de escopo v1

| Objeto | Decisão |
|--------|---------|
| `increment_play_count_bulk` | Won't v1 (Q3) |
| Remoção MP3 Storage no soft delete | Won't v1 (Q2) |
| Cache local ranking offline | Won't v1 |

## 3. SQLite local (`lyrics_v4.db`)

### 3.1 Versão schema

| Antes | Depois | Trigger |
|-------|--------|---------|
| **5** | **6** | Fase C — `DatabaseHelper._upgradeDB` |

### 3.2 Tabela nova: `pending_access_events`

| Coluna | Tipo | Constraints | Papel |
|--------|------|-------------|-------|
| `id` | INTEGER | PK AUTOINCREMENT | Ordem FIFO flush |
| `lyric_id` | TEXT | NOT NULL | FK lógica → `lyrics.id` |
| `accessed_at` | TEXT | NOT NULL ISO8601 | Timestamp do acesso |
| `is_flushed` | INTEGER | DEFAULT 0 | 0=pendente, 1=enviado |

**Índice sugerido:** `(is_flushed, id)` para SELECT de pendentes.

### 3.3 Tabelas existentes — sem colunas novas

`categories` e `lyrics` mantêm schema v5. **Comportamento alterado:**

| Operação | Antes | Depois |
|----------|-------|--------|
| `upsertCategory/Lyric` | Força `is_deleted=0` | Preserva tombstone; não ressuscita (RF-B15) |

## 4. SharedPreferences

| Chave | Antes | Depois |
|-------|-------|--------|
| `last_sync_timestamp` | Avança após ciclo mesmo com falha parcial | Só persiste após PUSH+PULL sucesso (RN-06) |

**Novas chaves opcionais (Should):**

| Chave | Uso |
|-------|-----|
| `last_sync_error` | Persistir último erro para diagnóstico (opcional RF-B14) |
| `last_flush_stats_at` | Diagnóstico flush Fase C |

## 5. Modelos Dart

### `Category.toSupabaseMap()` / `Lyric.toSupabaseMap()`

| Campo | Antes | Depois |
|-------|-------|--------|
| `is_deleted` | omitido | incluído quando aplicável (RF-A04) |

### `fromMap` (remoto e local)

- Já lê `is_deleted` — sem mudança estrutural.

## 6. Migrações — inventário de arquivos

| Arquivo | Fase | Conteúdo |
|---------|------|----------|
| `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | A | `is_deleted`, índices, views sync_*, RLS SELECT/escrita, RPC |
| `supabase/migrations/20260531120100_sync_contract_rls_prod_audit.sql` | B (condicional) | Correções se prod ≠ repo (RF-B11) |
| `lib/database/db_helper.dart` `_upgradeDB` v6 | C | `CREATE TABLE pending_access_events` |

## 7. Rollback

| Camada | Estratégia |
|--------|------------|
| App Dart | Revert release; app antigo ignora views se ainda fetch em tabelas base |
| Postgres | Migrations forward-only; rollback manual: DROP VIEW, DROP COLUMN (perda tombstones históricos) |
| SQLite v6 | Downgrade não suportado; tabela `pending_access_events` ignorada por app antigo |

## 8. Resumo

```
Postgres colunas novas:     2 (is_deleted ×2 tabelas)
Postgres views novas:       2 (sync_categories, sync_lyrics)
Postgres RPC:               1 (increment_play_count — garantir prod)
SQLite tabelas novas:       1 (pending_access_events)
SQLite versão:              5 → 6
Campos Dart novos maps:     1 (is_deleted em toSupabaseMap)
Migrations SQL repo:        1–2 arquivos
```

Documentação pós-deploy: atualizar `_reversa_sdd/database/data-dictionary.md`, `relationships.md` se necessário.

## 9. Histórico

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial | reversa |
