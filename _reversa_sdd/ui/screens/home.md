# Tela: Home (Acervo de Categorias)

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/home_screen.dart` |
| Estado capturado | Preenchido |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Hub principal: listar categorias de pontos com contagem e acesso rápido às demais áreas do app.

## App bar

| Elemento | Descrição |
|----------|-----------|
| Título | “Filhos de Maria das Almas” |
| Leading | — |
| Actions | Ícone offline (condicional), avatar Google ou ícone info |

## Lista de categorias

Cada item (`ListTile` / card):

| Parte | Conteúdo |
|-------|----------|
| Leading | Quadrado arredondado colorido + ícone `music_note` |
| Title | Nome da categoria (ex: Caboclos, Iansã, Oxum) |
| Subtitle | “{N} pontos” |
| Trailing | `chevron_right` |
| Ação | Navega para `CategoryScreen(category)` |

**Categorias visíveis no screenshot:** Caboclos (213), Egunitá _ Oroiná (1), Iansã (55), Iemanjá (74), Logun Edé (1), Nanã Buruquê (50), Obaluaiê (34), Obá (5).

## Bottom navigation

| Tab | Label | Ícone | Comportamento |
|-----|-------|-------|---------------|
| 0 | Home | `home` | Permanece (ativo, roxo) |
| 1 | Buscar | `search` | Push `SearchScreen` |
| 2 | Top | `trending_up` | Push `TopPlayedScreen` |
| 3 | Gostei | `favorite` | Push `FavoritesScreen` |
| 4 | Categoria | `add_circle` | Dialog nova categoria (moderador+) |

## Interações adicionais (código)

- **Pull-to-refresh:** re-sync + refresh role
- **Back duplo:** snackbar “Pressione novamente para sair” → fecha app
- **Avatar/info:** bottom sheet com login, versão, admin link

## Estados

| Estado | Visual |
|--------|--------|
| Loading | `CircularProgressIndicator` central |
| Vazio | “Nenhuma categoria encontrada. Adicione uma nova!” |
| Offline | Ícone `wifi_off` vermelho na app bar |
| Preenchido | Lista scrollável (screenshot) |

## Navegação

- **Entrada:** Splash / Onboarding concluído
- **Saída:** CategoryScreen, SearchScreen, TopPlayed, Favorites, dialogs
