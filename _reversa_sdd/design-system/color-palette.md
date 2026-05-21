# Paleta de Cores — FMA_Pontos

> Extraído de `lib/main.dart`, `ThemeProvider`, telas e utilitários.  
> Escala: 🟢 CONFIRMADO no código | 🟡 INFERIDO (Material 3 `fromSeed`) | 🔴 LACUNA

## Cor semântica principal (seed)

| Token | Valor | Uso | Confiança |
|-------|-------|-----|-----------|
| `primary` / `primaryColor` | `#6200EE` (`Color(0xFF6200EE)`) | AppBar, botões focados, bottom nav selecionado, loader splash, snackbar sucesso | 🟢 |
| `onPrimary` | `#FFFFFF` | Texto/ícones sobre primária (estimado via `estimateBrightnessForColor`) | 🟢 |

## ColorScheme (Material 3)

🟢 **CONFIRMADO** — Temas claro e escuro usam `ColorScheme.fromSeed(seedColor: primaryColor)` com `useMaterial3: true`, sobrescrevendo apenas `primary` e `onPrimary`.

🟡 **INFERIDO** — Demais papéis (`secondary`, `tertiary`, `surface`, `error`, `outline`, `surfaceContainer*`, etc.) são **gerados automaticamente** pelo algoritmo M3 a partir do seed `#6200EE`. Valores exatos variam entre light/dark e versão do Flutter.

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
| Erro / permissão | `colorScheme.error` + `onError` | `SnackbarUtils` (`isError: true`) | 🟢 |
| Sucesso / info | `colorScheme.primary` + `onPrimary` | `SnackbarUtils` (padrão) | 🟢 |
| Destrutivo (texto) | `Colors.red` | Diálogos "Excluir" | 🟢 |
| Favorito ativo | `colorScheme.error` | Ícone coração preenchido no player | 🟢 |
| Admin / alerta | `Colors.red` com `alpha: 0.1` | `admin_screen` | 🟢 |

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
| `ThemeMode.system` (padrão inicial) | `SharedPreferences` chave `theme_mode` (índice) | 🟢 |
| `ThemeMode.light` | idem | 🟢 |
| `ThemeMode.dark` | idem | 🟢 |
| Ciclo UI | system → light → dark → system (`cycleTheme`) | 🟢 |

Ícones: `brightness_auto`, `light_mode`, `dark_mode` — `ThemeProvider.themeIcon`.

## Lacunas

- 🔴 Não há arquivo de tokens centralizado (JSON/YAML); cores secundárias M3 não estão versionadas no repositório.
- 🟡 Paleta completa light/dark depende da versão do Flutter em build time.
