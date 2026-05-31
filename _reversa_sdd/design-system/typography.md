# Tipografia — FMA_Pontos

> Fontes via `google_fonts`. Tema global em `lib/theme/app_theme.dart`.

## Famílias

| Família | Papel | Onde definida | Confiança |
|---------|-------|---------------|-----------|
| **Plus Jakarta Sans** | Tipografia única do app (shell, letras, admin) | `GoogleFonts.plusJakartaSansTextTheme()` em `app_theme.dart` | 🟢 |

🟡 **INFERIDO** — Não há fallback explícito além do que `google_fonts` resolve em runtime (download/cache).

## Hierarquia global (Plus Jakarta Sans)

🟢 **CONFIRMADO** — `ThemeData.textTheme` usa escala Material 3 derivada de `GoogleFonts.plusJakartaSansTextTheme()`.

| Estilo M3 | Uso observado | Confiança |
|-----------|---------------|-----------|
| `headlineSmall` | Títulos onboarding (bold, `onSurface`) | 🟢 |
| `bodyMedium` | Corpo onboarding, snackbar, checkbox | 🟢 |
| `bodySmall` | Legendas onboarding, metadados | 🟢 |
| AppBar `titleTextStyle` | **20px**, **bold**, `onSurface` (AppBar transparente) | 🟢 |

## Tipografia local (fora do textTheme)

🟢 **CONFIRMADO** — Após `001-novo-visual-streaming`, tipografia local usa `textTheme` (Plus Jakarta Sans).

| Contexto | Estilo | Tamanho | Peso | Line-height | Confiança |
|----------|--------|---------|------|-------------|-----------|
| AppBar detalhe letra | `titleLarge` | 20 | bold | padrão | 🟢 |
| Conteúdo da letra | `bodyLarge` | 18 | normal | 1.75 | 🟢 |
| Título player compacto | `titleSmall` | 14 | w600 | — | 🟢 |
| Índice player (`N de M`) | `labelSmall` | 11 | normal | — | 🟢 |
| Conteúdo painel letra (player) | `bodyMedium` | 16 | normal | 1.75 | 🟢 |
| Item lista categoria/letra | `titleMedium` | 16 | w600 | — | 🟢 |
| Subtítulo lista | `bodySmall` | 12–13 | normal | — | 🟢 |
| Versão splash | `bodySmall` | 12 | w300 | — | 🟢 |
| Estado vazio favoritos | `titleMedium` / `bodyMedium` | 18 / 14 | normal | — | 🟢 |

## TabBar

| Propriedade | Valor | Confiança |
|-------------|-------|-----------|
| `labelColor` | `colorScheme.primary` | 🟢 |
| `unselectedLabelColor` | `colorScheme.onSurfaceVariant` | 🟢 |
| `indicatorColor` | `colorScheme.primary` | 🟢 |

## Onboarding — animação de texto

🟢 **CONFIRMADO** — Slides usam `Curves.easeOutCubic` em fade/translate/scale; tipografia vem do `textTheme` do tema, não de tamanhos fixos adicionais além dos estilos acima.

## Lacunas

- 🔴 Não há escala tipográfica documentada em design tokens (apenas uso ad hoc + textTheme M3).
- 🟡 `google_fonts` exige rede/cache no primeiro boot; offline prolongado pode atrasar fonte.
