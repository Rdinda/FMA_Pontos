# Regression Watch: 001-novo-visual-streaming

> Feature: Modernização Visual — Identidade Streaming
> Gerado em: `2026-05-21`

## Watch items

| ID | Origem (arquivo, seção) | Regra esperada após mudança | Tipo de verificação | Sinal de violação |
|----|-------------------------|------------------------------|---------------------|-------------------|
| W001 | `legacy-impact.md` Modificadas — RBAC | Painel admin acessível **somente** via `AuthService.isAdmin` | presença | Não-admin abre AdminScreen |
| W002 | `legacy-impact.md` Modificadas — Sync | `SyncRepository.syncData()` continua no bootstrap e refresh | presença | Sync não dispara ou SQLite vazio após boot |
| W003 | `legacy-impact.md` Modificadas — Favoritos | `FavoritesService` persiste IDs localmente | presença | Favoritar/desfavoritar não persiste |
| W004 | `legacy-impact.md` Modificadas — Player | Mini-player visível com playlist ativa | presença | Player some ao navegar entre telas |
| W005 | `legacy-impact.md` Modificadas — Brand | Primary UI verde streaming, não `#6200EE` | redação | Roxo legado visível em telas principais |
| W006 | `legacy-impact.md` Modificadas — Badges | Admin badge verde; moderador roxo; user cinza | redação | Admin badge vermelho (esquema error) |
| W007 | `legacy-impact.md` Modificadas — Default tema | Novo install inicia dark; toggle claro funciona | presença | Tema claro ilegível ou default system |

## Histórico de re-extrações

### Re-extração 2026-05-31 (parcial visual)

| ID | Veredito | Observação |
|----|----------|------------|
| W001 | 🟢 verde | regra preservada em `_reversa_sdd/administracao/design.md`, `permissions.md` |
| W002 | 🟢 verde | sync bootstrap em `_reversa_sdd/code-analysis.md`, `sincronizacao-offline/` |
| W003 | 🟢 verde | `FavoritesService` em `_reversa_sdd/favoritos/`, `data-dictionary.md` |
| W004 | 🟢 verde | RF-16 player em `_reversa_sdd/reproducao-audio/requirements.md` |
| W005 | 🟢 verde | brand verde em `_reversa_sdd/design-system/*`; `#6200EE` removido |
| W006 | 🟢 verde | `RoleBadge` admin verde em `color-palette.md`, `administracao/design.md` |
| W007 | 🟢 verde | default `ThemeMode.dark` em `color-palette.md`, `tokens.md` |

| Data | Agente | Resultado |
|------|--------|-----------|
| 2026-05-31 | Reversa partial re-extraction | 7/7 verdes — ver `re-extraction-2026-05-31-visual.md` |

## Arquivadas

(nenhuma)

## Observações

(nenhuma — regras 🟡/🔴 do legado fora do escopo desta feature)
