# Requirements: Contrato de Sincronização (Sync Contract)

> Identificador: `002-sync-contract`
> Data: `2026-05-31`
> Pasta da extração reversa: `_reversa_sdd/`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA / DÚVIDA
> Âncora normativa: `_reversa_sdd/sync-contract.md`

## 1. Resumo executivo

Implementar o **contrato de sincronização** definido em `_reversa_sdd/sync-contract.md`, alinhando Postgres, SQLite, `SyncRepository`, Auth/RBAC e estatísticas de acesso ao modelo offline-first acordado com o stakeholder.

A feature corrige lacunas críticas do legado: soft delete remoto ausente (`is_deleted`), conflitos resolvidos por merge por campo em vez de LWW record-level, stats de acesso perdidos offline, RPC `increment_play_count` ausente em produção, e PUSH de acervo sem gate de autenticação/permissão RBAC.

Entrega organizada em **três fases** (A: fundação Postgres + soft delete remoto + RLS escrita; B: LWW + auth gate client + observabilidade; C: fila offline de acessos), com critérios de aceite verificáveis por fase. PULL/leitura permanece disponível para todos (incluindo anônimos); mutações que empurham acervo exigem sessão não anônima, `is_active = true` e getter `AuthService.can*` correspondente. Stats offline enfileiram apenas para autenticados não anônimos.

Público: praticantes (leitura offline), colaboradores com roles `user`/`moderator`/`admin` (CRUD conforme matriz RBAC), e operadores que diagnosticam falhas de sync.

## 2. Contexto a partir do legado

| Fonte | Trecho relevante | Confidência |
|-------|------------------|-------------|
| `_reversa_sdd/sync-contract.md#2` | Delta estado atual vs modelo alvo (LWW, is_deleted, stats, auth) | 🟢 |
| `_reversa_sdd/sync-contract.md#11` | Fases A/B/C com artefatos e critérios de aceite | 🟢 |
| `_reversa_sdd/sync-contract.md#10` | Checklist de gaps G1–G12 | 🟢 |
| `_reversa_sdd/sincronizacao-offline/requirements.md` | Ciclo PUSH→PULL, soft delete local, merge por campo (legado) | 🟢 |
| `_reversa_sdd/adrs/001-offline-first-sync-soft-delete.md` | ADR offline-first e soft delete | 🟢 |
| `_reversa_sdd/architecture.md#Sync online` | Orquestração `SyncRepository.syncData()` | 🟢 |
| `_reversa_sdd/architecture-contract.md` | Regra S-04 conflito (será alterada para LWW) | 🟢 |
| `_reversa_sdd/permissions.md#Matriz de Permissões de UI` | Getters `canAddLyrics`, `canEditLyrics`, etc. | 🟢 |
| `_reversa_sdd/autenticacao/requirements.md` | Sessão anônima, Google login, `is_active` | 🟢 |
| `_reversa_sdd/estatisticas-mais-tocados/requirements.md` | Ranking global via `lyric_play_stats` | 🟢 |
| `_reversa_sdd/database/data-dictionary.md` | Postgres sem `is_deleted`; RPC ausente em prod (backup 2026-01-21) | 🟢 |
| `_reversa_sdd/database/business-rules.md` | RLS `has_role`, INSERT anônimo legado permissivo | 🟡 |
| `_reversa_sdd/domain.md#Sincronização` | Offline-first, `is_synced`, cursor incremental | 🟢 |
| `_reversa_sdd/code-analysis.md#services` | `sync_repository.dart`, `sync_merge.dart`, `play_stats_service.dart` | 🟡 |

### Rastreabilidade gaps legado → requisitos

| Gap (sync-contract §10) | Severidade | Requisitos desta feature |
|-------------------------|------------|--------------------------|
| G1 Postgres sem `is_deleted` | 🔴 | RF-A01–RF-A05, RN-01 |
| G2 Merge por campo, não LWW | 🟠 | RF-B01–RF-B04, RN-02 |
| G3 Sem fila offline stats | 🔴 | RF-C01–RF-C05, RN-05, RN-11 |
| G4 RPC `increment_play_count` ausente em prod | 🔴 | RF-A06, RF-C03 |
| G5 Sync sem login/permissão; bypass anônimo na UI | 🟠 | RF-B05–RF-B10, RN-03–RN-04 |
| G6 RLS prod pode divergir | 🟠 | RF-A07, RF-B11 |
| G7 Cursor avança com falha parcial | 🟡 | RF-B12, RN-06 |
| G8 Sem métricas de pendentes/erro na UI | 🟡 | RF-B13–RF-B14 |
| G9 `upsert*` ressuscita soft-deleted | 🟡 | RF-B15 |
| G10 `toSupabaseMap()` omite `is_deleted` | 🟡 | RF-A04 |
| G11 Colisão basename download áudio | 🟢 | Fora do escopo mínimo |
| G12 Sync pós-login Google ausente | 🟡 | RF-B16 |

## 3. Personas e cenários de uso

| Persona | Objetivo | Cenário-chave |
|---------|----------|---------------|
| Visitante anônimo | Consumir acervo atualizado | Abre app offline/online, recebe PULL, lê letras; **não** edita, **não** enfileira push de acervo nem stats offline |
| Colaborador (`user`) | Cadastrar letras novas | Cria letra online/offline com `canAddLyrics`; sync propaga ao reconectar; aberturas offline de letra contam no ranking |
| Moderador | Editar acervo editorial | Edita letra/categoria; conflito offline com outro device resolve por LWW |
| Admin | Excluir conteúdo | Soft delete categoria/letra propaga tombstone ao Postgres e remove local após confirmação; MP3 permanece no Storage na v1 |
| Praticante offline (autenticado) | Contribuir para ranking global | Abre letra N vezes sem rede; ao reconectar, `play_count` remoto incrementa N |
| Operador | Diagnosticar sync | Consulta contagem de pendentes e último erro sem depender de logs de debug |

### User stories

| ID | Como… | Quero… | Para… | Fase | RF |
|----|-------|--------|-------|------|-----|
| US-01 | admin | que exclusões locais propaguem `is_deleted` ao Postgres | outros dispositivos removam o conteúdo no próximo PULL | A | RF-A01–RF-A05 |
| US-02 | moderador | que edições concorrentes offline resolvam pelo `updated_at` mais recente | não ter campos misturados de versões diferentes | B | RF-B01–RF-B04 |
| US-03 | visitante anônimo | receber atualizações remotas sem login | manter acervo local atualizado | B | RF-B17 |
| US-04 | user logado | ser impedido de editar letra sem role `moderator` | RBAC ser respeitado no client e na fila de sync | B | RF-B05–RF-B09 |
| US-05 | colaborador autenticado | que cada abertura de letra offline conte no ranking | estatísticas globais refletirem uso real | C | RF-C01–RF-C05 |
| US-06 | colaborador | sync automático após login Google | ver alterações feitas em outro device | B | RF-B16 |
| US-07 | operador | ver quantos registros aguardam sync | decidir se força refresh ou investiga erro | B | RF-B13–RF-B14 |

## 4. Regras de negócio novas ou alteradas

1. **RN-01:** Postgres deve possuir coluna `is_deleted boolean NOT NULL DEFAULT false` em `categories` e `lyrics`, espelhando SQLite; tombstones entram no PULL incremental via views de sync. 🟢
   - Origem no legado: `_reversa_sdd/sync-contract.md#5.2`; gap G1
   - Tipo: nova (schema remoto)

2. **RN-02:** Conflitos entre versões local e remota do **mesmo id** resolvem por **LWW record-level**: vence o registro cujo `updated_at` é estritamente maior; empate: local prevalece no PUSH, remoto no PULL. 🟢
   - Origem no legado: `_reversa_sdd/sincronizacao-offline/requirements.md#RF-21` (merge por campo — **substituída**)
   - Tipo: alterada

3. **RN-03:** Mutações de acervo que geram PUSH ou `is_synced = 0` exigem: sessão não anônima, `user_roles.is_active = true`, e getter `AuthService.can*` da operação (`canAddLyrics`, `canEditLyrics`, `canDeleteLyrics`, `canAddCategories`, `canEditCategories`, `canDeleteCategories`). 🟢
   - Origem no legado: `_reversa_sdd/permissions.md#Matriz de Permissões de UI`; `_reversa_sdd/sync-contract.md#7.1`
   - Tipo: alterada (reforço no sync layer)

4. **RN-04:** PULL incremental e leitura SQLite **não** exigem permissão de escrita; anônimos e autenticados recebem alterações remotas. 🟢
   - Origem: `_reversa_sdd/sync-contract.md#7.2`
   - Tipo: nova (explicitação)

5. **RN-05:** Acessos à tela de letra offline enfileiram eventos em `pending_access_events` **apenas** para sessão autenticada não anônima; flush ocorre após PUSH de acervo e antes do PULL, e na reconexão. 🟢
   - Origem no legado: `_reversa_sdd/estatisticas-mais-tocados/requirements.md`; gap G3; esclarecimento Q4
   - Tipo: nova

6. **RN-06:** `last_sync_timestamp` só avança após PUSH **e** PULL bem-sucedidos; falha parcial não move o cursor. 🟢
   - Origem no legado: `_reversa_sdd/sincronizacao-offline/requirements.md#RF-10` (comportamento legado avançava mesmo com falhas — gap G7)
   - Tipo: alterada

7. **RN-07:** Registro remoto com `is_deleted = true` remove local independentemente de LWW de conteúdo (evento terminal). 🟢
   - Origem: `_reversa_sdd/sync-contract.md#4.3`; ADR 001
   - Tipo: confirmada

8. **RN-08:** Remover bypass `canEditLyrics || isAnonymous` nas telas de edição; CRUD local bloqueado sem permissão correspondente. 🟢
   - Origem: `_reversa_sdd/sync-contract.md#7.3`; gap G5
   - Tipo: alterada

9. **RN-09:** Ordem normativa do ciclo `syncData`: PUSH acervo → FLUSH stats → PULL → PUSH residual → cursor → download MP3. 🟢
   - Origem: `_reversa_sdd/sync-contract.md#3.1`
   - Tipo: alterada (inserção flush na Fase C)

10. **RN-10:** `upsertCategory`/`upsertLyric` local **não** deve ressuscitar registro com `is_deleted = 1` acidentalmente. 🟢
    - Origem: gap G9; `_reversa_sdd/sync-contract.md#3.4`
    - Tipo: alterada

11. **RN-11:** Fetch incremental de tombstones usa views `sync_categories` e `sync_lyrics` com `SECURITY DEFINER`; UI e SELECT público nas tabelas base continuam filtrando `is_deleted = false`. 🟢
    - Origem: esclarecimento Q1; `_reversa_sdd/sync-contract.md#12`
    - Tipo: nova

12. **RN-12:** Na v1, soft delete **não** remove arquivos MP3 do Supabase Storage; limpeza de objetos órfãos fica fora do escopo mínimo (job admin assíncrono futuro). 🟢
    - Origem: esclarecimento Q2
    - Tipo: nova (limitação de escopo)

## 5. Requisitos Funcionais

### Fase A — Fundação Postgres + soft delete remoto + RLS escrita

| ID | Requisito | Prioridade | Critério de aceite | Confidência |
|----|-----------|------------|--------------------|-------------|
| RF-A01 | Adicionar `is_deleted` em `categories` e `lyrics` no Postgres via migration versionada | Must | Dado deploy da migration, quando `\d categories` e `\d lyrics`, então coluna `is_deleted boolean NOT NULL DEFAULT false` existe | 🟢 |
| RF-A02 | Criar índices em `updated_at` para sync incremental incluindo tombstones | Must | Dado migration aplicada, quando consulta catálogo de índices, então `idx_categories_updated_at` e `idx_lyrics_updated_at` existem | 🟢 |
| RF-A03 | Criar views `sync_categories` e `sync_lyrics` (`SECURITY DEFINER`) para fetch incremental com tombstones; policies SELECT públicas nas tabelas base filtram `is_deleted = false` para UI/PostgREST anônimo | Must | Dado leitura UI via PostgREST anônima em `lyrics`, então registros deletados não aparecem; dado `SupabaseService` fetch sync incremental via views `sync_*`, então registros com `is_deleted=true` e `updated_at > since` são retornados | 🟢 |
| RF-A04 | Modelos `Category`/`Lyric` serializam `is_deleted` em `toSupabaseMap()` e desserializam em `fromMap` | Must | Dado soft delete local, quando PUSH executa upsert/delete, então payload inclui `is_deleted` conforme estado | 🟢 |
| RF-A05 | Soft delete local propaga ao remoto e PULL de tombstone remove SQLite | Must | Dado admin soft-deleta letra online, quando outro device faz PULL, então letra some do SQLite local (hard delete pós-confirmação) | 🟢 |
| RF-A06 | RPC `increment_play_count` disponível em produção (migration ou SQL proposto) | Must | Dado usuário autenticado, quando chama RPC com `lyric_id` válido, então `play_count` incrementa atomicamente | 🟢 |
| RF-A07 | Migration Fase A alinha RLS de escrita: INSERT/UPDATE/DELETE exigem `authenticated` não anônimo + `has_role` adequado; revogar INSERT anônimo legado se ainda presente; restringir `lyric_play_stats` a RPC SECURITY DEFINER quando possível | Must | Dado sessão anônima, quando tenta INSERT em `lyrics`, então operação é negada pelo Postgres; dado deploy Fase A, então policies de escrita equivalentes ao alvo em `_reversa_sdd/permissions.md` | 🟢 |
| RF-A08 | v1: soft delete **não** dispara remoção de objetos MP3 no Supabase Storage | Won't (v1) | Dado admin soft-deleta letra com `audio_url` no Storage, quando exclusão conclui, então objeto permanece no bucket até limpeza administrativa futura | 🟢 |

### Fase B — LWW + Auth/permission gate + observabilidade

| ID | Requisito | Prioridade | Critério de aceite | Confidência |
|----|-----------|------------|--------------------|-------------|
| RF-B01 | Substituir merge por campo (`SyncMerge._pickField`) por LWW record-level | Must | Dado local e remoto com campos divergentes no mesmo id, quando resolve conflito, então snapshot inteiro do vencedor (`updated_at` maior) prevalece | 🟢 |
| RF-B02 | PUSH-first: processar todos `is_synced=0` antes de qualquer PULL | Must | Dado fila com pendentes, quando `syncData` inicia, então `getUnsynced*` completa antes de `fetch*` | 🟢 |
| RF-B03 | No PULL, não sobrescrever local dirty com `local.updated_at > remote.updated_at` | Must | Dado edição offline recente, quando PULL traz versão remota mais antiga, então SQLite mantém local até PUSH | 🟢 |
| RF-B04 | Executar segundo PUSH após PULL que marcou registros como pendentes | Must | Dado PULL aplicou remoto sobre dirty perdedor, quando ciclo continua, então segundo PUSH envia estado final | 🟢 |
| RF-B05 | `SyncRepository._pushPendingChanges` ignora linhas se `isAnonymous` ou sem `can*` da operação inferida | Must | Dado anônimo com `is_synced=0` legado, quando PUSH roda, então linha não é enviada ao remoto | 🟢 |
| RF-B06 | Wrappers CRUD (`add*`, `update*`, `delete*`) validam permissão antes de marcar `is_synced=0` | Must | Dado user sem `canEditLyrics`, quando tenta editar letra, então operação é rejeitada e `is_synced` permanece inalterado | 🟢 |
| RF-B07 | Remover `|| isAnonymous` de gates de edição em `lyric_view_screen` e `category_screen` | Must | Dado anônimo na tela de letra, quando tenta editar, então ação de edição não está disponível | 🟢 |
| RF-B08 | Usuário com `is_active=false` não enfileira mutações de acervo | Must | Dado conta desativada pós-login bloqueado, quando tenta CRUD, então fila de push não recebe novos itens | 🟢 |
| RF-B09 | Matriz operação→permissão conforme sync-contract §7.1 (CREATE letra=`canAddLyrics`, UPDATE letra=`canEditLyrics`, DELETE letra=`canDeleteLyrics`, CRUD categoria conforme `can*Categories`) | Must | Dado moderator, quando DELETE letra, então operação negada; quando UPDATE letra, então permitida | 🟢 |
| RF-B10 | Preservar invariante de mídia local no PULL (path quando URL inalterada; invalidar se URL mudou) | Must | Dado letra com MP3 baixado, quando PULL sem mudança de `audio_url`, então `local_audio_path` preservado | 🟢 |
| RF-B11 | Auditar ambiente prod pós-Fase A: se policies divergirem do baseline entregue em RF-A07, aplicar migration corretiva | Should | Dado ambiente prod auditado após deploy Fase A, quando comparado a `_reversa_sdd/permissions.md`, então divergências documentadas ou corrigidas | 🟡 |
| RF-B12 | Cursor `last_sync_timestamp` só persiste após sucesso completo de PUSH+PULL | Must | Dado falha no PULL, quando ciclo termina, então cursor mantém valor anterior | 🟢 |
| RF-B13 | Expor getters `pendingCategoriesCount`, `pendingLyricsCount`, `lastSyncError`, `lastSyncAt` | Should | Dado fila com 3 letras pendentes, quando UI consulta getter, então retorna 3 | 🟢 |
| RF-B14 | Substituir falhas silenciosas (`debugPrint` only) por estado observável de erro de sync | Should | Dado erro de rede no PUSH, quando ciclo falha, então `lastSyncError` contém mensagem e cursor não avança | 🟢 |
| RF-B15 | Corrigir `upsertCategory`/`upsertLyric` para não forçar `is_deleted=0` em registro tombstone | Must | Dado registro soft-deleted local, quando upsert acidental ocorre, então tombstone não é ressuscitado | 🟢 |
| RF-B16 | Disparar `syncData()` após login Google bem-sucedido | Should | Dado login Google completo, quando sessão estabelecida, então sync inicia automaticamente | 🟢 |
| RF-B17 | PULL permanece disponível para sessões anônimas e autenticadas sem gate editorial | Must | Dado anônimo online, quando `syncData`, então PULL executa e SQLite atualiza | 🟢 |
| RF-B18 | Atualizar contrato arquitetural S-04 para LWW record-level | Should | Dado merge concluído, quando lê `architecture-contract.md`, então S-04 descreve LWW | 🟢 |

### Fase C — Fila offline de acessos + flush

| ID | Requisito | Prioridade | Critério de aceite | Confidência |
|----|-----------|------------|--------------------|-------------|
| RF-C01 | Migrar SQLite para versão 6 com tabela `pending_access_events` | Must | Dado upgrade de DB, quando schema inspecionado, então tabela existe com colunas `id`, `lyric_id`, `accessed_at`, `is_flushed` | 🟢 |
| RF-C02 | Offline: `PlayStatsService.incrementAccessCount` insere fila local **somente** se sessão autenticada não anônima; anônimo offline não enfileira | Must | Dado modo offline e user autenticado não anônimo, quando abre letra, então 1 linha em `pending_access_events` com `is_flushed=0`; dado anônimo offline, quando abre letra, então nenhuma linha é inserida | 🟢 |
| RF-C03 | Online: manter chamada RPC `increment_play_count` (requer RF-A06) para autenticados não anônimos | Must | Dado online, RPC disponível e sessão não anônima, quando abre letra, então `play_count` remoto incrementa sem fila | 🟢 |
| RF-C04 | `SyncRepository` chama flush de stats após PUSH acervo e antes do PULL; também na reconexão; v1 usa N chamadas RPC individuais (sem batch) | Must | Dado 5 eventos pendentes e rede restaurada, quando sync completa flush, então `play_count` remoto += 5 via 5 RPCs e eventos `is_flushed=1` | 🟢 |
| RF-C05 | Flush não deduplica eventos (cada abertura = +1 intencional) | Must | Dado 3 aberturas offline da mesma letra, quando flush, então RPC chamada 3 vezes | 🟢 |
| RF-C06 | Expor `pendingAccessEventsCount` para diagnóstico | Could | Dado fila stats, quando getter consultado, então retorna contagem correta | 🟢 |
| RF-C07 | Testes unitários cobrindo enqueue offline + flush + bloqueio anônimo | Should | Dado suite `play_stats_sync_test`, quando executada, então cenários offline→online e anônimo bloqueado passam | 🟡 |

## 6. Requisitos Não Funcionais

| Tipo | Requisito | Evidência ou justificativa | Confidência |
|------|-----------|----------------------------|-------------|
| Segurança | Escritas de acervo negadas client-side e server-side para anônimos e roles insuficientes; RLS de escrita entregue na Fase A (RF-A07) | `_reversa_sdd/sync-contract.md#7`; `_reversa_sdd/permissions.md`; esclarecimento Q5 | 🟢 |
| Segurança | Fetch sync de tombstones via views `sync_*` SECURITY DEFINER; SELECT público sem tombstones | esclarecimento Q1; RF-A03 | 🟢 |
| Segurança | Incremento de stats via RPC SECURITY DEFINER; revogar INSERT/UPDATE direto client em `lyric_play_stats` quando possível | `_reversa_sdd/database/business-rules.md`; sync-contract §7.4 | 🟡 |
| Segurança | Stats offline: apenas autenticados não anônimos enfileiram | esclarecimento Q4; RN-05 | 🟢 |
| Confiabilidade | Idempotência de flush: falha parcial mantém eventos `is_flushed=0` para retry | sync-contract §6.3 | 🟢 |
| Observabilidade | Métricas de pendentes e último erro acessíveis sem adb/logcat | gap G8 | 🟢 |
| Compatibilidade | Preservar ciclo existente de download MP3 pós-sync; v1 não remove MP3 do Storage no soft delete | `_reversa_sdd/sincronizacao-offline/requirements.md#RF-11`; RN-12 | 🟢 |
| Manutenibilidade | Migrations Supabase versionadas no repositório; documentar delta em `_reversa_sdd/database/data-dictionary.md` pós-deploy | sync-contract Fase A | 🟢 |
| Desempenho | Flush stats v1: N chamadas RPC individuais aceitas; `increment_play_count_bulk` fora do escopo mínimo | esclarecimento Q3; RF-C04 | 🟢 |

## 7. Critérios de Aceitação

### Fase A

```gherkin
Cenário: Soft delete local propaga tombstone ao Postgres
  Dado um admin autenticado com canDeleteLyrics
  E uma letra existente sincronizada
  Quando o admin exclui a letra (soft delete)
  Então o Postgres registra is_deleted=true com updated_at atualizado
  E o registro local é removido fisicamente após confirmação remota
  E o arquivo MP3 permanece no Supabase Storage (v1)

Cenário: PULL incremental recebe tombstone remoto via views sync_*
  Dado dispositivo B com letra L no SQLite
  E dispositivo A que soft-deletou L no Postgres
  Quando dispositivo B executa syncData online
  Então L desaparece do SQLite em B
  E arquivos MP3 locais de L são removidos se existirem

Cenário: RPC increment_play_count operacional
  Dado usuário autenticado não anônimo
  E RPC deployada em produção
  Quando incrementAccessCount é chamado online
  Então lyric_play_stats.play_count incrementa em 1

Cenário: RLS escrita bloqueia anônimo na Fase A
  Dado sessão anônima
  Quando tenta INSERT em lyrics via PostgREST
  Então operação é negada pelo Postgres
```

### Fase B

```gherkin
Cenário: LWW record-level em conflito offline
  Dado dispositivo A edita letra L offline às 10:00 (updated_at T1)
  E dispositivo B edita a mesma letra L offline às 11:00 (updated_at T2, T2 > T1)
  Quando ambos reconectam e sincronizam
  Então a versão de B prevalece integralmente no Postgres e nos devices

Cenário: Anônimo não empurra mutações de acervo
  Dado sessão anônima
  Quando tenta adicionar ou editar letra via SyncRepository
  Então a operação é bloqueada
  E nenhum registro com is_synced=0 é criado para push de acervo

Cenário: User logado não edita letra sem role moderator
  Dado colaborador com role user autenticado
  Quando tenta editar título de letra existente
  Então UI e SyncRepository negam a mutação
  E canEditLyrics permanece falso

Cenário: PULL funciona para anônimo
  Dado visitante anônimo online
  Quando syncData executa
  Então categorias e letras remotas são aplicadas ao SQLite local

Cenário: Cursor não avança após falha de PULL
  Dado last_sync_timestamp = T0
  E falha de rede durante fetchLyrics
  Quando syncData termina com erro
  Então last_sync_timestamp permanece T0
  E lastSyncError registra a falha
```

### Fase C

```gherkin
Cenário: Acessos offline contam no ranking após reconexão
  Dado usuário autenticado não anônimo offline
  E letra L com play_count remoto = 10
  Quando abre L 4 vezes offline
  E reconecta e syncData completa flush
  Então play_count remoto de L = 14

Cenário: Anônimo offline não enfileira stats
  Dado visitante anônimo offline
  Quando abre letra L três vezes
  E reconecta e syncData executa
  Então pending_access_events permanece vazio
  E play_count remoto de L não incrementa por essas aberturas

Cenário: Ordem flush no ciclo de sync
  Dado eventos pendentes em pending_access_events
  E alterações de acervo com is_synced=0
  Quando syncData executa
  Então PUSH de acervo ocorre antes do flush de stats
  E flush ocorre antes do PULL incremental
```

### Casos negativos

```gherkin
Cenário: Conta inativa não sincroniza escrita
  Dado usuário com is_active=false
  Quando tenta criar letra
  Então operação é negada
  E fila de push de acervo não recebe o item

Cenário: Moderador não pode deletar letra
  Dado moderador autenticado sem canDeleteLyrics
  Quando tenta soft delete de letra
  Então operação negada na UI e no SyncRepository
```

## 8. Prioridade MoSCoW

| Item | MoSCoW | Justificativa |
|------|--------|---------------|
| RF-A01–RF-A05 (is_deleted Postgres + views sync) | Must | Desbloqueia soft delete remoto; gap G1 crítico |
| RF-A06 (RPC prod) | Must | Pré-requisito stats online e flush Fase C; gap G4 |
| RF-A07 (RLS escrita Fase A) | Must | Segurança de escrita; gap G6; decisão Q5 |
| RF-A08 (Storage MP3 v1) | Won't remover | Escopo v1 explícito; decisão Q2 |
| RF-B01–RF-B04 (LWW) | Must | Decisão stakeholder; gap G2 |
| RF-B05–RF-B09 (auth gate) | Must | Segurança editorial; gap G5 |
| RF-B12 (cursor seguro) | Must | Integridade incremental; gap G7 |
| RF-B15 (upsert tombstone) | Must | Corrupção de dados; gap G9 |
| RF-C01–RF-C05 (fila stats + gate auth) | Must | Ranking global offline; gap G3; Q3/Q4 |
| RF-B13–RF-B14 (observabilidade) | Should | Operabilidade; gap G8 |
| RF-B16 (sync pós-login) | Should | UX multi-device; gap G12 |
| RF-B18 (doc S-04) | Should | Rastreabilidade contrato |
| RF-C06–RF-C07 (diagnóstico/testes) | Could/Should | Qualidade incremental |
| Cache local ranking offline | Won't (v1) | sync-contract §6.3 — fora escopo mínimo |
| Batch RPC flush (`increment_play_count_bulk`) | Won't (v1) | Q3 — N chamadas RPC na v1 |
| Remoção MP3 Storage no soft delete | Won't (v1) | Q2 — job admin futuro |

## 9. Esclarecimentos

### Sessão 2026-05-31

> Confirmado via CONTINUAR sem respostas explícitas — aplicadas recomendações técnicas da rodada clarify (2026-05-31).

- **Q:** Fetch incremental pós-RLS com SELECT filtrando `is_deleted=false` — usar views `sync_lyrics`/`sync_categories` SECURITY DEFINER ou policy dedicada `authenticated` para tombstones?
  **R:** **1a** — views `sync_categories` e `sync_lyrics` com `SECURITY DEFINER`; app consulta views no fetch incremental; UI/SELECT público nas tabelas base mantém filtro `is_deleted = false`.

- **Q:** Remoção de MP3 no Storage no soft delete — imediata ou job assíncrono admin?
  **R:** **2a** — v1 **não** remove MP3 no Storage no soft delete; limpeza de objetos órfãos fica fora do escopo mínimo (job admin futuro).

- **Q:** Flush de stats com filas grandes — manter N chamadas RPC na v1 ou exigir `increment_play_count_bulk` antes de release?
  **R:** **3a** — v1 mantém **N chamadas RPC individuais** no flush; batch RPC fora do escopo mínimo.

- **Q:** Quem pode enfileirar `pending_access_events` offline?
  **R:** **4a** — **somente** sessões autenticadas **não anônimas** enfileiram offline; anônimo não incrementa fila nem ranking via flush.

- **Q:** RLS de escrita alinhada em qual fase?
  **R:** **5a** — RLS de escrita (INSERT/UPDATE/DELETE + bloqueio anônimo) entregue na **Fase A** via RF-A07; Fase B (RF-B11) fica como auditoria/correção pós-deploy se prod divergir.

## 10. Lacunas

> Nenhuma lacuna aberta. Todas as dúvidas da rodada clarify (Q1–Q5) foram integradas na sessão 2026-05-31.

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial gerada por `/reversa-requirements` | reversa |
| 2026-05-31 | Integração `/reversa-clarify`: Q1–Q5 (defaults 1a–5a via CONTINUAR); RF-A03/A07/A08, RN-11/12, RF-C02/C04, Lacunas zeradas | reversa-clarify |
