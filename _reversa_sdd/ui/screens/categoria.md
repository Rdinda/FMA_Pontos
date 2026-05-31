# Tela: Categoria (Lista de Letras)

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/category_screen.dart` |
| Estado capturado | Preenchido — Caboclos |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Exibir todos os pontos/letras de uma categoria; permitir reprodução inline, abrir detalhe e adicionar nova letra.

## App bar

| Elemento | Descrição |
|----------|-----------|
| Leading | `arrow_back` → volta à Home |
| Título | Nome da categoria (“Caboclos”) |
| Actions | `play_circle` — toca playlist da categoria (CategoryPlayerWidget) |

## Lista de letras

| Parte | Conteúdo |
|-------|----------|
| Leading | Número sequencial (`sequenceNumber`) em quadrado cinza; vira equalizer se tocando |
| Title | Título capitalizado, ellipsis 1 linha |
| Subtitle | Código `{category.code}{seq:02}` — ex: CA01, CA02 |
| Subtitle icons | `music_note` se áudio; `videocam` se YouTube |
| Trailing | Play/pause inline + chevron |
| Tap | → `LyricViewScreen` |

**Itens visíveis:** CA01–CA08 (Caboclo 7 flechas, Aldeia do Pai Tupinambá, Cabocla Iara, etc.)

## Bottom navigation (3 itens)

| Tab | Label | Ação |
|-----|-------|------|
| 0 | Home | `popUntil` first route |
| 1 | Buscar | Push SearchScreen |
| 2 | Letra | Push LyricFormScreen (requer login + role user) |

## Permissões (não visíveis)

- Long-press / menu: editar/excluir categoria (moderador/admin)
- Tab Letra bloqueada: snackbar “Faça login com Google…”

## Estados

| Estado | Visual |
|--------|--------|
| Loading | Indicador central |
| Vazio | Mensagem sem letras |
| Preenchido | Lista scrollável (screenshot) |
| Item tocando | Leading animado + título bold roxo |

## Navegação

- **Entrada:** Tap categoria na Home
- **Saída:** LyricViewScreen, SearchScreen, LyricFormScreen, Home (back ou tab)
