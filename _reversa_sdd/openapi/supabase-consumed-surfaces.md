# Superfícies Supabase Consumidas — FMA_Pontos

> **Nota:** O produto principal é um **app móvel Flutter**, não uma API REST exposta pelo projeto. Não há `openapi.yaml` de API própria. Este documento inventaria as **superfícies remotas consumidas** via `supabase_flutter` e `http`, no lugar de OpenAPI completo (nível Completo do Reversa).

Gerado pelo Reversa Writer em 2026-05-20.

## Autenticação

| Operação | SDK / endpoint | Unit spec |
|----------|----------------|-----------|
| Sessão anônima | `auth.signInAnonymously()` | `autenticacao` |
| Login Google | `auth.signInWithIdToken` | `autenticacao` |
| Logout | `auth.signOut()` | `autenticacao` |
| Listener de sessão | `auth.onAuthStateChange` | `autenticacao` |

## Tabelas PostgREST

| Tabela | SELECT | INSERT | UPDATE | DELETE | Unit |
|--------|--------|--------|--------|--------|------|
| `categories` | 🟢 | 🟢 | 🟢 | 🟢 (soft) | `sincronizacao-offline`, `acervo-categorias` |
| `lyrics` | 🟢 | 🟢 | 🟢 | 🟢 | `sincronizacao-offline`, `edicao-letra` |
| `user_roles` | 🟢 | 🟢 | 🟢 | — | `autenticacao`, `administracao` |
| `lyric_play_stats` | 🟢 | 🟢 | 🟢 | — | `estatisticas-mais-tocados` |
| `audit_logs` | 🟢 | — | — | — | `administracao` |

Filtros recorrentes:

- `updated_at > {since}` — sync incremental (`categories`, `lyrics`)
- `is_deleted` — soft delete remoto
- `order('play_count', ascending: false).limit(n)` — ranking

## RPC

| Função | Parâmetros | Status no repo | Unit |
|--------|------------|----------------|------|
| `increment_play_count` | `p_lyric_id` | 🔴 DDL não versionada | `estatisticas-mais-tocados` |

## Storage

| Bucket | Operação | Path pattern | Unit |
|--------|----------|--------------|------|
| `audio` | upload, download, delete | `lyrics/{id}.mp3` (inferido) | `edicao-letra`, `sincronizacao-offline` |

## Realtime

| Canal | Tabela | Evento | Unit |
|-------|--------|--------|------|
| `public:user_roles:{userId}` | `user_roles` | UPDATE | `autenticacao` |

## APIs externas (não Supabase)

| API | Uso | Unit |
|-----|-----|------|
| `https://api.github.com/repos/Rdinda/FMA_Pontos/releases/latest` | Check update | `release-update` |
| Google OAuth | Login | `autenticacao` |
| YouTube (URL externa) | Playback link | `reproducao-youtube` |

## Funções SQL referenciadas (servidor)

| Função | Uso |
|--------|-----|
| `public.has_role(text)` | RLS policies |
| `public.get_user_role()` | RLS / defaults |
| `public.is_admin()` | Policies (migration) |

🔴 **LACUNA** — OpenAPI formal do PostgREST/Supabase não é gerada neste repositório; consultar projeto Supabase Dashboard para contrato completo.
