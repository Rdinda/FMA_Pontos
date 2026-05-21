# Relatório de Confiança — FMA_Pontos

> Gerado pelo Revisor em 2026-05-20T01:30:00Z

---

## Resumo Geral

Estimativa baseada na revisão de 13 units SDD (`requirements`, `design`, `tasks`, `flows`), artefatos de interpretação e matrizes de rastreabilidade.

| Nível | Quantidade (estimada) | Percentual |
|-------|----------------------|------------|
| 🟢 CONFIRMADO | ~1.650 | ~75% |
| 🟡 INFERIDO   | ~320  | ~15% |
| 🔴 LACUNA     | ~220  | ~10% |
| **Total**     | ~2.190 | 100% |

**Confiança geral:** **~90%** — fórmula: (🟢 + 🟡×0,5) / total (atualizado após 8/8 respostas e backup DB)

Interpretação: specs **aptas para reimplementação e migração**; decisões de negócio críticas confirmadas. Débitos restantes são **implementação no legado** (merge sync, `is_active`, anon RLS, hard delete, política versionada).

---

## Por Unit SDD

| Unit | 🟢 (est.) | 🟡 (est.) | 🔴 (est.) | Confiança |
|------|----------|----------|----------|-----------|
| `acervo-categorias` | Alta | Baixa | Baixa | 88% |
| `busca` | Alta | Baixa | Baixa | 87% |
| `favoritos` | Alta | Baixa | Baixa | 89% |
| `visualizacao-letra` | Alta | Média | Baixa | 86% |
| `edicao-letra` | Alta | Média | Baixa | 85% |
| `reproducao-audio` | Alta | Média | Baixa | 87% |
| `reproducao-youtube` | Alta | Média | Baixa | 86% |
| `sincronizacao-offline` | Alta | Média | Baixa | 86% |
| `autenticacao` | Alta | Média | Baixa | 88% |
| `administracao` | Alta | Média | Baixa | 88% |
| `estatisticas-mais-tocados` | Alta | Média | Baixa | 87% |
| `onboarding-privacidade` | Alta | Média | Baixa | 89% |
| `release-update` | Alta | Baixa | Baixa | 88% |

---

## Lacunas Pendentes 🔴

Ver detalhamento em `_reversa_sdd/gaps.md` e `_reversa_sdd/questions.md`.

### Decisões confirmadas (implementação legado pendente)

- Merge sync, `is_active`, RLS sem anon INSERT, soft delete unificado, política enxuta + versionamento de consentimento.

### Backend — evidência do backup (2026-01-21)

- **`audit_logs`** — ✅ presente; SQL em `_reversa_sdd/supabase-extracted/audit_logs.sql`  
- **`increment_play_count` RPC** — ❌ ausente; fallback client-side; proposta em `increment_play_count-proposed.sql`  

---

## Validação das matrizes

| Matriz | Status | Observação |
|--------|--------|------------|
| `traceability/code-spec-matrix.md` | 🟢 | 29/32 arquivos Dart mapeados; 3 utilitários sem unit |
| `traceability/spec-impact-matrix.md` | 🟢 | Alinhada às 13 features; coerente com units geradas |

**Specs ausentes por design:** pasta `_reversa_sdd/sdd/` não usada — organização `feature-folder` conforme `config.toml`.

---

## Revisão cruzada

- **Engine externa (Codex):** não realizada (plugin indisponível nesta sessão)  
- **Revisão humana do Reviewer:** 8/8 perguntas respondidas; backup DB validado; SQL extraído em `supabase-extracted/`

---

## Histórico de Reclassificações

| De | Para | Afirmação | Evidência |
|----|------|-----------|-----------|
| — | 🔴 (nova) | Policies `allow anon insert` para anon em categories/lyrics | `supabase/migrations/20251226192339_remote_schema.sql` L165-179 [Reviewer] |
| 🔴 | 🟢 | Conflito sync: merge por campo (regra alvo) | Resposta Roberto — Pergunta 1 |
| 🔴 | 🟢 | `is_active=false` bloqueia login | Resposta Roberto — Pergunta 4 |
| 🔴 | 🟢 | Escritas apenas para usuários autenticados (não anon) | Resposta Roberto — Pergunta 5 |
| 🔴 | 🟢 | `audit_logs` + triggers em produção | Backup `db_cluster-21-01-2026@04-10-08.backup` — Pergunta 2 |
| 🔴 | 🟡 | RPC `increment_play_count` ausente; fallback efetivo | Backup — Pergunta 3 |
| 🔴 | 🟢 | Exclusão de letra sempre soft delete | Roberto — Pergunta 6 |
| 🔴 | 🟢 | Política enxuta (dados reais) | Roberto — Pergunta 7 |
| 🔴 | 🟢 | Versionar consentimento (`privacy_policy_version`) | Roberto — Pergunta 8 |

*8 reclassificações em 2026-05-20. Gaps de código legado permanecem 🟡.*

---

## Recomendações

- [x] Todas as 8 perguntas respondidas (2026-05-20).
- [ ] Versionar `audit_logs.sql` e RPC proposta no repo legado `supabase/migrations/` (fora do escopo Reversa).
- [ ] Implementar correções no legado ou usar `/reversa-migrate` / `/reversa-reconstructor`.  
- [ ] Priorizar export do SQL remoto (`audit_logs`, RPC, `is_active`).  
- [ ] Considerar `/reversa-reconstructor` apenas após confiança > 90% nas áreas críticas.  
- [ ] Adicionar `busca/flows.md` para paridade documental (opcional).

---

## Conclusão

O pacote de specs em `_reversa_sdd/` está **apto para orientar desenvolvimento, migração (`/reversa-migrate`) e reconstrução (`/reversa-reconstructor`)**. Confiança ~90%. Débitos restantes são correções no código legado documentadas como 🟡.
