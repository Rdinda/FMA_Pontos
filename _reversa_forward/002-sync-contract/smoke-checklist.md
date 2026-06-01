# Smoke manual — `002-sync-contract` (T035)

> Executar com app release/debug apontando para Supabase com migrations `20260531120000` + `20260531120100` aplicadas.

## Pré-requisitos

- [ ] `supabase migration list --linked` mostra `20260531120000` e `20260531120100` applied
- [ ] Login Google com conta `is_active=true` e role adequada (moderator/admin para CRUD categoria)

## 1. PULL incremental (`sync_*`)

| # | Passo | Esperado |
|---|--------|----------|
| 1.1 | App limpo ou `last_sync_timestamp` antigo; abrir Home online | Sync conclui sem erro em log |
| 1.2 | Admin soft-delete uma categoria no remoto | Próximo sync remove categoria local (tombstone via view) |
| 1.3 | `SyncRepository.lastSyncError` | `null` após sync OK |

## 2. RPC `increment_play_count`

| # | Passo | Esperado |
|---|--------|----------|
| 2.1 | Login Google; abrir letra online | Sem erro RPC; `lyric_play_stats.play_count` incrementa |
| 2.2 | Anônimo; abrir letra | Contador não incrementa (sem fila local) |

## 3. Fila offline (`pending_access_events`)

| # | Passo | Esperado |
|---|--------|----------|
| 3.1 | Login Google; modo avião; abrir 2 letras | 2 linhas `is_flushed=0` (inspecionar via debug ou contador pendente) |
| 3.2 | Voltar online; pull-to-refresh / sync Home | Flush RPC; fila esvazia; ranking reflete acessos |

## 4. Mutações RLS (acervo)

| # | Passo | Esperado |
|---|--------|----------|
| 4.1 | Anônimo tenta editar letra (menu) | Opção edição oculta / login exigido |
| 4.2 | User sem moderator tenta editar categoria | Negado no client (`canEditCategories`) |
| 4.3 | Moderator cria letra online | Persiste remoto + `is_synced=1` local |

## Registro de execução

| Data | Executor | Resultado | Notas |
|------|----------|-----------|-------|
| | | | |
