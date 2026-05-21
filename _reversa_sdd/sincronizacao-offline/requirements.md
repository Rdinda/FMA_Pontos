# Sincronização Offline — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a estratégia offline-first do app: persistência local em SQLite, fila de alterações não sincronizadas, push/pull incremental com Supabase, soft delete, download de áudios e detecção de conectividade.  
🟢 **CONFIRMADO** — `SyncRepository` é a fachada única para CRUD de categorias e letras consumida pelas telas; delega persistência a `DatabaseHelper` e remoto a `SupabaseService`.  
🟢 **CONFIRMADO** — O cursor incremental usa `SharedPreferences` → chave `last_sync_timestamp`.  
🟢 **CONFIRMADO** — Política de conflito: **merge por campo** quando edição local não sincronizada e alteração remota coexistem (Roberto, 2026-05-20).  
🟢 **CONFIRMADO** — Implementado em `lib/services/sync_merge.dart` + `SyncRepository` (ver contrato **S-04**).

Referências:
- ADR 001 — `_reversa_sdd/adrs/001-offline-first-sync-soft-delete.md`
- Contrato arquitetural — [`../architecture-contract.md`](../architecture-contract.md)

## Responsabilidades

- 🟢 **CONFIRMADO** — Persistir categorias e letras localmente em SQLite (`lyrics_v4.db`, versão 5).
- 🟢 **CONFIRMADO** — Marcar mutações locais com `is_synced = 0` até propagação bem-sucedida.
- 🟢 **CONFIRMADO** — Representar exclusões com soft delete (`is_deleted = 1`, `is_synced = 0`).
- 🟢 **CONFIRMADO** — Executar ciclo `syncData`: PUSH → PULL incremental → download de áudios ausentes.
- 🟢 **CONFIRMADO** — Detectar offline via `connectivity_plus` e expor `isOffline` à UI.
- 🟢 **CONFIRMADO** — Disparar sync automático ao recuperar conectividade.
- 🟢 **CONFIRMADO** — Permitir sync manual via pull-to-refresh em telas principais.
- 🟢 **CONFIRMADO** — Preservar `localAudioPath` no pull quando o registro remoto não conhece arquivos locais.
- 🟢 **CONFIRMADO** — Remover arquivos de áudio locais obsoletos quando URL remota muda ou some.
- 🟢 **CONFIRMADO** — Baixar MP3s remotos para `{appDocuments}/audios/` quando `audioUrl` existe e `localAudioPath` é nulo.
- 🟢 **CONFIRMADO** — Expor progresso de download (`isDownloading`, `downloadProgress`, `downloadStatus`) para UI.
- 🟢 **CONFIRMADO** — Oferecer leitura local: categorias, letras por categoria, busca, contagem e próximo `sequenceNumber`.

## Regras de Negócio

- 🟢 **CONFIRMADO** — `syncData` retorna imediatamente se `_isSyncing` ou `_isOffline`.
- 🟢 **CONFIRMADO** — PUSH processa primeiro categorias, depois letras, todas com `is_synced = 0`.
- 🟢 **CONFIRMADO** — Item com `isDeleted` no PUSH: soft delete remoto + `hardDelete` local após sucesso.
- 🟢 **CONFIRMADO** — Item sem `isDeleted` no PUSH: `upsert` remoto + `markSynced` local.
- 🟢 **CONFIRMADO** — PULL busca registros com `updated_at > last_sync_timestamp` (ou full fetch se timestamp ausente).
- 🟢 **CONFIRMADO** — Registro remoto com `isDeleted` no PULL: remove áudio local se existir + `hardDeleteLyric`/`hardDeleteCategory`.
- 🟢 **CONFIRMADO** — Após PULL bem-sucedido, grava `last_sync_timestamp = now()` mesmo que download de áudio falhe parcialmente.
- 🟢 **CONFIRMADO** — `softDeleteCategory` marca categoria e **todas** letras da categoria como deletadas e não sincronizadas.
- 🟢 **CONFIRMADO** — Leituras (`readAllCategories`, `readLyricsByCategory`, `searchLyrics`) filtram `is_deleted = 0`.
- 🟢 **CONFIRMADO** — `upsertCategory`/`upsertLyric` no SQLite forçam `is_deleted = 0` no insert (ressuscita flag ao salvar).
- 🟢 **CONFIRMADO** — `addCategory`/`addLyric`: grava local, notifica UI; se online, tenta push imediato assíncrono e `markSynced` no sucesso.
- 🟢 **CONFIRMADO** — `deleteCategory` offline: apenas soft delete local; online: soft delete remoto + hard delete local no sucesso.
- 🟢 **CONFIRMADO** — Exclusão de letra (online e offline) deve usar **soft delete** remoto (`is_deleted=true`), alinhado ao PUSH e ADR 001 (Roberto, 2026-05-20).  
- 🟡 **INFERIDO** — Legado: `SyncRepository.deleteLyric` online faz **hard delete** na tabela e remove Storage — deve ser corrigido para soft delete unificado.
- 🟢 **CONFIRMADO** — Download de áudio usa nome de arquivo derivado do último segmento da URL; reutiliza arquivo se já existir no disco.
- 🟡 **INFERIDO** — Erros de sync são apenas `debugPrint`; usuário não recebe feedback de falha na sincronização.
- 🟢 **CONFIRMADO** — Em conflito de versão, a regra alvo é **merge por campo** (campos locais não alterados preservam valor remoto e vice-versa conforme regra de merge).  
- 🟡 **INFERIDO** — No código legado atual, conflito resolve por último upsert sem merge nem alerta ao usuário.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O app deve inicializar SQLite com tabelas `categories` e `lyrics`. | Must | Dado primeira execução, quando `DatabaseHelper` abre DB, então schema v5 é criado com colunas de sync e mídia. |
| RF-02 | 🟢 Mutations locais devem marcar `is_synced = 0`. | Must | Dado `softDelete*` ou `addLyric` com `isSynced: false`, quando consulta `getUnsynced*`, então item aparece na fila. |
| RF-03 | 🟢 O sistema deve executar PUSH antes do PULL. | Must | Dado `syncData` online, quando ciclo inicia, então `getUnsyncedCategories/Lyrics` são processados antes de `fetch*`. |
| RF-04 | 🟢 PUSH deve propagar soft deletes ao remoto. | Must | Dado item `isDeleted`, quando PUSH executa, então `SupabaseService.delete*` atualiza `is_deleted=true` e remove localmente após sucesso. |
| RF-05 | 🟢 PUSH deve propagar upserts ao remoto. | Must | Dado item não deletado, quando PUSH executa, então `upsert*` remoto e `mark*Synced` local. |
| RF-06 | 🟢 PULL deve ser incremental por `updated_at`. | Must | Dado `last_sync_timestamp` salvo, quando `fetchCategories/fetchLyrics`, então query usa `.gt('updated_at', since)`. |
| RF-07 | 🟢 PULL deve aplicar exclusões remotas localmente. | Must | Dado registro remoto `isDeleted`, quando PULL processa, então hard delete local (e áudio associado para letras). |
| RF-08 | 🟢 PULL deve preservar `localAudioPath` existente. | Must | Dado letra local com path, quando PULL upsert sem mudança de áudio, então path é mantido no objeto salvo. |
| RF-09 | 🟢 PULL deve invalidar áudio local obsoleto. | Should | Dado `audioUrl` removida ou alterada, quando PULL detecta diferença, então arquivo local é apagado e path limpo. |
| RF-10 | 🟢 O sistema deve atualizar cursor de sync após PULL. | Must | Dado PULL concluído, quando ciclo avança, então `last_sync_timestamp` é gravado em SharedPreferences. |
| RF-11 | 🟢 O sistema deve baixar áudios pendentes após sync. | Should | Dado letras com `audioUrl` e sem `localAudioPath`, quando `_downloadMissingAudios` roda, então arquivos são salvos em `/audios/` e path atualizado. |
| RF-12 | 🟢 O sistema deve expor progresso de download. | Should | Dado downloads em andamento, quando UI consome `SyncRepository`, então `isDownloading`, `downloadProgress` e `downloadStatus` refletem estado. |
| RF-13 | 🟢 O sistema deve detectar offline/online. | Must | Dado perda de rede, quando `ConnectivityResult.none`, então `isOffline=true` e sync não dispara; ao voltar online, `syncData()` é chamado. |
| RF-14 | 🟢 Telas devem poder forçar sync manual. | Should | Dado pull-to-refresh em Home/Categoria/Busca/Letra, quando usuário arrasta, então `syncData()` executa. |
| RF-15 | 🟢 CRUD local deve funcionar offline. | Must | Dado `isOffline`, quando usuário adiciona categoria/letra, então dados persistem localmente sem erro bloqueante. |
| RF-16 | 🟢 UI deve indicar modo offline. | Should | Dado `isOffline`, quando Home renderiza AppBar, então ícone `wifi_off` vermelho aparece. |
| RF-17 | 🟢 Home deve disparar sync na abertura. | Should | Dado app online após splash, quando `HomeScreen` monta, então `syncData()` é chamado no primeiro frame. |
| RF-18 | 🟢 Exclusão de categoria deve cascatear letras localmente. | Must | Dado `deleteCategory`, quando soft delete executa, então letras da categoria recebem `is_deleted=1`. |
| RF-19 | 🟢 Exclusão de letra online deve usar soft delete remoto. | Must | Dado `deleteLyric` online, quando executa, então `SupabaseService.deleteLyric` marca `is_deleted=true` (sem `DELETE` físico na tabela). Remoção de áudio no Storage pode ocorrer em job/sync posterior. 🟡 Legado: hard delete + `deleteAudioByUrl` imediato. |
| RF-20 | 🟢 Consultas de leitura devem ignorar registros deletados. | Must | Dado soft delete, quando `getCategories`/`getLyrics`/`searchLyrics`, então itens com `is_deleted=1` não retornam. |
| RF-21 | 🟢 Em conflito de versão (local não sincronizado vs. remoto alterado), o sistema deve aplicar **merge por campo** (não last-write-wins). | Must (alvo) | Dado edição local pendente e alteração remota no mesmo registro, quando PULL/PUSH detecta divergência, então campos são fundidos conforme regra de merge e usuário não perde alterações distintas por campo. 🟡 Legado: last-write-wins implícito. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Disponibilidade offline | App utilizável sem rede para leitura e edição local. | SQLite + CRUD local | 🟢 |
| Consistência eventual | Alterações propagam quando online. | PUSH/PULL + connectivity listener | 🟢 |
| Performance | PULL de letras lê `readAllLyrics` por item para merge (O(n²) potencial). | Loop em `sync_repository.dart` | 🟢 |
| Resiliência | Falha de sync não interrompe app; estado `_isSyncing` é resetado no `finally`. | try/catch/finally | 🟢 |
| Armazenamento | Áudios em diretório de documentos do app. | `getApplicationDocumentsDirectory()/audios` | 🟢 |
| Observabilidade | Falhas logadas via `debugPrint` apenas. | `Sync Error`, catch blocks | 🟡 |
| Segurança remota | Supabase inicializado com `--dart-define` URL/anon key. | `main.dart` | 🟢 |
| Idempotência parcial | Re-download ignora se arquivo já existe no path derivado da URL. | `_downloadMissingAudios` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado o dispositivo offline
Quando o usuário cria uma letra
Então a letra é salva no SQLite com is_synced=0

Dado alterações locais não sincronizadas e rede disponível
Quando syncData executa
Então alterações são enviadas ao Supabase antes do pull

Dado last_sync_timestamp definido
Quando o pull executa
Então apenas registros com updated_at posterior são buscados

Dado uma letra remota marcada is_deleted
Quando o pull processa
Então o registro é removido do SQLite local

Dado uma letra local com localAudioPath válido
Quando o pull atualiza metadados sem mudar áudio
Então localAudioPath permanece no registro local

Dado uma letra com audioUrl e sem arquivo local
Quando o sync conclui o pull
Então o sistema tenta baixar o MP3 para a pasta audios

Dado perda de conectividade
Quando ConnectivityResult.none
Então isOffline=true e ícone wifi_off aparece na Home

Dado retorno de conectividade
Quando o listener detecta rede
Então syncData é disparado automaticamente
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| SQLite + flags de sync | Must | 🟢 Fundação offline-first. |
| PUSH/PULL incremental | Must | 🟢 Núcleo da feature. |
| Soft delete + hard delete local | Must | 🟢 ADR 001. |
| Preservação de `localAudioPath` | Must | 🟢 Evita re-download desnecessário e perda de offline. |
| Detecção de conectividade | Must | 🟢 Coordena quando sincronizar. |
| Download de áudios | Should | 🟢 Essencial para playback offline, mas app funciona sem todos baixados. |
| Progresso de download na UI | Should | 🟢 UX no splash. |
| Feedback de erro de sync ao usuário | Could | 🟡 Não implementado. |
| Resolução de conflitos por merge | Must (alvo) | 🟢 Decisão stakeholder; 🟡 não implementado no legado. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/sync_repository.dart` | `SyncRepository`, `syncData`, CRUD, `_downloadMissingAudios` | 🟢 |
| `lib/services/db_helper.dart` | `DatabaseHelper`, schema, soft/hard delete, queries | 🟢 |
| `lib/services/supabase_service.dart` | `fetch*`, `upsert*`, `delete*`, storage | 🟢 |
| `lib/models/category.dart` | `isSynced`, `isDeleted`, maps | 🟢 |
| `lib/models/lyric.dart` | `isSynced`, `isDeleted`, maps | 🟢 |
| `lib/main.dart` | Provider `SyncRepository` | 🟢 |
| `lib/screens/home_screen.dart` | sync inicial, refresh, ícone offline | 🟢 |
| `lib/screens/splash_screen.dart` | progresso de download | 🟢 |
| `lib/screens/category_screen.dart` | refresh sync | 🟢 |
| `lib/screens/lyric_view_screen.dart` | refresh sync | 🟢 |
| `lib/screens/search_screen.dart` | refresh sync | 🟢 |
| `lib/screens/lyric_form_screen.dart` | `addLyric` após upload | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `reproducao-audio` | Consome `localAudioPath` produzido pelo download pós-sync. |
| `edicao-letra` | Upload de áudio via Storage + `addLyric` com `isSynced: false`. |
| `acervo-categorias` | CRUD de categorias via `SyncRepository`. |
| `autenticacao` | Supabase Auth paralelo; sync de conteúdo não exige login explícito para leitura local. |
