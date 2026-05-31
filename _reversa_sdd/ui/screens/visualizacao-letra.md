# Tela: Visualização de Letra

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/lyric_view_screen.dart` |
| Estado capturado | Preenchido, sem mídia |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Ler letra completa; reproduzir áudio MP3 ou embed YouTube; favoritar; editar (moderador+).

## App bar

| Elemento | Descrição |
|----------|-----------|
| Leading | Voltar |
| Título | `{code}{seq:02} - {TITULO}` — ex: “CA01 - CABOCLO 7 FLECHAS …” |
| Actions | Favorito, editar (condicional), play/pause (se áudio) |

## Corpo — estado sem mídia (screenshot)

```
┌─────────────────────────────┐
│ ℹ Sem mídia para tocar.     │
│   Adicione MP3 ou YouTube  │
├─────────────────────────────┤
│                             │
│   [Card com letra]          │
│   Foi numa tarde serena     │
│   Lá nas matas da Jurema... │
│                             │
└─────────────────────────────┘
```

| Elemento | Tipo | Detalhe |
|----------|------|---------|
| Banner info | Container `surfaceContainerHighest` | Ícone `info`, texto fixo sobre ausência de mídia |
| Letra | Card scrollável | Texto plain, Plus Jakarta Sans 18px, padding generoso |

## Corpo — estados alternativos (código, não capturados)

| Estado | Elementos extras |
|--------|------------------|
| Com áudio | Botão play grande, barra de progresso, duração |
| Com YouTube | `YoutubePlayer` embed acima da letra |
| Favorito ativo | Ícone coração preenchido |

## Ações

| Ação | Permissão | Resultado |
|------|-----------|-----------|
| Play | Áudio disponível | `AudioPlayerService.play` |
| Favoritar | Logado | `FavoritesService` local |
| Editar | Moderador+ | Push LyricFormScreen |
| Incrementar plays | Automático | RPC Supabase 🟡 INFERIDO |

## Navegação

- **Entrada:** CategoryScreen, SearchScreen, Favorites, TopPlayed
- **Saída:** Back, ou pop após editar
