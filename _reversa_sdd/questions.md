# Perguntas para Validação — FMA_Pontos

> Gerado pelo Revisor em 2026-05-20  
> Responda no chat ou preencha o campo **Resposta** abaixo e digite `reversa` quando terminar.  
> **Progresso:** 8/8 respondidas (Roberto, 2026-05-20).

---

## Pergunta 1 — Política de conflito no sync

**Contexto:** `SyncRepository.syncData` — PUSH/PULL sem campo de versão nem merge explícito  
**Spec afetada:** `_reversa_sdd/sincronizacao-offline/requirements.md`  
**Pergunta:** Quando a mesma letra é editada offline (não sincronizada) e também alterada no Supabase por outro usuário, qual regra deve valer: último push ganha, último pull ganha, bloqueio, ou merge por campo?  
**Impacto:** Define se a spec permanece 🔴 ou vira 🟢 com regra explícita de resolução.

**Resposta:** ✅ **Merge por campo** — quando há conflito entre edição local não sincronizada e alteração remota, o sistema deve fazer merge (não last-write-wins). Confirmado por Roberto em 2026-05-20.

---

## Pergunta 2 — Tabela e triggers de `audit_logs`

**Contexto:** `AdminService.fetchAuditLogs` lê `audit_logs`, mas DDL/triggers não estão em `supabase_schema.sql`  
**Spec afetada:** `_reversa_sdd/administracao/requirements.md`  
**Pergunta:** A tabela `audit_logs` e seus triggers existem apenas no projeto Supabase remoto? Pode exportar o SQL ou confirmar que logs são gerados hoje em produção?  
**Impacto:** Sem confirmação, a aba Logs da administração permanece parcialmente 🔴.

**Evidência no repo:** migration `20251226192339` revoga permissões em `audit_logs`, mas não há `CREATE TABLE` nem triggers em `supabase_schema.sql`.

**Resposta:** ✅ **Confirmado via backup** `db_cluster-21-01-2026@04-10-08.backup` — tabela `audit_logs`, função `audit_trigger_func()` e triggers em `categories`/`lyrics` existem em produção. SQL extraído em `_reversa_sdd/supabase-extracted/audit_logs.sql`.

---

## Pergunta 3 — RPC `increment_play_count`

**Contexto:** `PlayStatsService` chama RPC; função não está versionada no repositório  
**Spec afetada:** `_reversa_sdd/estatisticas-mais-tocados/requirements.md`  
**Pergunta:** A função `increment_play_count(p_lyric_id)` já existe no Supabase de produção? Se sim, pode adicionar a migration ao repo?  
**Impacto:** Confirma se o caminho feliz é RPC 🟢 ou apenas fallback client-side 🟡.

**Evidência no repo:** `PlayStatsService` chama RPC e, em falha, usa `_incrementPlayCountFallback` (upsert manual em `lyric_play_stats`).

**Resposta:** ✅ **RPC ausente no backup de produção** (2026-01-21). Caminho efetivo hoje é o **fallback client-side**. Proposta de migration em `_reversa_sdd/supabase-extracted/increment_play_count-proposed.sql` para alinhar servidor ao app.

---

## Pergunta 4 — Campo `is_active` em usuários

**Contexto:** `AdminService.setUserActive` atualiza `is_active`; coluna ausente no schema base versionado; `AuthService` não verifica  
**Spec afetada:** `_reversa_sdd/autenticacao/requirements.md`, `_reversa_sdd/administracao/requirements.md`  
**Pergunta:** Desativar um usuário deve impedir login, bloquear mutações no Supabase (RLS), ou apenas ser flag visual para admins?  
**Impacto:** Define enforcement em Auth, RLS e specs de administração.

**Resposta:** ✅ **Deve bloquear login** — usuário com `is_active = false` não pode autenticar/usar o app. Confirmado por Roberto em 2026-05-20.

---

## Pergunta 5 — INSERT anônimo no Supabase

**Contexto:** Migration `20251226192339_remote_schema.sql` — policies `allow anon insert` em `categories` e `lyrics`  
**Spec afetada:** `_reversa_sdd/permissions.md`  
**Pergunta:** Essas policies de INSERT para role `anon` são intencionais? O app bloqueia escrita na UI, mas o banco aceitaria inserts de sessões anônimas.  
**Impacto:** Segurança crítica — se não for intencional, spec deve documentar remoção das policies.

**Resposta:** ✅ **Somente usuários logados** (não anônimos) podem realizar escritas. Policies `allow anon insert` **não são intencionais** e devem ser removidas no Supabase. Confirmado por Roberto em 2026-05-20.

---

## Pergunta 6 — Exclusão de letra online (hard vs soft delete)

**Contexto:** `SyncRepository.deleteLyric` online faz hard delete; PUSH incremental usa soft delete  
**Spec afetada:** `_reversa_sdd/sincronizacao-offline/requirements.md`  
**Pergunta:** A exclusão imediata online (hard delete + Storage) é o comportamento desejado, ou deveria seguir soft delete como o restante do ciclo?  
**Impacto:** Alinha ADR 001 e evita divergência entre dispositivos.

**Evidência no repo (inconsistência):**
- `SyncRepository.deleteLyric` online: **hard delete** (`client.from('lyrics').delete()`).
- `SupabaseService.deleteLyric` (usado no PUSH): **soft delete** (`is_deleted: true`).
- Local sempre começa com `softDeleteLyric`.

**Resposta:** ✅ **A) Sempre soft delete** — exclusão online deve seguir `is_deleted` (alinhado ao ADR 001 e PUSH), sem hard delete na tabela remota. Remoção de áudio no Storage pode ocorrer em job/sync posterior. Roberto, 2026-05-20.

---

## Pergunta 7 — Dados mencionados na política de privacidade

**Contexto:** `PrivacyPolicyScreen._policyText` menciona CPF, telefone, localização; app coleta principalmente email/Google e uso local  
**Spec afetada:** `_reversa_sdd/onboarding-privacidade/requirements.md`  
**Pergunta:** A política embutida reflete exatamente o que o app coleta hoje, ou é texto genérico a ser enxugado?  
**Impacto:** Conformidade LGPD e texto do onboarding.

**Evidência no repo:** `PrivacyPolicyScreen` menciona CPF, telefone, localização, marketing; o app coleta principalmente login Google (nome, email, avatar) + dados locais de uso do acervo.

**Resposta:** ✅ **B) Enxugar agora** — política deve refletir apenas dados realmente coletados (Google OAuth, uso do acervo, SQLite local, Supabase). Roberto, 2026-05-20.

---

## Pergunta 8 — Re-onboarding após nova versão da política

**Contexto:** Apenas `onboarding_completed` booleano em SharedPreferences  
**Spec afetada:** `_reversa_sdd/onboarding-privacidade/requirements.md`  
**Pergunta:** Ao publicar nova política de privacidade, o app deve forçar novo aceite (ex.: versão `2025-12` vs `2026-06`)?  
**Impacto:** Define se feature de versionamento de consentimento entra no backlog.

**Evidência no repo:** apenas `onboarding_completed` (boolean) em SharedPreferences; política datada `26/12/2025` sem campo de versão aceita.

**Resposta:** ✅ **A) Sim** — versionar consentimento (ex.: `privacy_policy_version`); nova versão da política força novo aceite no onboarding. Roberto, 2026-05-20.
