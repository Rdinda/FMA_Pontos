# Re-extração Parcial — 2026-05-31 (rodada 2)

> Disparada pelo usuário (`re-extração`) após commits pós `001-novo-visual-streaming` e re-extração visual do mesmo dia.

## Escopo analisado

| Área | Mudança no legado | Specs atualizadas |
|------|-------------------|-------------------|
| Dependências | `toastification` ^3.2.0; versão app `1.0.20` | `dependencies.md` |
| Bootstrap | `ToastificationWrapper` em `main.dart`; margem inferior 110dp | `flowcharts/app-bootstrap.md`, `code-analysis.md` |
| Feedback UI | `SnackbarUtils` → toasts `toastification` (não `ScaffoldMessenger`) | `flowcharts/utils.md`, `design-system/*`, `edicao-letra/design.md` |
| Tokens layout | `lib/theme/streaming_tokens.dart` | `design-system/tokens.md`, `design-system/design-system.md` |
| Home / categorias | Grid `CategoryCard`, destaques por plays, `AllCategoriesScreen` | `acervo-categorias/*`, `ui/inventory.md` |
| Artes de categoria | `category_artwork.dart` + `assets/images/categories/*.webp` | `design-system/design-system.md`, `acervo-categorias/design.md` |
| Widgets streaming | `streaming_scaffold`, `streaming_navigation`, `track_list_tile`, `category_card`, `streaming_mini_player` | `design-system/design-system.md`, `code-analysis.md` |
| Dev / auth | `GOOGLE_SERVER_CLIENT_ID` em `.env` / `run-dev.ps1` | `flowcharts/app-bootstrap.md`, `autenticacao/design.md` |
| Estatísticas na Home | `PlayStatsService.rankCategoriesByAccess` + preview top 8 | `estatisticas-mais-tocados/design.md`, `acervo-categorias/requirements.md` |
| Release | `pubspec.yaml` `1.0.20` | `release-update/design.md`, `release-update/requirements.md` |

## Delta confirmado no código (🟢)

1. **`toastification`** — `MyApp` envolve `MaterialApp` com `ToastificationWrapper` (`alignment: bottomCenter`, `marginBuilder` LTRB 16,0,16,110). `SnackbarUtils` usa `toastification.show` com fundo sucesso `AppColors.primaryContainer` e erro `#E07A6B`.
2. **`StreamingTokens`** — Raios 8/12/16/24 e espaçamentos 4–32; alturas `miniPlayerHeight` 56, `bottomNavHeight` 72, `categoryCardHeight` 96.
3. **`CategoryCard` / `BentoCategoryCard`** — Cards com arte WebP (`categoryArtworkPath`), gradiente fallback, faixa inferior com nome; grid 2 colunas na Home e em `AllCategoriesScreen`.
4. **Home redesenhada** — Saudação por horário + nome Google; seção “Categorias” (até 4 destaques via `rankCategoriesByAccess`); seção “Mais Tocados” (preview 8); `StreamingScaffold` + bottom nav unificada.
5. **`AllCategoriesScreen`** — Lista completa em grid; app bar `StreamingAppBar`; refresh via `syncData()`.
6. **`category_artwork.dart`** — Mapa nome/código → `assets/images/categories/*.webp`; diretório `app_imgs/` removido do repo.
7. **`GOOGLE_SERVER_CLIENT_ID`** — Opcional no `.env`; propagado por `run-dev.ps1` → `dart_defines.json`; fallback em `AuthService._init` via `String.fromEnvironment`.
8. **Versão** — `pubspec.yaml` `1.0.20` (tag/release alvo `v1.0.20`).

## Lacunas remanescentes

- 🟡 Screenshots do Visor (2026-05-21) não refletem Home em grid nem toasts — specs atualizadas por código.
- 🟡 `AllCategoriesScreen` e `BentoCategoryCard` (busca) sem página dedicada no Visor.
- 🟡 **Data Master** no `plan.md` continua pendente — backup `db_cluster-21-01-2026@04-10-08.backup` disponível.
- 🔴 Nenhuma regressão de regra de negócio detectada (sync, RBAC, favoritos, player).

## Agentes re-executados (parcial)

| Agente | Módulos / artefatos | Ação |
|--------|---------------------|------|
| Scout (delta) | dependências | Versão + `toastification` |
| Design System | tokens, paleta, design-system | `StreamingTokens`, toasts, assets categorias |
| Archaeologist (delta) | app-bootstrap, utils, screens, widgets | `code-analysis.md`, flowcharts |
| Writer (delta) | acervo-categorias, estatisticas, release, autenticacao | Requirements/design pontuais |
| Reversa (orquestração) | `state.json` | Checkpoint `re_extraction_2026_05_31_round2` |

## Confiança pós re-extração

Estimativa: **94%** (+1 pp) em apresentação, acervo e bootstrap; baseline global ~90% nas demais units.

## Smoke test recomendado

1. `flutter analyze lib`
2. `.\run-dev.ps1` — validar toasts (erro/sucesso) acima do mini-player
3. Home — grid categorias com imagens; seta “Categorias” → lista completa; preview “Mais Tocados”
