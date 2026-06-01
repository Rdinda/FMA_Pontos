# Onboarding de teste: 002-sync-contract

> Guia para validar o contrato de sincronização pela primeira vez.
> Data: `2026-05-31`

## Pré-requisitos

1. Flutter SDK (`flutter doctor`) e Android CLI (`android info`) OK.
2. `dart_defines.json` com `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `GOOGLE_SERVER_CLIENT_ID`.
3. **Migration Fase A aplicada** no projeto Supabase alvo (staging recomendado antes de prod):
   - `supabase/migrations/20260531120000_sync_contract_phase_a.sql`
4. Contas de teste:
   - Visitante anônimo (app fresh / logout)
   - Colaborador `user` (Google login)
   - Moderador (`moderator` em `user_roles`)
   - Admin (`admin` em `user_roles`)
5. Dois dispositivos ou emulador + físico para testes LWW (Fase B).

## Como rodar

```powershell
cd c:\Users\rdinda\Documents\GitHub\FMA_Pontos
.\run-dev.ps1
```

## Checklist — Fase A (Postgres + soft delete)

### RF-A01–A03 Schema e views

- [ ] Supabase Dashboard: colunas `is_deleted` em `categories` e `lyrics`.
- [ ] Views `sync_categories` e `sync_lyrics` existem.
- [ ] PostgREST anônimo em `lyrics`: registros com `is_deleted=true` **não** aparecem.
- [ ] Query manual em `sync_lyrics` (service role ou SQL editor): tombstones visíveis.

### RF-A05 Soft delete end-to-end

- [ ] **Admin** logado: excluir letra sincronizada.
- [ ] Verificar Postgres: `is_deleted = true`, `updated_at` atualizado.
- [ ] **Device B** online: pull-to-refresh / reopen app → letra some do SQLite.
- [ ] MP3 local removido se existia; objeto Storage **permanece** (RF-A08).

### RF-A06 RPC stats

- [ ] Autenticado online: abrir letra → `lyric_play_stats.play_count` incrementa via RPC.
- [ ] Supabase logs: sem fallback INSERT direto se RPC OK.

### RF-A07 RLS escrita

- [ ] Sessão anônima: tentativa INSERT `lyrics` via API negada (403/RLS).

## Checklist — Fase B (LWW + Auth + observabilidade)

### RF-B01–B04 LWW

- [ ] Device A offline: editar letra L às T1.
- [ ] Device B offline: editar mesma letra L às T2 (T2 > T1).
- [ ] Ambos online sync → versão B prevalece **integralmente** (título + conteúdo).

### RF-B05–B09 Auth gate

- [ ] Anônimo: botão editar letra **indisponível** (sem bypass).
- [ ] Anônimo: tentar CRUD via código/debug → fila push não envia.
- [ ] User logado: pode **criar** letra; **não** edita letra existente.
- [ ] Moderador: edita letra; **não** deleta.
- [ ] Admin: soft delete permitido.

### RF-B12–B14 Cursor e erros

- [ ] Simular falha rede no PULL (modo avião mid-sync): `last_sync_timestamp` **não** avança.
- [ ] `lastSyncError` (ou equivalente UI) exibe mensagem.
- [ ] Getters pendentes: criar letra offline → contagem > 0.

### RF-B16 Sync pós-login

- [ ] Logout → login Google: sync inicia automaticamente.

### RF-B17 PULL anônimo

- [ ] Anônimo online: sync atualiza acervo local.

## Checklist — Fase C (Stats offline)

### RF-C01–C05 Fila e flush

- [ ] Autenticado: modo avião → abrir letra L **4 vezes**.
- [ ] SQLite: 4 linhas em `pending_access_events` (`is_flushed=0`).
- [ ] Reconectar → sync → `play_count` remoto += 4.
- [ ] Ordem: após edit offline acervo + stats, verificar PUSH acervo antes flush (logs/debug).

### RF-C02 Anônimo offline stats

- [ ] Anônimo offline: abrir letra 3× → reconectar → fila vazia; ranking inalterado.

### RF-C07 Testes automatizados

```powershell
flutter test test/unit/play_stats_sync_test.dart
```

## Comandos úteis

```powershell
flutter analyze
flutter test
```

## Verificação Postgres (SQL editor)

```sql
-- Tombstone recente
SELECT id, is_deleted, updated_at FROM lyrics WHERE is_deleted = true ORDER BY updated_at DESC LIMIT 5;

-- Stats após flush
SELECT lyric_id, play_count FROM lyric_play_stats ORDER BY play_count DESC LIMIT 10;
```

## Critério de smoke OK

Todos os cenários Gherkin em `requirements.md` §7 (Fases A, B, C + negativos) passam em staging antes de promover prod.

## Histórico

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-31 | Versão inicial | reversa |
