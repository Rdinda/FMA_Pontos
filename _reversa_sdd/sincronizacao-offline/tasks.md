# Sincronização Offline — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Flutter com `sqflite`, `path`, `connectivity_plus`, `shared_preferences`, `http`.
- [ ] 🟢 `supabase_flutter` inicializado em `main()` com `SUPABASE_URL` e `SUPABASE_ANON_KEY`.
- [ ] 🟢 Tabelas remotas `categories` e `lyrics` com `updated_at`, `is_deleted` e RLS compatível.
- [ ] 🟢 Bucket Storage `audio` com políticas de leitura pública para URLs de playback.
- [ ] 🟢 Models `Category` e `Lyric` com flags `isSynced`, `isDeleted`.
- [ ] 🟢 `SyncRepository` registrado em `MultiProvider` antes das telas de acervo.

## Tarefas — Persistência Local

- [ ] T-01, Implementar `DatabaseHelper` com schema v5
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: tabelas `categories` e `lyrics` criadas; migrations v2–v5 para `audio_url`, `local_audio_path`, `youtube_link`, `code`, `sequence_number`.
  - Confiança: 🟢

- [ ] T-02, Implementar queries de leitura filtrando deletados
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `readAllCategories`, `readLyricsByCategory`, `searchLyrics`, `readAllLyrics` usam `is_deleted = 0`.
  - Confiança: 🟢

- [ ] T-03, Implementar fila de não sincronizados
  - Origem no legado: `getUnsyncedCategories`, `getUnsyncedLyrics`
  - Critério de pronto: retorna registros com `is_synced = 0`, incluindo soft deletes pendentes.
  - Confiança: 🟢

- [ ] T-04, Implementar soft delete e hard delete
  - Origem no legado: `softDeleteCategory`, `softDeleteLyric`, `hardDelete*`, `mark*Synced`
  - Critério de pronto: soft delete seta `is_deleted=1`, `is_synced=0`, `updated_at=now`; hard delete remove linha; exclusão de categoria cascateia letras.
  - Confiança: 🟢

## Tarefas — Camada Remota

- [ ] T-05, Implementar fetch incremental Supabase
  - Origem no legado: `lib/services/supabase_service.dart`
  - Critério de pronto: `fetchCategories`/`fetchLyrics` aceitam `since` e aplicam `.gt('updated_at', since.toIso8601String())`.
  - Confiança: 🟢

- [ ] T-06, Implementar upsert e soft delete remoto
  - Origem no legado: `lib/services/supabase_service.dart`
  - Critério de pronto: `upsert*` usa `toSupabaseMap`; `delete*` atualiza `is_deleted=true` e `updated_at`.
  - Confiança: 🟢

- [ ] T-07, Implementar upload e delete de áudio no Storage
  - Origem no legado: `uploadAudio`, `deleteAudio`, `deleteAudioByUrl`
  - Critério de pronto: upload sanitiza nome, retorna URL pública; delete por URL extrai basename do path.
  - Confiança: 🟢

## Tarefas — Orquestração de Sync

- [ ] T-08, Implementar detecção de conectividade
  - Origem no legado: `SyncRepository._initConnectivity`
  - Critério de pronto: listener atualiza `isOffline`; ao sair de offline chama `syncData()`; estado inicial verificado.
  - Confiança: 🟢

- [ ] T-09, Implementar fase PUSH em `syncData`
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: processa categorias e letras não sync; deletados propagam soft delete + hard delete local; demais upsert + mark synced.
  - Confiança: 🟢

- [ ] T-10, Implementar fase PULL incremental
  - Origem no legado: `sync_repository.dart`
  - Critério de pronto: lê `last_sync_timestamp`; aplica upsert/hard delete; preserva `localAudioPath`; limpa áudio obsoleto; grava novo timestamp.
  - Confiança: 🟢

- [ ] T-11, Implementar merge de `localAudioPath` no pull
  - Origem no legado: loop de `cloudLyrics` em `syncData`
  - Critério de pronto: não sobrescreve path local com null; apaga arquivo se URL removida ou alterada.
  - Confiança: 🟢

- [ ] T-12, Implementar `_downloadMissingAudios`
  - Origem no legado: `sync_repository.dart`
  - Critério de pronto: baixa sequencialmente para `/audios/`; atualiza `localAudioPath`; expõe progresso; trata arquivo já existente.
  - Confiança: 🟢

- [ ] T-13, Implementar guardas `isSyncing` e `isOffline`
  - Origem no legado: início de `syncData`
  - Critério de pronto: sync não reentra; offline não inicia ciclo; `finally` sempre limpa `_isSyncing`.
  - Confiança: 🟢

## Tarefas — CRUD e Integração UI

- [ ] T-14, Implementar wrappers `addCategory`, `addLyric`, `delete*`, leituras
  - Origem no legado: `sync_repository.dart`
  - Critério de pronto: UI usa apenas `SyncRepository`; leituras delegam ao `DatabaseHelper`; mutações notificam listeners.
  - Confiança: 🟢

- [ ] T-15, Implementar push imediato quando online
  - Origem no legado: `addCategory`, `addLyric`
  - Critério de pronto: após upsert local, se `!isOffline`, dispara upsert remoto assíncrono e marca sync no sucesso.
  - Confiança: 🟢

- [ ] T-16, Integrar sync na Home e refresh manual
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: `syncData` no `initState`; `RefreshIndicator` chama sync + `refreshUserRole`; ícone `wifi_off` quando offline.
  - Confiança: 🟢

- [ ] T-17, Integrar progresso de download no Splash
  - Origem no legado: `lib/screens/splash_screen.dart`
  - Critério de pronto: `Consumer<SyncRepository>` exibe `downloadStatus` e `LinearProgressIndicator` quando `isDownloading`.
  - Confiança: 🟢

- [ ] T-18, Integrar refresh em Category, Search e LyricView
  - Origem no legado: telas respectivas
  - Critério de pronto: pull-to-refresh chama `syncData()` e recarrega dados locais.
  - Confiança: 🟢

## Tarefas futuras (débito técnico)

- [ ] T-19, Unificar `deleteLyric` online com soft delete do PUSH
  - Origem: inconsistência 🟡 documentada
  - Critério de pronto: exclusão imediata e fila incremental usam o mesmo contrato remoto.
  - Confiança: 🟡

- [ ] T-20, Otimizar merge no PULL com query por ID
  - Origem: `readAllLyrics` no loop
  - Critério de pronto: `getLyricById` por item ou mapa em memória carregado uma vez.
  - Confiança: 🟢

- [ ] T-21, Expor erros de sync na UI
  - Origem: lacuna 🟡
  - Critério de pronto: falha no ciclo mostra snackbar ou banner retry.
  - Confiança: 🔴

- [ ] T-22, Definir política de conflito documentada
  - Origem: lacuna 🔴 ADR 001
  - Critério de pronto: regra explícita (ex.: remoto ganha se `updated_at` maior) implementada ou rejeitada com testes.
  - Confiança: 🔴

## Ordem sugerida de implementação

1. T-01 → T-04 (SQLite)
2. T-05 → T-07 (Supabase)
3. T-08 → T-13 (sync core)
4. T-14 → T-18 (CRUD + UI)
5. T-19 → T-22 (hardening)

## Definição de pronto da unit

- [ ] App funciona offline para ler e editar acervo local.
- [ ] Alterações propagam ao Supabase quando online (PUSH + PULL).
- [ ] Soft delete sincroniza exclusões entre dispositivos.
- [ ] `localAudioPath` sobrevive a pulls e áudios são baixados pós-sync.
- [ ] UI reflete offline, syncing e progresso de download.
