# Investigation: 001-novo-visual-streaming

> Data: `2026-05-21`
> Requirements: `_reversa_forward/001-novo-visual-streaming/requirements.md`

## 1. Objetivo da investigação

Validar como o legado Flutter aplica tema hoje e mapear a tradução mais segura dos mocks Stitch (HTML/PNG) para `ThemeData` + widgets, sem tocar camada de dados.

## 2. Estado atual do legado

### Bootstrap e tema (`lib/main.dart`)

- `primaryColor = Color(0xFF6200EE)` fixo.
- Light: scaffold `Colors.grey[50]`, AppBar preenchida com primary roxa.
- Dark: `ColorScheme.fromSeed` + `GoogleFonts.outfitTextTheme`.
- InputDecoration: radius 12, borders grey/outline — **compatível** com mocks (ajustar cores).

### ThemeProvider (`lib/providers/theme_provider.dart`)

- Persiste `theme_mode` em SharedPreferences.
- Default: `ThemeMode.system` (não dark).
- Toggle via `AppInfoBottomSheet` — **preservar** API pública.

### Tipografia

- Global: Outfit via `google_fonts`.
- Exceções: Montserrat (título letra), Open Sans (corpo letra) em `lyric_view_screen.dart`.
- Mocks Stitch: Plus Jakarta Sans em todo o shell.

### Telas e padrões visuais

| Tela | Arquivo | Padrão legado relevante |
|------|---------|-------------------------|
| Home | `home_screen.dart` | Bottom nav 5 itens; grid/list categorias; AppBar primary |
| Category | `category_screen.dart` | Lista numerada; player inline |
| Search | `search_screen.dart` | Campo busca; push navigation |
| Lyric view | `lyric_view_screen.dart` | AppBar transparente; card letra; player |
| Lyric form | `lyric_form_screen.dart` | Form fields; file picker UI |
| Favorites | `favorites_screen.dart` | AppBar transparente |
| Top played | `top_played_screen.dart` | Rank colors amber/grey/brown |
| Admin | `admin_screen.dart` | TabBar; `_getRoleColor` usa error para admin |
| Onboarding | `onboarding_screen.dart` + `onboarding_widgets.dart` | Animações easeOutCubic |
| Privacy | `privacy_policy_screen.dart` | Scroll legal text |
| Splash | `splash_screen.dart` | Loader primary; usa `colorScheme` |

### Widgets compartilhados

- `CategoryPlayerWidget` — mini-player com sombra preta; usado em Home/Category/Admin.
- `AppInfoBottomSheet` — theme toggle, versão, links.
- `SnackbarUtils` — floating, radius 12, primary/error background.

## 3. Golden files analisados

| Mock | Insights extraídos |
|------|-------------------|
| `Home_Acervo.html` | Paleta M3 custom completa; Plus Jakarta Sans; bottom nav com ícone ativo verde |
| `Painel_Administrativo_Modernizado.html` | primary `#1DB954`; tabs pill; search field rounded-full |
| `Busca.html` | Search bar full-width pill `surface-container-highest` |
| `Tocando_Agora_Ogum.png` | Banner placeholder; tipografia letra grande; player bar inferior |
| `Onboarding.html` | CTA verde sólido `#1DB954`; fundo dark |

Screenshots em `_reversa_sdd/*/screenshots/` confirmam paridade feature-a-feature com PNGs Stitch.

## 4. Alternativas avaliadas

| Alternativa | Prós | Contras | Decisão |
|-------------|------|---------|---------|
| A. Só trocar seed color em `fromSeed` | Diff mínimo (~10 linhas) | Surfaces/primary não batem com mocks; AppBar continua errada | **Descartada** |
| B. ThemeData explícito + widgets shared | Fidelidade aos mocks; manutenível | Mais arquivos novos | **Escolhida** |
| C. Pacote externo (flutter_screenutil, flex_color_scheme) | Temas prontos | Nova dependência; curva de aprendizado | **Descartada** |
| D. Dark-only | Implementação mais rápida | Rejeitado em `/reversa-clarify` | **Descartada** |
| E. Manter Outfit, só trocar cores | Zero risco fonte | Contradiz RN-06 | **Descartada** |

## 5. Padrões Flutter aplicáveis

- **Material 3** já habilitado (`useMaterial3: true`) — manter.
- **`ColorScheme` roles** mapeados 1:1 dos tokens Tailwind nos HTMLs.
- **`ThemeExtension`** opcional para tokens extras (rank gold/silver/bronze, badge admin) — avaliar em coding se `ColorScheme` não bastar.
- **Google Fonts** — `GoogleFonts.plusJakartaSans()` substitui `outfit()` sem mudança em `pubspec.yaml` (download runtime). Referência: [google_fonts package](https://pub.dev/packages/google_fonts).

## 6. Referências internas

- `_reversa_sdd/design-system/tokens.md` — baseline legado
- `_reversa_sdd/design-system/color-palette.md` — `#6200EE` documentado
- `_reversa_sdd/ui/inventory.md` — mapa tela → arquivo
- `_reversa_sdd/ui/flow.md` — bottom nav + mini-player persistentes
- `_reversa_sdd/administracao/design.md` — gate admin

## 7. Conclusão

A migração é **mecânica e de baixo risco funcional** se limitada a `lib/theme/`, `lib/widgets/streaming/` e decorations nas screens. O maior esforço está na **paridade visual tela a tela** e no **tema claro derivado** (🟡). Nenhuma investigação adicional de backend é necessária antes do coding.
