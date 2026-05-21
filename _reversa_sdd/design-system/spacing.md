# Espaçamento e Layout — FMA_Pontos

> Valores extraídos de padding/margin explícitos no código Flutter. Não há `spacing.dart` centralizado.

## Escala de espaçamento observada

Valores recorrentes (px lógicos):

| Token informal | Valor | Exemplos de uso | Confiança |
|----------------|-------|-----------------|-----------|
| `xs` | 4 | Espaço entre título e subtítulo em cards | 🟢 |
| `sm` | 8 | Gaps verticais em listas, splash progress | 🟢 |
| `md` | 12 | Margens de lista, snackbar margin vertical, ícones compactos | 🟢 |
| `base` | 16 | Padding horizontal padrão, inputs, listas | 🟢 |
| `lg` | 20 | Espaçamento onboarding topo | 🟢 |
| `xl` | 24 | Padding de telas (`lyric_view`, onboarding, bottom sheet) | 🟢 |
| `2xl` | 28–32 | Separação entre blocos, loading padding | 🟢 |
| `3xl` | 48 | Padding horizontal progress splash | 🟢 |

🟡 **INFERIDO** — Escala não é formalizada; valores foram inferidos por frequência, não por constante nomeada.

## Border radius

| Raio | Uso | Confiança |
|------|-----|-----------|
| 2 | Handle do bottom sheet (`app_info`) | 🟢 |
| 8 | Badges numéricos em listas, avatar rank | 🟢 |
| 12 | **Padrão dominante**: cards, tiles, inputs, snackbar, botões sheet | 🟢 |
| 16 | Painéis de mídia / letra | 🟢 |
| 20 | Chip/badge versão | 🟢 |
| 24 | Topo do bottom sheet | 🟢 |
| 26 | Clip do logo onboarding (`BreathingLogo`) | 🟢 |

## Elevação e sombras

| Elemento | Elevação / sombra | Confiança |
|----------|-------------------|-----------|
| AppBar light | `elevation: 2` | 🟢 |
| AppBar dark | `elevation: 0` | 🟢 |
| Card | `elevation: 2` | 🟢 |
| Snackbar | `elevation: 6` | 🟢 |
| Player compacto | `BoxShadow` blur 8, offset (0,-2) | 🟢 |
| Lyric view AppBar | `elevation: 0`, fundo transparente | 🟢 |

## Layout e larguras

| Padrão | Valor | Confiança |
|--------|-------|-----------|
| Conteúdo letra max width | 600 (`ConstrainedBox`) | 🟢 |
| Logo splash | 300×300 | 🟢 |
| Logo onboarding | 220×220 | 🟢 |
| Painel letra no player | até 65% da altura da tela | 🟢 |
| Bottom sheet handle width | implícito no container | 🟡 |

## Grid e breakpoints

🟡 **INFERIDO** — App **mobile-only** (Flutter Material). Não há `LayoutBuilder` com breakpoints customizados nem `MediaQuery` thresholds documentados no código analisado.

Breakpoints efetivos: padrão Flutter/Material (compact/medium/large) sem customização explícita.

## Navegação inferior

🟢 **CONFIRMADO** — `BottomNavigationBarType.fixed`, 5 itens (Home, Buscar, Top, Gostei, Categoria).

| Propriedade | Valor |
|-------------|-------|
| `selectedItemColor` | `colorScheme.primary` |
| `unselectedItemColor` | `colorScheme.onSurfaceVariant` |

## Inputs (`InputDecorationTheme`)

| Propriedade | Light | Dark | Confiança |
|-------------|-------|------|-----------|
| `contentPadding` | 16×16 | 16×16 | 🟢 |
| `borderRadius` | 12 | 12 | 🟢 |
| `focusedBorder` width | 2 | 2 | 🟢 |
| `filled` | true | true | 🟢 |

## Lacunas

- 🔴 Sem design tokens de espaçamento versionados.
- 🟡 Responsividade tablet/desktop não tratada explicitamente.
