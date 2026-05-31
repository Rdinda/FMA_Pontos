# Tela: Visualização de Letra (Now Playing)

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/lyric_view_screen.dart` |
| Scaffold | `StreamingScaffold` |
| Estado capturado | Sem mídia — player + sheet de letra |
| Screenshot | 2026-05-31 |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Tela imersiva estilo “agora tocando”: capa, metadados da faixa, controles e letra em painel inferior deslizante (bottom sheet).

## Header

| Elemento | Descrição |
|----------|-----------|
| Leading | Chevron para baixo — minimiza / volta (`Navigator.pop`) |
| Centro | Label **“PLAYLIST”** (caption cinza) + **“Reproduzindo”** (branco) |
| Trailing | Menu `more_vert` (editar, info, etc. — RBAC) |

## Área do player

| Elemento | Descrição |
|----------|-----------|
| Capa | Quadrado grande; gradiente verde escuro + ícone `music_note` quando sem arte |
| Título | Nome do ponto truncado (ex. “Caboclo Pena Dourada - Lá na aldeia…”) |
| Subtítulo | Nome da categoria (ex. “Caboclos”) — cinza |
| Favorito | `favorite_border` à direita do título |
| Status | **“Sem mídia para tocar.”** quando sem MP3/YouTube (capture) |

🟢 Com áudio: capa pode exibir arte; FAB/play aciona `AudioPlayerService`.

## Bottom sheet — letra

| Elemento | Descrição |
|----------|-----------|
| Container | Card cinza escuro, cantos superiores arredondados |
| Grabber | Barra horizontal central (arraste) |
| Conteúdo | Estrofes — primeira linha **bold branco**, demais **cinza** |
| Exemplo | “Lá na aldeia tem um caboclo forte” / “Foi Pai Oxóssi quem o enviou” |

## Bottom navigation

Visível na captura com **Início** ativo (verde). Player permanece na pilha; nav global ainda acessível.

| Tab | Comportamento |
|-----|---------------|
| Início | `popUntil` root |
| Buscar / Top / Gostei | Push telas correspondentes |
| Admin | Se `isAdmin` |

## Estados (máquina UI)

| Estado | Visual |
|--------|--------|
| Sem mídia | Placeholder + mensagem (capture) |
| Com áudio | Controles play/pause; mini-player sincronizado |
| Com YouTube | `YoutubePlayer` no lugar da capa estática |
| Sheet | Parcialmente expandido (capture) · pode expandir/colapsar |

## Navegação

- Chevron / back → retorna à lista (`CategoryScreen` ou origem)
- Menu → editar letra (`LyricFormScreen`) se permissão
- Favorito → toggle `FavoritesService`
