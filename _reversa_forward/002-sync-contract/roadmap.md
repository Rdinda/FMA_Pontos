# Roadmap: Contrato de Sincronização (Sync Contract)

> Identificador: `002-sync-contract`
> Data: `2026-05-31`
> Requirements: `_reversa_forward/002-sync-contract/requirements.md`
> Âncora normativa: `_reversa_sdd/sync-contract.md`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA

## 1. Resumo da abordagem

A feature implementa o **contrato de sincronização** normativo em `_reversa_sdd/sync-contract.md` como delta sobre o legado offline-first existente (`SyncRepository`, `DatabaseHelper`, `SupabaseService`, `AuthService`, `PlayStatsService`). A entrega segue **três milestones sequenciais** (Fases A → B → C), cada uma com migration/SQL versionado, alterações Dart localizadas e critérios Gherkin verificáveis do `requirements.md`.

**Fase A** alinha Postgres ao modelo local: coluna `is_deleted`, views `sync_*` SECURITY DEFINER para PULL incremental com tombstones, RLS de escrita reforçada e RPC `increment_play_count` em produção. **Fase B** substitui merge por campo (`SyncMerge._pickField`) por **LWW record-level**, adiciona gate Auth/RBAC no client e corrige cursor/upsert/observabilidade. **Fase C** introduz fila SQLite `pending_access_events` e flush no ciclo `syncData()` para ranking global offline.

PULL/leitura permanece aberto a anônimos; mutações de acervo e enfileiramento de stats offline exigem sessão autenticada não anônima com permissões adequadas.

## 2. Princípios aplicados

> `.reversa/principles.md` **não existe** neste projeto. Avaliação feita contra ADRs, `architecture-contract.md` e restrições do requirements.

| Princípio / restrição | Como a feature se relaciona | Status |
|------------------------|------------------------------|--------|
| ADR 001 — offline-first + soft delete | Mantém SQLite como fonte imediata; estende soft delete ao Postgres via `is_deleted` | respeita |
| ADR 002 — RBAC Google/admin | Reforça gate `can*` no sync layer e RLS; remove bypass anônimo nas telas | respeita |
| `architecture-contract.md` S-04 | Será **alterado** de merge por campo para LWW record-level (RF-B18) | respeita (delta explícito) |
| Escopo mínimo v1 (Q2/Q3) | MP3 no Storage não removido no soft delete; flush stats com N RPCs individuais | respeita |
| Migrations versionadas no repo | Toda mudança Postgres em `supabase/migrations/` | respeita |

## 3. Decisões técnicas

| ID | Decisão | Justificativa | Alternativas descartadas | Confidência |
|----|---------|----------------|--------------------------|-------------|
| D-01 | Views `sync_categories` / `sync_lyrics` SECURITY DEFINER para fetch incremental | Q1 clarify: SELECT público filtra `is_deleted=false`; tombstones precisam de canal dedicado | Policy SELECT dedicada `authenticated`; bypass service role no client | 🟢 |
| D-02 | LWW record-level substitui `SyncMerge._pickField` | Decisão stakeholder + RN-02; elimina snapshots híbridos | Manter merge por campo; CRDT | 🟢 |
| D-03 | Outbox acervo implícita via `is_synced=0` (sem tabela outbox) | Legado já usa fila inline; escopo mínimo | Tabela `sync_outbox` dedicada | 🟢 |
| D-04 | Gate RBAC no client **e** RLS no Postgres (defesa em profundidade) | Q5: RLS escrita na Fase A; client bloqueia fila antes do PUSH | Apenas RLS server-side | 🟢 |
| D-05 | `last_sync_timestamp` só persiste após PUSH+PULL completos | RN-06; corrige gap G7 | Avançar cursor parcial com watermark por entidade | 🟢 |
| D-06 | Flush stats: N chamadas `increment_play_count` (v1) | Q3 clarify; simplicidade e idempotência por evento | RPC batch `increment_play_count_bulk` | 🟢 |
| D-07 | Stats offline: enfileirar só autenticados não anônimos | Q4 clarify; anônimo não contribui ranking | Todos enfileiram; deduplicar por sessão | 🟢 |
| D-08 | v1: soft delete **não** remove MP3 do Storage | Q2 clarify; reversibilidade e escopo | Delete imediato no bucket | 🟢 |
| D-09 | `SupabaseService.fetch*` passa a consultar views `sync_*` no PULL incremental | Centraliza tombstones sem expor deletados na UI PostgREST | `.select()` direto em `categories`/`lyrics` com policy extra | 🟢 |
| D-10 | `SyncRepository` injeta `AuthService` para gate de permissão | Evita acoplamento estático; getters `can*` já existem | Duplicar matriz RBAC no sync | 🟢 |
| D-11 | Auditoria prod pós-Fase A (RF-B11) como migration corretiva opcional | Prod pode divergir do repo migration | Assumir prod = repo sem verificar | 🟡 |
| D-12 | Testes unitários Fase C em `test/unit/play_stats_sync_test.dart` | RF-C07; cobertura fila/flush/anônimo | Apenas testes manuais | 🟡 |

## 4. Premissas

| Premissa | Origem | Risco se errada |
|----------|--------|-----------------|
| Nenhuma `[DÚVIDA]` aberta após `/reversa-clarify` (Q1–Q5 resolvidas) | requirements §9–§10 | n/a — lacunas zeradas |
| Deploy Fase A aplicável a projeto Supabase remoto sem conflito com policies legadas | RF-A07, D-11 | Migration corretiva extra; downtime mínimo |
| `increment_play_count` do repo (`20251226191350_initial_schema.sql`) é suficiente para prod | RF-A06, backup 2026-01-21 | RPC customizada se assinatura divergir em prod |
| Empate LWW: local prevalece no PUSH, remoto no PULL | sync-contract §4.1 | Comportamento edge-case documentado em testes |

## 5. Delta arquitetural

| Componente | Arquivo de origem no legado | Tipo de mudança | Resumo |
|------------|------------------------------|-----------------|--------|
| Sync | `_reversa_sdd/architecture.md` → `SyncRepository` | regra-alterada | Ciclo PUSH→FLUSH→PULL→PUSH residual; LWW; gate auth; cursor seguro; observabilidade |
| Sync merge | `SyncMerge` | contrato-alterado | De merge por campo para LWW record-level (ou inline no repository) |
| Supabase data | `SupabaseService` | contrato-alterado | Fetch incremental via views `sync_*`; `toSupabaseMap` com `is_deleted` |
| Auth/RBAC | `AuthService` + telas | regra-alterada | Sync pós-login; remover `\|\| isAnonymous` em edição |
| SQLite | `DatabaseHelper` | componente-extinto (comportamento) | v6 + `pending_access_events`; upsert não ressuscita tombstone |
| Domain Models | `Category`, `Lyric` | contrato-alterado | Serialização `is_deleted` remota |
| Stats | `PlayStatsService` | componente-novo (fila) | Enqueue offline + `flushPendingAccessEvents()` |
| Postgres | `categories`, `lyrics`, RLS, RPC | contrato-alterado | `is_deleted`, views sync, policies escrita |
| Contrato arquitetural | `architecture-contract.md` S-04 | contrato-alterado | LWW record-level |

### Arquivos legado tocados (rascunho para `legacy-impact.md` no coding)

**Novos:**
- `supabase/migrations/20260531120000_sync_contract_phase_a.sql`
- `supabase/migrations/20260531120100_sync_contract_rls_prod_audit.sql` (condicional RF-B11)
- `test/unit/play_stats_sync_test.dart`

**Modificados:**
- `lib/services/sync_repository.dart`
- `lib/services/sync_merge.dart` (refatorar ou simplificar)
- `lib/services/supabase_service.dart`
- `lib/services/auth_service.dart`
- `lib/services/play_stats_service.dart`
- `lib/database/db_helper.dart`
- `lib/models/category.dart`
- `lib/models/lyric.dart`
- `lib/screens/lyric_view_screen.dart`
- `lib/screens/category_screen.dart`
- `_reversa_sdd/architecture-contract.md` (S-04, RF-B18)
- `_reversa_sdd/database/data-dictionary.md` (pós-deploy Fase A)

## 6. Delta no modelo de dados

- **Resumo:** Postgres ganha `is_deleted` + views sync + RLS ajustada; SQLite v6 ganha `pending_access_events`; SharedPreferences mantém `last_sync_timestamp` com semântica mais estrita.
- Detalhe completo em: `_reversa_forward/002-sync-contract/data-delta.md`

## 7. Delta de contratos externos

| Contrato | Tipo | Arquivo de detalhe |
|----------|------|--------------------|
| Fetch incremental sync (views `sync_*`) | PostgREST / HTTP | `_reversa_forward/002-sync-contract/interfaces/sync-incremental-fetch.md` |
| RPC `increment_play_count` | PostgREST RPC | `_reversa_forward/002-sync-contract/interfaces/increment_play_count.md` |
| Mutações acervo + RLS escrita | PostgREST / HTTP | `_reversa_forward/002-sync-contract/interfaces/acervo-mutations-rls.md` |

## 8. Plano de migração — Milestones

### Milestone M1 — Fase A: Fundação Postgres + soft delete remoto + RLS escrita

**Objetivo:** Desbloquear tombstones remotos, RPC stats e segurança de escrita server-side.

| # | Entrega | Artefato / caminho | RF |
|---|---------|-------------------|-----|
| M1.1 | Migration `is_deleted` + índices `updated_at` | `supabase/migrations/20260531120000_sync_contract_phase_a.sql` | RF-A01, RF-A02 |
| M1.2 | Views `sync_categories`, `sync_lyrics` SECURITY DEFINER + GRANT SELECT | mesma migration | RF-A03, RN-11 |
| M1.3 | Policies SELECT base com `is_deleted = false`; policies INSERT/UPDATE/DELETE alinhadas RBAC; revogar INSERT anônimo se existir; restringir INSERT/UPDATE direto em `lyric_play_stats` | mesma migration | RF-A07 |
| M1.4 | Garantir RPC `increment_play_count` (CREATE OR REPLACE + GRANT) | mesma migration ou bloco dedicado | RF-A06 |
| M1.5 | `Category.toSupabaseMap()` / `Lyric.toSupabaseMap()` incluem `is_deleted` | `lib/models/category.dart`, `lib/models/lyric.dart` | RF-A04, G10 |
| M1.6 | `SupabaseService.fetchCategories/fetchLyrics` consultam views `sync_*`; `fromMap` desserializa `is_deleted` | `lib/services/supabase_service.dart` | RF-A03, RF-A05 |
| M1.7 | Validar PUSH soft delete + PULL tombstone → `hardDelete*` local | `lib/services/sync_repository.dart` (ajuste mínimo se necessário) | RF-A05 |
| M1.8 | Documentar delta Postgres pós-deploy | `_reversa_sdd/database/data-dictionary.md` | NFR manutenibilidade |

**Critérios de aceite (Gherkin requirements §7 Fase A):**
- Admin soft-deleta letra → Postgres `is_deleted=true` → outro device PULL remove SQLite
- PULL incremental via views retorna tombstones com `updated_at > since`
- RPC `increment_play_count` incrementa `play_count` para autenticado
- Sessão anônima: INSERT em `lyrics` negado pelo Postgres
- Soft delete v1 **não** remove MP3 do Storage (RF-A08)

**Dependências:** Nenhuma (primeira fase). **Deploy:** migration Supabase antes ou junto com build app que usa views.

---

### Milestone M2 — Fase B: LWW + Auth/permission gate + observabilidade

**Objetivo:** Conflitos record-level, mutações sync só com RBAC, visibilidade operacional.

| # | Entrega | Artefato / caminho | RF |
|---|---------|-------------------|-----|
| M2.1 | LWW record-level (substituir `_pickField`) | `lib/services/sync_merge.dart` e/ou `lib/services/sync_repository.dart` | RF-B01 |
| M2.2 | PUSH-first: todos `is_synced=0` antes de PULL | `sync_repository.dart` `_pushPendingChanges` + ordem `syncData` | RF-B02 |
| M2.3 | PULL: não sobrescrever dirty local com `local.updated_at > remote.updated_at` | loop PULL em `sync_repository.dart` | RF-B03 |
| M2.4 | Segundo PUSH após PULL | já parcialmente presente (L154–155); validar pós-LWW | RF-B04 |
| M2.5 | Gate auth: `_pushPendingChanges` ignora anônimo / sem `can*` / `is_active=false` | `sync_repository.dart` + injeção `AuthService` | RF-B05–RF-B09 |
| M2.6 | Wrappers CRUD validam permissão antes de `is_synced=0` | `sync_repository.dart` `add*`/`update*`/`delete*` | RF-B06 |
| M2.7 | Remover `\|\| isAnonymous` em gates de edição | `lib/screens/lyric_view_screen.dart`, `lib/screens/category_screen.dart` | RF-B07, RN-08 |
| M2.8 | Preservar invariante `local_audio_path` no PULL | manter lógica L111–127 `sync_repository.dart` | RF-B10 |
| M2.9 | Cursor seguro: `last_sync_timestamp` só após sucesso PUSH+PULL | `sync_repository.dart`; estado `lastSyncError` | RF-B12, RF-B14 |
| M2.10 | Getters observabilidade | `pendingCategoriesCount`, `pendingLyricsCount`, `lastSyncAt`, `lastSyncError` | RF-B13, RF-B14 |
| M2.11 | Corrigir upsert que força `is_deleted=0` | `lib/database/db_helper.dart` L88–93, L163–168 | RF-B15, G9 |
| M2.12 | Sync automático pós-login Google | `lib/services/auth_service.dart` | RF-B16 |
| M2.13 | PULL sem gate editorial (anon OK) | validar `syncData` não bloqueia PULL | RF-B17 |
| M2.14 | Atualizar S-04 para LWW | `_reversa_sdd/architecture-contract.md` | RF-B18 |
| M2.15 | Auditoria/correção RLS prod se divergir | `supabase/migrations/20260531120100_sync_contract_rls_prod_audit.sql` (se necessário) | RF-B11 |

**Critérios de aceite (Gherkin requirements §7 Fase B):**
- Dois devices offline: vence `updated_at` maior (snapshot inteiro)
- Anônimo não empurra mutações; user sem `canEditLyrics` não edita
- PULL funciona para anônimo
- Falha PULL → cursor não avança + `lastSyncError` preenchido
- Moderador edita mas não deleta letra

**Dependências:** M1 deployada (Postgres com `is_deleted` e views).

---

### Milestone M3 — Fase C: Fila offline de acessos + flush

**Objetivo:** Ranking global inclui aberturas offline para autenticados.

| # | Entrega | Artefato / caminho | RF |
|---|---------|-------------------|-----|
| M3.1 | SQLite v6: tabela `pending_access_events` | `lib/database/db_helper.dart` `_upgradeDB` | RF-C01 |
| M3.2 | Enqueue offline só autenticado não anônimo | `lib/services/play_stats_service.dart` | RF-C02 |
| M3.3 | Online: RPC direto (requer M1.4) | `play_stats_service.dart` | RF-C03 |
| M3.4 | `flushPendingAccessEvents()` — N RPCs, marca `is_flushed=1` | `play_stats_service.dart` | RF-C04, RF-C05 |
| M3.5 | Integrar flush no ciclo: após PUSH acervo, antes PULL | `lib/services/sync_repository.dart` | RF-C04, RN-09 |
| M3.6 | Flush na reconexão (via `syncData` existente) | `sync_repository.dart` `_initConnectivity` | RN-09 |
| M3.7 | Getter `pendingAccessEventsCount` | `play_stats_service.dart` ou `sync_repository.dart` | RF-C06 |
| M3.8 | Testes unitários enqueue/flush/bloqueio anônimo | `test/unit/play_stats_sync_test.dart` | RF-C07 |

**Critérios de aceite (Gherkin requirements §7 Fase C):**
- 4 aberturas offline autenticado → reconectar → `play_count += 4`
- Anônimo offline: fila vazia, ranking inalterado
- Ordem: PUSH acervo → flush stats → PULL

**Dependências:** M1 (RPC), M2 (ciclo sync estável e cursor seguro).

---

### Ordem de deploy recomendada

1. Deploy migration Fase A no Supabase (staging → prod).
2. Release app com M1 + M2 (podem ir no mesmo build se migration já aplicada).
3. Release app com M3 (SQLite migration local automática no upgrade).
4. Smoke completo via `onboarding.md`.
5. Re-extração reversa parcial (`services`, `supabase-data`) pós-merge.

**Rollback:** Reverter app; migrations Postgres são forward-only — plano de rollback documentado em `data-delta.md`.

## 9. Riscos e mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| Prod RLS diverge do repo migration | Alto | Médio | RF-B11 auditoria; migration corretiva; teste PostgREST anônimo |
| Views SECURITY DEFINER mal configuradas (vazamento tombstones na UI) | Alto | Baixo | SELECT público permanece em tabelas base com filtro; app UI lê SQLite |
| LWW perde edições concorrentes em campos diferentes | Médio | Esperado | Decisão stakeholder documentada; testes two-device |
| Flush N RPCs lento com fila grande | Médio | Baixo (v1) | Aceito Q3; monitorar `pendingAccessEventsCount`; batch futuro |
| Usuários legados com `is_synced=0` anônimos na fila | Médio | Médio | PUSH ignora linhas sem permissão; não envia ao remoto |
| Migration SQLite v6 falha em devices antigos | Alto | Baixo | Testar upgrade v5→v6; backup automático sqflite |
| Cursor preso após erro intermitente | Médio | Médio | `lastSyncError` + pull-to-refresh; logs estruturados |

## 10. Critério de pronto

- [ ] Milestones M1, M2, M3 completos com critérios Gherkin §7 verificados
- [ ] RF-A01–RF-A07, RF-B01–RF-B17 (Must/Should aplicáveis), RF-C01–RF-C05 implementados
- [ ] `flutter analyze` sem issues novos
- [ ] `flutter test` incluindo `play_stats_sync_test.dart` (RF-C07)
- [ ] Migration Supabase aplicada em staging/prod documentada
- [ ] `_reversa_sdd/database/data-dictionary.md` atualizado pós-deploy
- [ ] `_reversa_sdd/architecture-contract.md` S-04 = LWW
- [ ] Todas as ações do `actions.md` marcadas `[X]` (após `/reversa-coding`)
- [ ] `regression-watch.md` gerado (após coding)
- [ ] Smoke `onboarding.md` executado

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial gerada por `/reversa-plan` | reversa |
