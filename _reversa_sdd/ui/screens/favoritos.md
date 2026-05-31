# Tela: Favoritos (Gostei)

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/favorites_screen.dart` |
| Scaffold | `StreamingScaffold` (`navContext: standard`) |
| Estado capturado | Vazio |
| Screenshot | 2026-05-31 |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Exibir pontos marcados como favoritos (armazenamento local `SharedPreferences`), com play all quando houver faixas com áudio.

## App bar

| Elemento | Descrição |
|----------|-----------|
| Leading | Voltar verde |
| Título | **“FMA Pontos”** verde bold, central |

## Cabeçalho de conteúdo

| Elemento | Descrição |
|----------|-----------|
| Título | **“Seus Pontos Salvos”** — branco, grande |
| Subtítulo | “{N} ponto(s) marcados como favoritos” — cinza (no capture: 0 favoritos) |

🟡 No screenshot a legenda pode parecer “O pontos…” — no código é **“0 pontos marcados…”**.

## Empty state (capturado)

| Elemento | Descrição |
|----------|-----------|
| Ícone | `favorite_border` grande, cinza semitransparente |
| Título | **“Nenhum favorito ainda”** |
| Subtítulo | **“Suas músicas favoritas aparecerão aqui.”** |

🟡 Terminologia mista: “pontos” no título vs “músicas” no empty (código atual).

## Estado preenchido (código, não capturado)

| Elemento | Descrição |
|----------|-----------|
| Lista | `TrackListTile` por favorito |
| FAB play | Círculo verde — `playAll` faixas com áudio |
| Ações | Tap → `LyricViewScreen`; desfavoritar no tile/menu |

## Bottom navigation

| Índice | Label | Estado |
|--------|-------|--------|
| 3 | Gostei | **Ativo (verde)** |

## Navegação

- Tab Gostei de qualquer tela → `FavoritesScreen`
- Item → `LyricViewScreen`
