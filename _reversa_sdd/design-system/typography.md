# Tipografia — FMA_Pontos

> Fontes via `google_fonts`. Tema global em `lib/main.dart`; exceções em telas específicas.

## Famílias

| Família | Papel | Onde definida | Confiança |
|---------|-------|---------------|-----------|
| **Outfit** | Tipografia principal do app (Material `textTheme`, AppBar) | `GoogleFonts.outfitTextTheme()` em `main.dart` | 🟢 |
| **Montserrat** | Títulos de letra / player compacto | `lyric_view_screen`, `category_player_widget` | 🟢 |
| **Open Sans** | Corpo de letra (conteúdo longo) | `lyric_view_screen`, `category_player_widget` | 🟢 |

🟡 **INFERIDO** — Não há fallback explícito além do que `google_fonts` resolve em runtime (download/cache).

## Hierarquia global (tema Outfit)

🟢 **CONFIRMADO** — `ThemeData.textTheme` usa escala Material 3 derivada de `GoogleFonts.outfitTextTheme()` (light) e `outfitTextTheme(ThemeData.dark().textTheme)` (dark).

| Estilo M3 | Uso observado | Confiança |
|-----------|---------------|-----------|
| `headlineSmall` | Títulos onboarding (bold, `onSurface`) | 🟢 |
| `bodyMedium` | Corpo onboarding, snackbar, checkbox | 🟢 |
| `bodySmall` | Legendas onboarding, metadados | 🟢 |
| AppBar `titleTextStyle` | **20px**, **bold**, `onPrimary` | 🟢 |

## Tipografia local (fora do textTheme)

| Contexto | Família | Tamanho | Peso | Line-height | Confiança |
|----------|---------|---------|------|-------------|-----------|
| AppBar detalhe letra | Montserrat | 20 | bold | padrão | 🟢 |
| Conteúdo da letra | Open Sans | 18 | normal | 1.75 | 🟢 |
| Título player compacto | Montserrat | 14 | w600 | — | 🟢 |
| Índice player (`N de M`) | tema default | 11 | normal | — | 🟢 |
| Conteúdo painel letra (player) | Open Sans | 16 | normal | 1.75 | 🟢 |
| Item lista categoria/letra | tema default | 16 | w600 | — | 🟢 |
| Subtítulo lista | tema default | 12–13 | normal | — | 🟢 |
| Versão splash | tema default | 12 | w300 | — | 🟢 |
| Estado vazio favoritos | tema default | 18 / 14 | normal | — | 🟢 |

## TabBar

| Propriedade | Valor | Confiança |
|-------------|-------|-----------|
| `labelColor` | `onPrimary` | 🟢 |
| `unselectedLabelColor` | `onPrimary` @ 70% opacity | 🟢 |
| `indicatorColor` | `onPrimary` | 🟢 |

## Onboarding — animação de texto

🟢 **CONFIRMADO** — Slides usam `Curves.easeOutCubic` em fade/translate/scale; tipografia vem do `textTheme` do tema, não de tamanhos fixos adicionais além dos estilos acima.

## Lacunas

- 🔴 Não há escala tipográfica documentada em design tokens (apenas uso ad hoc + textTheme M3).
- 🟡 Mistura Outfit (global) + Montserrat/Open Sans (letras) pode gerar inconsistência visual se não padronizada na migração.
