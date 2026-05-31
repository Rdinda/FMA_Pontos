# Actions: Modernização Visual — Identidade Streaming

> Identificador: `001-novo-visual-streaming`
> Data: `2026-05-21`
> Roadmap: `_reversa_forward/001-novo-visual-streaming/roadmap.md`

## Resumo

| Métrica | Valor |
|---------|-------|
| Total de ações | 29 |
| Paralelizáveis (`[//]`) | 14 |
| Maior cadeia de dependência | 6 (T001 → T002 → T004 → T009 → T013 → T026) |

## Fase 1, Preparação

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T001 | Criar `AppColors` com paleta Stitch dark/light (hex de `Home_Acervo.html` + D-10) | - | `[//]` | `lib/theme/app_colors.dart` | 🟢 | `[X]` |
| T002 | Implementar `AppTheme.buildDarkTheme()` com `ColorScheme` explícito, Plus Jakarta Sans, AppBar surface/transparente, `InputDecorationTheme` radius 12 | T001 | - | `lib/theme/app_theme.dart` | 🟢 | `[X]` |
| T003 | Implementar `AppTheme.buildLightTheme()` espelhando dark (surfaces claras, primary `#1DB954`) | T001, T002 | - | `lib/theme/app_theme.dart` | 🟡 | `[X]` |
| T004 | Refatorar `MyApp`: remover `primaryColor` roxo e delegar `theme`/`darkTheme` a `AppTheme` | T003 | - | `lib/main.dart` | 🟢 | `[X]` |
| T005 | Alterar default de `_themeMode` para `ThemeMode.dark` quando prefs ausente | - | `[//]` | `lib/providers/theme_provider.dart` | 🟡 | `[X]` |

## Fase 2, Testes

> Fase omitida — equipe valida visualmente via `onboarding.md` (smoke manual). Escopo não altera lógica testável existente.

## Fase 3, Núcleo

### 3a — Widgets compartilhados streaming

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T006 | Criar `StreamingCard` (surface-container, radius 12–16, padding padrão) | T004 | `[//]` | `lib/widgets/streaming/streaming_card.dart` | 🟢 | `[X]` |
| T007 | Criar `StreamingSearchField` (pill full-width, ícone lupa, fill `surface-container-highest`) | T004 | `[//]` | `lib/widgets/streaming/streaming_search_field.dart` | 🟢 | `[X]` |
| T008 | Criar `RoleBadge` (admin verde, moderador roxo, user cinza, inativo desaturado — RN-04) | T004 | `[//]` | `lib/widgets/streaming/role_badge.dart` | 🟢 | `[X]` |
| T009 | Criar `StreamingBottomNav` (ícone ativo verde, labels, safe area) | T004 | - | `lib/widgets/streaming/streaming_bottom_nav.dart` | 🟢 | `[X]` |
| T010 | Reestilizar mini-player (surface escura, accent verde, sombra suave) | T004 | `[//]` | `lib/widgets/category_player_widget.dart` | 🟢 | `[X]` |
| T011 | Ajustar `SnackbarUtils` para success com `primaryContainer`/`onPrimaryContainer` | T004 | `[//]` | `lib/utils/snackbar_utils.dart` | 🟢 | `[X]` |
| T012 | Reestilizar `AppInfoBottomSheet` (surface, tipografia, toggle tema) | T004 | `[//]` | `lib/widgets/app_info_bottom_sheet.dart` | 🟢 | `[X]` |

### 3b — Telas (layout streaming)

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T013 | Modernizar Home: grid/list categorias com `StreamingCard`, header on-surface, integrar `StreamingBottomNav` | T006, T009 | - | `lib/screens/home_screen.dart` | 🟢 | `[X]` |
| T014 | Modernizar CategoryScreen: lista numerada, chips/códigos, play inline, app bar transparente | T006, T010 | `[//]` | `lib/screens/category_screen.dart` | 🟢 | `[X]` |
| T015 | Modernizar SearchScreen: `StreamingSearchField`, resultados em cards/tiles | T007 | `[//]` | `lib/screens/search_screen.dart` | 🟢 | `[X]` |
| T016 | Modernizar LyricViewScreen: banner placeholder, letra Plus Jakarta Sans (remover Montserrat/Open Sans), player bar | T004 | `[//]` | `lib/screens/lyric_view_screen.dart` | 🟢 | `[X]` |
| T017 | Modernizar AdminScreen: tabs pill, search, cards usuário, `RoleBadge`, bottom nav admin | T008, T009 | - | `lib/screens/admin_screen.dart` | 🟢 | `[X]` |
| T018 | Modernizar LyricFormScreen: inputs filled, botão salvar verde, app bar transparente | T007 | `[//]` | `lib/screens/lyric_form_screen.dart` | 🟢 | `[X]` |
| T019 | Modernizar FavoritesScreen: lista/empty state dark, app bar transparente | T006 | `[//]` | `lib/screens/favorites_screen.dart` | 🟢 | `[X]` |
| T020 | Modernizar TopPlayedScreen: ranks ouro/prata/bronze sobre surfaces escuras | T006 | `[//]` | `lib/screens/top_played_screen.dart` | 🟢 | `[X]` |
| T021 | Modernizar `onboarding_widgets.dart`: CTA verde `#1DB954`, animações preservadas | T004 | `[//]` | `lib/screens/onboarding_widgets.dart` | 🟢 | `[X]` |
| T022 | Modernizar OnboardingScreen: layout conforme mock `Onboarding.png` | T021 | - | `lib/screens/onboarding_screen.dart` | 🟢 | `[X]` |
| T023 | Modernizar PrivacyPolicyScreen: tipografia e surfaces legíveis dark/light | T004 | `[//]` | `lib/screens/privacy_policy_screen.dart` | 🟢 | `[X]` |
| T024 | Modernizar SplashScreen: fundo `#131313`, logo asset, loader verde (RF-10) | T004 | `[//]` | `lib/screens/splash_screen.dart` | 🟡 | `[X]` |

## Fase 4, Integração

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T025 | Ajustar splash nativa Android (windowBackground escuro) se flash branco persistir | T024 | - | `android/app/src/main/res/values/styles.xml` | 🟡 | `[X]` |
| T026 | Varredura e remoção de hex legado (`0xFF6200EE`, `Outfit` residual) em `lib/` | T013, T014, T015, T016, T017, T018, T019, T020, T022, T023, T024 | - | `lib/` (multi) | 🟢 | `[X]` |

## Fase 5, Polimento

| ID | Descrição | Dependências | Paralelismo | Arquivo alvo | Confidência | Status |
|----|-----------|--------------|-------------|--------------|-------------|--------|
| T027 | Atualizar tokens (cores, radius, fonte Plus Jakarta Sans) | T026 | `[//]` | `_reversa_sdd/design-system/tokens.md` | 🟡 | `[X]` |
| T028 | Atualizar paleta brand `#6200EE` → streaming green | T026 | `[//]` | `_reversa_sdd/design-system/color-palette.md` | 🟡 | `[X]` |
| T029 | Atualizar hierarquia tipográfica (Outfit → Plus Jakarta Sans) | T026 | `[//]` | `_reversa_sdd/design-system/typography.md` | 🟡 | `[X]` |

## Notas de execução

<!--
Reservado para /reversa-coding.
-->

### Ordem sugerida para agente único

1. T001 → T002 → T003 → T004 (fundação)
2. T005 em paralelo ou logo após T004
3. T006–T012 (widgets compartilhados; T009 antes de T013/T017)
4. T013 → T017 (core journey); T014–T016, T018–T024 conforme `[//]`
5. T025 → T026 → T027–T029

### Golden files por tarefa

| Tarefa | Referência visual |
|--------|-------------------|
| T013 | `_reversa_sdd/stitch_screens/Home_Acervo.png` |
| T014 | `_reversa_sdd/stitch_screens/Categoria_Ogum_1.png` |
| T015 | `_reversa_sdd/stitch_screens/Busca.png` |
| T016 | `_reversa_sdd/stitch_screens/Tocando_Agora_Ogum.png` |
| T017 | `_reversa_sdd/administracao/screenshots/Painel_Administrativo_Modernizado.png` |
| T018 | `_reversa_sdd/stitch_screens/Novo_Ponto.png` |
| T019 | `_reversa_sdd/stitch_screens/Favoritos.png` |
| T020 | `_reversa_sdd/stitch_screens/Mais_Tocados.png` |
| T022–T023 | `_reversa_sdd/stitch_screens/Onboarding*.png` |
| T024 | `_reversa_sdd/stitch_screens/Logo_Splash.png` |

## Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-21 | Versão inicial gerada por `/reversa-to-do` | reversa |
