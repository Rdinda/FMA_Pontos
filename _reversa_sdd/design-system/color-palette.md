# Paleta de Cores — FMA_Pontos

> Extraído de `lib/theme/app_colors.dart`, `lib/theme/app_theme.dart`, `ThemeProvider`, telas e utilitários.  
> Escala: 🟢 CONFIRMADO no código | 🟡 INFERIDO | 🔴 LACUNA  
> Re-extração visual: 2026-05-31

## Cor semântica principal (seed)

| Token | Valor | Uso | Confiança |
|-------|-------|-----|-----------|
| `primary` / `primaryContainer` | `#1DB954` / `#53E076` | Bottom nav ativo, CTAs, loader splash, snackbar sucesso | 🟢 |
| `onPrimary` | `#003914` (dark) / `#FFFFFF` (light botão) | Texto sobre verde sólido | 🟢 |

## ColorScheme (Material 3)

🟢 **CONFIRMADO** — Temas em `lib/theme/app_theme.dart`: `ColorScheme` explícito dark (Stitch) + light espelhado; `useMaterial3: true`.

🟢 **CONFIRMADO** — Surfaces dark: `#131313` (scaffold), `#201f1f`–`#353534` (containers).

### Papéis usados explicitamente na UI

| Papel M3 | Uso no app | Confiança |
|----------|------------|-----------|
| `primary` | Navegação selecionada, bordas focadas, ícones ativos, progresso | 🟢 |
| `onPrimary` | AppBar, TabBar, snackbar sucesso | 🟢 |
| `onSurface` | Títulos de lista, texto principal | 🟢 |
| `onSurfaceVariant` | Subtítulos, metadados, versão splash | 🟢 |
| `outline` / `outlineVariant` | Bordas, ícones secundários, estados vazios | 🟢 |
| `surface` | Scaffold escuro | 🟢 |
| `surfaceContainer` | Fundo do player compacto | 🟢 |
| `surfaceContainerHighest` | Cards escuros, fill de inputs escuros | 🟢 |
| `primaryContainer` / `onPrimaryContainer` | Badge ícone no painel de letra do player | 🟢 |
| `error` / `onError` | Snackbar de erro | 🟢 |

## Fundos

| Contexto | Light | Dark | Confiança |
|----------|-------|------|-----------|
| Scaffold | `Colors.grey[50]` ≈ `#FAFAFA` | `colorScheme.surface` | 🟢 |
| Input fill | `#FFFFFF` | `surfaceContainerHighest` | 🟢 |
| Bottom sheet | `surface` (via tema) | idem | 🟡 |

## Cores de feedback

| Semântica | Implementação | Onde | Confiança |
|-----------|---------------|------|-----------|
| Erro / permissão | `#E07A6B` (salmon/coral Stitch) | `SnackbarUtils` via `toastification` (`isError: true`) | 🟢 |
| Sucesso / info | `AppColors.primaryContainer` + texto branco | `SnackbarUtils` via `toastification` (padrão) | 🟢 |
| Destrutivo (texto) | `Colors.red` | Diálogos "Excluir" | 🟢 |
| Favorito ativo | `colorScheme.error` | Ícone coração preenchido no player | 🟢 |
| Badge role admin | `#1DB954` (`AppColors.roleAdmin`) | `RoleBadge` em `admin_screen` | 🟢 |
| Badge role moderador | `#BB86FC` | `RoleBadge` | 🟢 |
| Badge role user | `#9E9E9E` | `RoleBadge` | 🟢 |

## Cores decorativas (fora do tema)

| Uso | Valor | Onde | Confiança |
|-----|-------|------|-----------|
| Ranking 1º | `Colors.amber` | `top_played_screen` | 🟢 |
| Ranking 2º | `Colors.grey.shade400` | idem | 🟢 |
| Ranking 3º | `Colors.brown.shade300` | idem | 🟢 |
| Borda input light | `Colors.grey.shade200` | `InputDecorationTheme` light | 🟢 |
| Sombra player | `Colors.black` α 0.1 (light) / 0.3 (dark) | `category_player_widget` | 🟢 |

## Modo claro / escuro / sistema

| Modo | Persistência | Confiança |
|------|--------------|-----------|
| `ThemeMode.dark` (padrão sem prefs) | `ThemeProvider` construtor | 🟢 |
| `ThemeMode.system` | `SharedPreferences` chave `theme_mode` (índice) | 🟢 |
| `ThemeMode.light` | idem | 🟢 |
| `ThemeMode.dark` | idem | 🟢 |
| Ciclo UI | system → light → dark → system (`cycleTheme`) | 🟢 |

Ícones: `brightness_auto`, `light_mode`, `dark_mode` — `ThemeProvider.themeIcon`.

## Lacunas

- 🔴 Não há arquivo de tokens centralizado (JSON/YAML); cores secundárias M3 não estão versionadas no repositório.
- 🟡 Paleta completa light/dark depende da versão do Flutter em build time.
