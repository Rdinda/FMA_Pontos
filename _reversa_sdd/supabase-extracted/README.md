# SQL extraído do backup de produção

**Arquivo fonte:** `db_cluster-21-01-2026@04-10-08.backup` (raiz do repositório legado)  
**Data do backup:** 2026-01-21

## Objetos confirmados

| Objeto | Arquivo | Status no backup |
|--------|---------|------------------|
| `audit_logs` + `audit_trigger_func` + triggers em `categories`/`lyrics` | `audit_logs.sql` | ✅ Presente |
| `lyric_play_stats` | (em `supabase_schema.sql` parcial) | ✅ Tabela presente |
| `increment_play_count` RPC | — | ❌ **Ausente** no backup |

## Implicação para o app

- **Auditoria:** logs são gerados em produção via triggers; DDL deve ser versionada no repo a partir de `audit_logs.sql`.
- **Estatísticas:** `PlayStatsService` usa **fallback client-side** como caminho efetivo; RPC não existe no servidor conforme backup.
