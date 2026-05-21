# Lacunas — FMA_Pontos

> Gerado pelo Revisor em 2026-05-20  
> Atualizado após 8/8 respostas e validação do backup `db_cluster-21-01-2026@04-10-08.backup`.  
> **Contrato arquitetural (regras pós-correção legado):** [`architecture-contract.md`](architecture-contract.md)

## Críticas — todas resolvidas (decisão ou evidência)

Nenhuma lacuna 🔴 crítica pendente de validação humana.

| ID | Lacuna | Specs afetadas | Pergunta |
|----|--------|----------------|----------|
| ~~G-01~~ | ~~Política de conflito sync ausente~~ → **Resolvida:** merge por campo (`SyncMerge`) | `sincronizacao-offline` | ✅ Roberto 2026-05-20 · legado 2026-05-19 |
| ~~G-02~~ | ~~Schema/triggers `audit_logs` não versionados~~ | `administracao` | ✅ Confirmado no backup; SQL em `supabase-extracted/audit_logs.sql` |
| ~~G-03~~ | ~~RPC `increment_play_count` não no repo~~ | `estatisticas-mais-tocados` | ✅ Ausente em produção; fallback é caminho real; proposta em `increment_play_count-proposed.sql` |
| ~~G-04~~ | ~~`is_active` sem enforcement~~ → **Resolvida:** bloquear login (`AuthService`) | `autenticacao`, `administracao` | ✅ Roberto 2026-05-20 · legado 2026-05-19 |
| ~~G-05~~ | ~~Policies `allow anon insert`~~ → **Resolvida:** migration `20260519000000_fix_reversa_gaps.sql` | `permissions.md` | ✅ Roberto 2026-05-20 · aplicar no Supabase remoto |

## Moderadas (comportamento ambíguo ou débito)

| ID | Lacuna | Specs afetadas | Pergunta |
|----|--------|----------------|----------|
| ~~G-06~~ | ~~`deleteLyric` hard vs soft~~ | `sincronizacao-offline` | ✅ Sempre soft delete · legado 2026-05-19 |
| ~~G-07~~ | ~~Política vs dados reais~~ | `onboarding-privacidade` | ✅ Decisão: enxugar texto (RF-10) |
| ~~G-08~~ | ~~Sem re-consent~~ | `onboarding-privacidade` | ✅ Decisão: `privacy_policy_version` (RF-11); 🟡 legado pendente |
| G-09 | `AdminScreen` sem route guard de role admin | `administracao` | — |
| ~~G-10~~ | ~~`busca/` sem `flows.md`~~ | `busca` | ✅ Resolvido 2026-05-20 |

## Cosméticas / backlog

| ID | Observação |
|----|------------|
| G-11 | Testes automatizados ausentes no repositório |
| G-12 | `skeleton_widget.dart` sem unit SDD |
| G-13 | `getPlayCount` / `getAuditStats` APIs sem UI |
| G-14 | Verificação SHA256 do APK no update |

## Inconsistências cruzadas encontradas

1. **UI bloqueia anônimo, RLS pode permitir INSERT** — decisão: remover policies anon; corrigir no deploy.  
2. **Admin desativa usuário, Auth ignora `is_active`** — decisão: bloquear login; implementar em `AuthService`/RLS.  
3. **Permissões pedidas na splash antes do aceite LGPD** — ordem documentada em `onboarding-privacidade`; validar com jurídico se aceitável.

## Recomendações prioritárias

1. Versionar `supabase-extracted/audit_logs.sql` em `supabase/migrations/` do legado.
2. Aplicar `increment_play_count-proposed.sql` ou manter fallback documentado.
3. Corrigir legado: merge sync, `is_active` no Auth, remover anon INSERT, unificar soft delete em `deleteLyric`, política enxuta + `privacy_policy_version`.
4. Adicionar testes de integração mínimos para sync e RBAC.
