# Tokens — FMA_Pontos

> Tabela consolidada. Re-extração visual 2026-05-31; layout/toasts 2026-05-31 (rodada 2). Cores M3 explícitas em `app_theme.dart` (não `fromSeed`). Espaçamentos de tela também em `lib/theme/streaming_tokens.dart`.

## Cores

| Token | Valor | Categoria | Confiança |
|-------|-------|-----------|-----------|
| `color.primary` | `#1DB954` (CTA) / `#53E076` (highlight) | Brand | 🟢 |
| `color.on-primary` | `#003914` (dark) / `#FFFFFF` (light CTA) | Brand | 🟢 |
| `color.scaffold.light` | `#F5F5F5` | Surface | 🟢 |
| `color.scaffold.dark` | `#131313` | Surface | 🟢 |
| `color.error` | `colorScheme.error` | Feedback | 🟡 |
| `color.success-snackbar` | `AppColors.primaryContainer` | Feedback | 🟢 |
| `color.error-toast` | `#E07A6B` | Feedback | 🟢 |
| `toast.margin.bottom` | 110dp (acima mini-player) | Layout | 🟢 |
| `color.destructive-text` | `#F44336` (`Colors.red`) | Feedback | 🟢 |
| `color.rank.gold` | `Colors.amber` | Decorative | 🟢 |
| `color.rank.silver` | `grey.shade400` | Decorative | 🟢 |
| `color.rank.bronze` | `brown.shade300` | Decorative | 🟢 |
| `color.input.border.light` | `grey.shade200` | Border | 🟢 |
| `color.input.border.dark` | `colorScheme.outline` | Border | 🟢 |

## Tipografia

| Token | Valor | Confiança |
|-------|-------|-----------|
| `font.family.primary` | Plus Jakarta Sans | 🟢 |
| `font.family.lyric-title` | Plus Jakarta Sans (unificado) | 🟢 |
| `font.family.lyric-body` | Plus Jakarta Sans (unificado) | 🟢 |
| `font.size.appbar` | 20px | 🟢 |
| `font.size.lyric-body` | 18px | 🟢 |
| `font.size.list-title` | 16px | 🟢 |
| `font.size.caption` | 11–13px | 🟢 |
| `font.weight.appbar` | bold (700) | 🟢 |
| `font.weight.list-title` | w600 | 🟢 |
| `font.lineHeight.lyric` | 1.75 | 🟢 |
| `font.lineHeight.onboarding` | 1.35 | 🟢 |

## Espaçamento

| Token | Valor (dp) | Confiança |
|-------|------------|-----------|
| `space.4` | 4 | 🟢 |
| `space.8` | 8 | 🟢 |
| `space.12` | 12 | 🟢 |
| `space.16` | 16 | 🟢 |
| `space.24` | 24 | 🟢 |
| `space.32` | 32 | 🟢 |
| `space.48` | 48 | 🟢 |
| `input.padding` | 16×16 | 🟢 |
| `screen.padding.default` | 24 | 🟢 |
| `list.margin.horizontal` | 16 | 🟢 |
| `list.margin.vertical` | 4–8 | 🟢 |

## Radius

| Token | Valor (dp) | Confiança |
|-------|------------|-----------|
| `radius.sm` | 8 | 🟢 |
| `radius.md` | 12 | 🟢 |
| `radius.lg` | 16 | 🟢 |
| `radius.sheet` | 24 | 🟢 |
| `radius.logo` | 26 | 🟢 |

## Elevação

| Token | Valor | Confiança |
|-------|-------|-----------|
| `elevation.appbar.light` | 0 (transparente) | 🟢 |
| `elevation.appbar.dark` | 0 (transparente) | 🟢 |
| `color.role.admin` | `#1DB954` | 🟢 |
| `color.role.moderator` | `#BB86FC` | 🟢 |
| `color.role.user` | `#9E9E9E` | 🟢 |
| `theme.default.mode` | `dark` (sem prefs) | 🟢 |
| `elevation.card` | 2 | 🟢 |
| `elevation.snackbar` | N/A (overlay toastification) | 🟢 |
| `layout.mini-player-height` | 56 (`StreamingTokens`) | 🟢 |
| `layout.bottom-nav-height` | 72 | 🟢 |
| `layout.category-card-height` | 96 | 🟢 |
| `layout.track-art-size` | 56 | 🟢 |

## Motion

| Token | Valor | Confiança |
|-------|-------|-----------|
| `motion.onboarding.curve` | `Curves.easeOutCubic` | 🟢 |
| `motion.onboarding.translateY` | 36 | 🟢 |
| `motion.onboarding.scale` | 0.96 → 1.0 | 🟢 |
| `motion.player.panel` | 300ms easeInOut | 🟢 |
| `motion.snackbar.duration` | 3s | 🟢 |
| `motion.splash.delay` | 2s | 🟢 |

## Tema

| Token | Valor | Confiança |
|-------|-------|-----------|
| `theme.material` | M3 (`useMaterial3: true`) | 🟢 |
| `theme.seed` | `#1DB954` | 🟢 |
| `theme.modes` | system, light, dark | 🟢 |
| `theme.persistence.key` | `theme_mode` (int index) | 🟢 |
| `locale` | `pt_BR` | 🟢 |

## Componentes (referência)

| Token / padrão | Descrição | Confiança |
|----------------|-----------|-----------|
| `component.bottom-nav.items` | 5 | 🟢 |
| `component.snackbar.shape` | radius 12, floating | 🟢 |
| `component.player.max-lyrics-height` | 0.65 × screen height | 🟢 |
| `component.content.max-width` | 600 | 🟢 |

## Lacunas (🔴)

| Token referenciado | Situação |
|--------------------|----------|
| Paleta M3 completa (secondary, tertiary, containers) | Gerada em runtime, não versionada |
| Z-index scale | Não aplicável / não definido |
| Breakpoints custom | Não definidos |
