# Re-extração Parcial (Visual) — 2026-05-31

> Disparada após conclusão do `/reversa-coding` da feature `001-novo-visual-streaming` (29/29 ações).
> Padrão: opção 6 / partial re-extraction (mesmo gatilho da re-extração 2026-05-21).

## Escopo analisado

| Área | Mudança no legado | Specs atualizadas |
|------|-------------------|-------------------|
| Tema / tokens | `lib/theme/app_colors.dart`, `lib/theme/app_theme.dart`; `main.dart` delega tema | `design-system/*`, `code-analysis.md`, `architecture.md`, `flowcharts/app-bootstrap.md` |
| Preferências | `ThemeProvider` default `ThemeMode.dark` | `design-system/color-palette.md`, `tokens.md` |
| Widgets streaming | `lib/widgets/streaming/*` | `design-system/design-system.md` |
| Telas (apresentação) | 11 `lib/screens/*.dart`, player, snackbar | `ui/inventory.md`, `ui/screens/*.md` |
| Android splash | `launch_background` escuro `#131313` | `design-system/design-system.md` (assets) |
| Admin badges | `RoleBadge` verde admin | `administracao/design.md`, `color-palette.md` |
| Forward | `legacy-impact.md`, `regression-watch.md` | histórico W001–W007 |

## Delta confirmado no código (🟢)

1. **Brand** — Roxo `#6200EE` removido; verde streaming `#1DB954` / `#53E076` em `AppColors` e `ColorScheme`.
2. **Tipografia** — `GoogleFonts.plusJakartaSansTextTheme()` único em `AppTheme`; Outfit/Montserrat/Open Sans removidos do shell.
3. **AppBar** — Transparente, `titleTextStyle` 20px bold `onSurface` (não barra primária sólida).
4. **Default tema** — `ThemeProvider` inicia `ThemeMode.dark`; prefs `theme_mode` preservam escolha do usuário.
5. **Snackbar sucesso** — `primaryContainer` / `onPrimaryContainer` (`snackbar_utils.dart`).
6. **Role badges** — admin verde, moderador roxo `#BB86FC`, user cinza (`RoleBadge` + `AppColors.roleColor`).
7. **Regras de negócio** — Sync, RBAC, favoritos, player **inalterados** (apenas apresentação).

## Verificação regression-watch (001-novo-visual-streaming)

| ID | Veredito | Observação |
|----|----------|------------|
| W001 | 🟢 verde | `administracao/design.md`, `permissions.md` — gate `AuthService.isAdmin` |
| W002 | 🟢 verde | `code-analysis.md`, `sincronizacao-offline/*` — `SyncRepository.syncData` preservado |
| W003 | 🟢 verde | `favoritos/*`, `data-dictionary.md` — `FavoritesService` local |
| W004 | 🟢 verde | `reproducao-audio/requirements.md` RF-16 — `CategoryPlayerWidget` |
| W005 | 🟢 verde | `design-system/*` — brand verde documentado; `#6200EE` removido das specs |
| W006 | 🟢 verde | `color-palette.md`, `administracao/design.md` — admin badge verde |
| W007 | 🟢 verde | `color-palette.md`, `tokens.md` — default dark + toggle claro |

**Resumo:** 7 verificados · 7 verdes · 0 amarelos · 0 vermelhos.

## Lacunas remanescentes

- 🟡 Screenshots do Visor (2026-05-21) ainda mostram UI roxa — `ui/inventory.md` atualizado por código, não por novo screenshot.
- 🟡 Onboarding, Favoritos, Top, Admin — telas não re-capturadas pelo Visor (lacuna herdada da extração original).
- 🟡 `google_fonts` — dependência de rede/cache no primeiro boot (documentado em `typography.md`).
- 🔴 Nenhuma regressão semântica detectada nos watch items W001–W007.

## Agentes re-executados (parcial)

| Agente | Módulos / artefatos | Ação |
|--------|---------------------|------|
| Design System | `design-system/*` | Re-sincronizar tokens, paleta, tipografia, componentes streaming |
| Archaeologist (delta) | `app-bootstrap` | `code-analysis.md`, `flowcharts/app-bootstrap.md` |
| Architect (delta) | bootstrap | `architecture.md` componente Bootstrap |
| Visor (delta) | `ui/*` | Padrões transversais e telas documentadas |
| Reversa (orquestração) | `regression-watch.md`, `state.json` | Checkpoint + histórico re-extração |

## Confiança pós re-extração

Estimativa: **93%** (+1 pp) nas units de apresentação e bootstrap; baseline global ~90% (2026-05-20) mantida nas demais units.

## Smoke test recomendado

Sim — executar checklist em `_reversa_forward/001-novo-visual-streaming/onboarding.md` (fundação visual, RF-02–RF-09) após `flutter analyze lib` limpo.
