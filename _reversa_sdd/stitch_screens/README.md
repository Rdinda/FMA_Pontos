# Stitch → Flutter Mapping

Design exports from Google Stitch used as reference for the streaming UI in `lib/`.

## Design Tokens (extracted from HTML)

| Token | Hex | Source |
|-------|-----|--------|
| `background` / `surface` | `#131313` | All screens |
| `primary` | `#53E076` | Accent highlight |
| `primary-container` | `#1DB954` | Play buttons, progress |
| `on-primary-container` | `#004118` | Text on green buttons |
| `on-surface` | `#E5E2E1` | Primary text |
| `on-surface-variant` | `#BCCBB9` | Secondary text |
| `surface-container` | `#201F1F` | Cards, lyrics panel |
| `surface-container-high` | `#2A2A2A` | Mini player |
| `surface-container-highest` | `#353534` | Search field fill |
| `outline-variant` | `#3D4A3D` | Borders |

**Typography:** Plus Jakarta Sans (headline/body), Public Sans (labels) — via `google_fonts` in `lib/theme/app_theme.dart`.

**Spacing / radius:** `lib/theme/streaming_tokens.dart`

## Screen Mapping

| Stitch file | Flutter file | Status |
|-------------|--------------|--------|
| `Home_Acervo.html` | `lib/screens/home_screen.dart` | Implemented |
| `Categoria_Ogum_1.html` | `lib/screens/category_screen.dart` | Implemented |
| `Categoria_Ogum_2.html` | (variant of category) | Merged into category_screen |
| `Tocando_Agora_Ogum.html` | `lib/screens/lyric_view_screen.dart` | Implemented |
| `Busca.html` | `lib/screens/search_screen.dart` | Implemented |
| `Favoritos.html` | `lib/screens/favorites_screen.dart` | Implemented |
| `Mais_Tocados.html` | `lib/screens/top_played_screen.dart` | Implemented |
| `Mais_Tocados_Premium.html` | `lib/screens/top_played_screen.dart` | Partial (hero banner) |
| `Onboarding.html` | `lib/screens/onboarding_screen.dart` | Pending |
| `Onboarding_Privacidade.html` | `lib/screens/privacy_policy_screen.dart` | Pending |
| `Novo_Ponto.html` | `lib/screens/lyric_form_screen.dart` | Pending |
| `Painel_Administrativo.html` | `lib/screens/admin_screen.dart` | Partial (existing admin) |
| `Painel_Administrativo_Modernizado.html` | `lib/screens/admin_screen.dart` | Pending full restyle |

## Shared Widgets

| Stitch pattern | Flutter widget |
|----------------|----------------|
| Bottom nav | `lib/widgets/streaming/streaming_bottom_nav.dart` |
| Mini player bar | `lib/widgets/streaming/streaming_mini_player.dart` |
| Scaffold shell | `lib/widgets/streaming/streaming_scaffold.dart` |
| Category cards | `lib/widgets/streaming/category_card.dart` |
| Track rows | `lib/widgets/streaming/track_list_tile.dart` |
| Search field | `lib/widgets/streaming/streaming_search_field.dart` |
| Theme | `lib/theme/app_theme.dart`, `lib/theme/app_colors.dart` |

## Notes

- App labels preserved from legacy (`Gostei`, `Buscar`, etc.) where they differ from Stitch mock text.
- Admin tab on home bottom nav appears only for users with `admin` role; moderators see `Categoria` (add category).
- Category-specific artwork from Stitch CDN is not bundled; placeholders use `assets/images/main.png` and gradient cards.
