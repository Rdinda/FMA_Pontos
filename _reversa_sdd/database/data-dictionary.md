# Dicionário de Dados — FMA_Pontos (Supabase Postgres)

> Gerado pelo **Data Master** em 2026-05-31  
> Fonte primária: `db_cluster-21-01-2026@04-10-08.backup` (cluster dump Supabase, 2026-01-21)  
> Validação cruzada: `supabase/migrations/20251226191350_initial_schema.sql`

## Escopo

Documenta o schema **`public`** do app + integrações **`auth`**, **`storage`** e **`realtime`** relevantes. Schemas internos Supabase (`auth.*` completo, `realtime.*`, `storage.*`) não são inventariados coluna a coluna — apenas o que o app consome.

## Inventário por domínio

| Domínio | Tabelas `public` | Propósito |
|---------|------------------|-----------|
| Acervo | `categories`, `lyrics` | Categorias de pontos e letras/conteúdo |
| Identidade / RBAC | `user_roles` | Papéis e status ativo por usuário Supabase Auth |
| Estatísticas | `lyric_play_stats` | Contagem global de reproduções por letra |
| Auditoria | `audit_logs` | Trilha INSERT/UPDATE/DELETE em categorias e letras |
| Mídia | `storage.buckets` / `storage.objects` | Bucket `audio` (MP3 público) |
| Auth (Supabase) | `auth.users` | Contas Google / anônimas |

## Volumes no backup (🟢)

| Tabela | Registros aprox. | Observação |
|--------|------------------|------------|
| `categories` | 18 | Todas com `code` preenchido (ex. CA, PR, OX) |
| `lyrics` | ~948 | `sequence_number` presente |
| `lyric_play_stats` | 0 | Tabela vazia no snapshot |
| `user_roles` | 3 | 2 admin, 1 user; 2 contas `is_active = false` |
| `audit_logs` | Centenas+ | Triggers ativos em `categories` / `lyrics` |
| `auth.users` | 3 | Alinhado a `user_roles` |

---

## `public.categories`

🟢 **CONFIRMADO** — Agrupa letras/pontos do acervo remoto.

| Coluna | Tipo | Nullable | Default | Constraint | Confiança |
|--------|------|----------|---------|------------|-----------|
| `id` | `text` | NOT NULL | — | PK | 🟢 |
| `name` | `text` | NOT NULL | — | — | 🟢 |
| `code` | `text` | NOT NULL | — | UNIQUE (`categories_code_key`) | 🟢 |
| `updated_at` | `timestamptz` | NOT NULL | `now()` | — | 🟢 |
| `is_deleted` | `boolean` | NOT NULL | `false` | Soft delete (Fase A sync-contract) | 🟢 |

**Índices:** PK, UNIQUE em `code`, `idx_categories_updated_at` em `updated_at`.

**Views (sync incremental):**

| View | Papel |
|------|--------|
| `sync_categories` | PULL com tombstones (`security_invoker = false`) |
| `sync_lyrics` | idem |

**Notas:**
- 🟢 Leitura UI via tabela base + RLS `is_deleted = false`; sync usa views `sync_*`.
- 🟡 `youtube_url` em `lyrics` coexiste com `youtube_link` (legado duplicado).

---

## `public.lyrics`

🟢 **CONFIRMADO** — Conteúdo das letras, mídia opcional e ordenação por categoria.

| Coluna | Tipo | Nullable | Default | Constraint | Confiança |
|--------|------|----------|---------|------------|-----------|
| `id` | `text` | NOT NULL | — | PK | 🟢 |
| `category_id` | `text` | NOT NULL | — | FK → `categories(id)` ON DELETE CASCADE | 🟢 |
| `title` | `text` | NOT NULL | — | — | 🟢 |
| `content` | `text` | NOT NULL | — | — | 🟢 |
| `updated_at` | `timestamptz` | NOT NULL | `now()` | — | 🟢 |
| `audio_url` | `text` | NULL | — | CHECK: NULL ou termina com `.mp3` (ILIKE) | 🟢 |
| `youtube_url` | `text` | NULL | — | — | 🟢 |
| `youtube_link` | `text` | NULL | — | — | 🟢 |
| `sequence_number` | `integer` | NOT NULL | `0` | — | 🟢 |
| `is_deleted` | `boolean` | NOT NULL | `false` | Soft delete (Fase A sync-contract) | 🟢 |

**Índices:** `idx_lyrics_category_id` em `category_id`, `idx_lyrics_updated_at` em `updated_at`.

**App:** `Lyric` / `toSupabaseMap` envia campos usados na sync; player lê `audio_url` e `youtube_link`.

---

## `public.user_roles`

🟢 **CONFIRMADO** — RBAC estendido sobre `auth.users`.

| Coluna | Tipo | Nullable | Default | Constraint | Confiança |
|--------|------|----------|---------|------------|-----------|
| `id` | `uuid` | NOT NULL | — | PK, FK → `auth.users(id)` ON DELETE CASCADE | 🟢 |
| `email` | `text` | NOT NULL | — | — | 🟢 |
| `role` | `text` | NOT NULL | `'user'` | CHECK IN (`user`,`moderator`,`admin`) | 🟢 |
| `created_at` | `timestamptz` | NOT NULL | `now()` | — | 🟢 |
| `updated_at` | `timestamptz` | NOT NULL | `now()` | — | 🟢 |
| `is_active` | `boolean` | NULL | `true` | — | 🟢 |
| `avatar_url` | `text` | NULL | — | — | 🟢 |

**Índices:** `idx_user_roles_email`.

**Dados no backup:** `rdinda51@gmail.com` admin ativo; `comercialrdinda@gmail.com` admin **inativo**; `rdxtremes15@gmail.com` user **inativo**.

---

## `public.lyric_play_stats`

🟢 **CONFIRMADO** — Ranking “mais tocados” (remoto).

| Coluna | Tipo | Nullable | Default | Constraint | Confiança |
|--------|------|----------|---------|------------|-----------|
| `lyric_id` | `text` | NOT NULL | — | PK, FK → `lyrics(id)` ON DELETE CASCADE | 🟢 |
| `play_count` | `integer` | NOT NULL | `0` | — | 🟢 |
| `last_played_at` | `timestamptz` | NULL | `now()` | — | 🟢 |
| `updated_at` | `timestamptz` | NULL | `now()` | — | 🟢 |

**Índices:** `idx_lyric_play_stats_count` DESC em `play_count`.

**Backup:** vazia → explica “Nenhum ponto tocado ainda” na Home se o app só consulta remoto sem fallback local populado.

---

## `public.audit_logs`

🟢 **CONFIRMADO** — Populada por triggers em `categories` e `lyrics`.

| Coluna | Tipo | Nullable | Default | Constraint | Confiança |
|--------|------|----------|---------|------------|-----------|
| `id` | `uuid` | NOT NULL | `gen_random_uuid()` | PK | 🟢 |
| `table_name` | `text` | NOT NULL | — | — | 🟢 |
| `record_id` | `text` | NOT NULL | — | — | 🟢 |
| `action` | `text` | NOT NULL | — | CHECK IN (`INSERT`,`UPDATE`,`DELETE`) | 🟢 |
| `old_data` | `jsonb` | NULL | — | — | 🟢 |
| `new_data` | `jsonb` | NULL | — | — | 🟢 |
| `user_id` | `uuid` | NULL | — | FK → `auth.users(id)` | 🟢 |
| `user_email` | `text` | NULL | — | — | 🟢 |
| `created_at` | `timestamptz` | NULL | `now()` | — | 🟢 |

**Índices:** `idx_audit_logs_created`, `idx_audit_logs_table`, `idx_audit_logs_user`.

**RLS:** 🟡 Sem `ENABLE ROW LEVEL SECURITY` no dump — apenas `GRANT SELECT` para `authenticated` e `anon`. Escrita só via trigger SECURITY DEFINER.

---

## SQLite local (`lyrics_v4.db`, schema v6)

| Tabela / coluna | Uso |
|-----------------|-----|
| `categories.is_synced`, `lyrics.is_synced` | Fila de push do acervo |
| `categories.is_deleted`, `lyrics.is_deleted` | Tombstone local; alinhado ao remoto após Fase A |
| **`pending_access_events`** | Fila FIFO de acessos offline (flush → RPC) |

### `pending_access_events` (🟢 pós Fase C)

| Coluna | Tipo | Papel |
|--------|------|--------|
| `id` | INTEGER PK AUTOINCREMENT | Ordem de flush |
| `lyric_id` | TEXT NOT NULL | Letra acessada |
| `accessed_at` | TEXT ISO8601 | Timestamp do acesso |
| `is_flushed` | INTEGER 0/1 | 0 = pendente de envio |

**Índice:** `idx_pending_access_flush (is_flushed, id)`.

🟢 **CONFIRMADO** — Remoto e local usam `is_deleted`; PULL incremental lê tombstones via `sync_*`; stats não usam INSERT client em `lyric_play_stats`.

---

## Storage — bucket `audio`

🟢 **CONFIRMADO** — Bucket público `audio`; objetos em `storage.objects` com paths `lyrics/*.mp3`.

Políticas no backup:
- SELECT público
- INSERT authenticated: `.mp3` + `has_role('user')`
- UPDATE moderator+
- DELETE admin

---

## Migrações Supabase registradas no backup

| Versão | Tema |
|--------|------|
| `20251226191350` | Schema base categorias/letras, RBAC, audit, storage |
| `20251226192339` | Ajustes policies / revokes |
| `20260114120000` | Coluna `categories.code` + backfill |
| `20260531120000` | Sync-contract Fase A: `is_deleted`, views `sync_*`, RLS, RPC `increment_play_count` |
| `20260531120100` | Auditoria RLS pós-deploy (revogações anon, stats só RPC) |

🟢 **`increment_play_count`** — aplicada em prod com migration `20260531120000` (2026-06-01). Dump de jan/2026 permanece histórico.

---

## Escala de confiança (resumo)

| Artefato | Fonte | Confiança |
|----------|-------|-----------|
| DDL tabelas `public` | Backup `CREATE TABLE` | 🟢 |
| Funções/triggers `public` | Backup | 🟢 |
| RLS policies | Backup | 🟢 |
| RPC `increment_play_count` em prod | Ausente no backup | 🔴 |
| Colunas só SQLite | Código Flutter | 🟢 |
