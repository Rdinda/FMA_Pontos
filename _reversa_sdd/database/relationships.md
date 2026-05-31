# Relacionamentos — FMA_Pontos (Postgres `public`)

> Data Master · 2026-05-31 · Fonte: backup `db_cluster-21-01-2026@04-10-08.backup`

## Diagrama textual

```
auth.users (1) ──────< (1) user_roles
     │
     │ (opcional, SET NULL implícito em audit)
     └──────< (*) audit_logs.user_id

categories (1) ──────< (*) lyrics
                              │
                              └────── (1) lyric_play_stats [0..1]
```

## Relacionamentos detalhados

### `categories` → `lyrics`

| De | Para | Cardinalidade | FK | ON DELETE | Confiança |
|----|------|---------------|-----|-----------|-----------|
| `categories.id` | `lyrics.category_id` | 1:N | `lyrics_category_id_fkey` | CASCADE | 🟢 |

🟢 Excluir categoria no Postgres remove todas as letras e stats associadas.

### `lyrics` → `lyric_play_stats`

| De | Para | Cardinalidade | FK | ON DELETE | Confiança |
|----|------|---------------|-----|-----------|-----------|
| `lyrics.id` | `lyric_play_stats.lyric_id` | 1:0..1 | `lyric_play_stats_lyric_id_fkey` | CASCADE | 🟢 |

🟡 No backup nenhuma linha de stats — relação existe mas sem instâncias.

### `auth.users` → `user_roles`

| De | Para | Cardinalidade | FK | ON DELETE | Confiança |
|----|------|---------------|-----|-----------|-----------|
| `auth.users.id` | `user_roles.id` | 1:1 | `user_roles_id_fkey` | CASCADE | 🟢 |

🟢 Trigger `on_auth_user_created` insere linha `user_roles` com role `user` no signup.

### `auth.users` → `audit_logs`

| De | Para | Cardinalidade | FK | ON DELETE | Confiança |
|----|------|---------------|-----|-----------|-----------|
| `auth.users.id` | `audit_logs.user_id` | 1:N | `audit_logs_user_id_fkey` | — | 🟢 |

🟡 Operações de sistema/migração podem gravar `user_id` NULL (visto no backup).

## Relacionamentos lógicos (sem FK)

| Origem | Destino | Via | Confiança |
|--------|---------|-----|-----------|
| `lyrics.audio_url` | `storage.objects` | URL pública bucket `audio` | 🟢 |
| `user_roles` | Realtime | `supabase_realtime` publication | 🟢 |
| App SQLite `lyrics` | `public.lyrics` | Sync incremental `updated_at` | 🟢 |

## Tabelas de junção / N:M

🟢 **CONFIRMADO** — Não há tabelas N:M no schema `public`. Favoritos são **locais** (`SharedPreferences`), não Postgres.

## Relacionamentos polimórficos

Nenhum identificado no schema `public`.

## Integração Auth ↔ App

```mermaid
flowchart LR
  GU[Google / Anonymous Auth] --> AU[auth.users]
  AU --> UR[user_roles]
  UR -->|Realtime| APP[AuthService Flutter]
  APP -->|has_role / isAdmin| UI[Telas CRUD]
```

## Soft delete (híbrido)

| Camada | Mecanismo |
|--------|-----------|
| SQLite | `is_deleted = 1`, `is_synced = 0` |
| Postgres | DELETE físico ou UPDATE remoto; **sem** coluna `is_deleted` |

🟢 **CONFIRMADO** — Divergência intencional offline-first documentada no `SyncRepository`.
