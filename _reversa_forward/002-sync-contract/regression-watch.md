# Regression Watch: 002-sync-contract

> Feature: `002-sync-contract`
> Criado: `2026-05-31`

## Itens de vigilância

| ID | Origem (arquivo, seção) | Regra esperada após mudança | Tipo de verificação | Sinal de violação |
|----|-------------------------|----------------------------|---------------------|-------------------|
| W001 | `legacy-impact.md` — Pull incremental | PULL de sync usa `sync_categories`/`sync_lyrics` e processa `is_deleted=true` com `hardDelete*` local | `presença` | Código volta a `from('categories')`/`from('lyrics')` no fetch incremental |
| W002 | `legacy-impact.md` — Soft delete remoto | Upsert remoto inclui `is_deleted`; delete remoto marca `is_deleted=true` | `redação` | `toSupabaseMap` omite `is_deleted` ou prod rejeita UPDATE delete |
| W003 | `legacy-impact.md` — Estatísticas | Após deploy Fase A, incremento autenticado usa RPC; sem INSERT client em `lyric_play_stats` | `presença` | Policy INSERT/UPDATE client reativada ou fallback vira único caminho sem RPC |
| W004 | `domain.md` — Sincronização | Tombstones remotos removem linha local (não ressuscitam na UI) | `presença` | Letra/categoria deletada no servidor reaparece após sync |
| W005 | `domain.md` — Categorias visíveis | Listagens locais continuam `is_deleted = 0` | `presença` | Itens excluídos visíveis na home/listas |

## Histórico de re-extrações

_(vazio — preenchido em `/reversa` futuro)_

## Arquivadas

_(vazio)_

## Observações

_(regras 🟡/🔴 do domínio — sem peso de regressão neste watch)_
