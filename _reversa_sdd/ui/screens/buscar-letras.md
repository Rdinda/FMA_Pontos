# Tela: Buscar

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/search_screen.dart` |
| Scaffold | `StreamingScaffold` (`navContext: standard`) |
| Estado capturado | Browse categorias (sem query) |
| Screenshot | 2026-05-31 |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Busca global por nome/trecho de letra e descoberta por categorias (grid ilustrado estilo Spotify Browse).

## App bar

| Elemento | Descrição |
|----------|-----------|
| Leading | `arrow_back_rounded` verde |
| Título app | **“FMA Pontos”** verde bold, central |
| Título página | **“Buscar”** — `headlineMedium` branco, abaixo da app bar |

## Campo de busca

| Propriedade | Valor |
|-------------|-------|
| Componente | `StreamingSearchField` |
| Placeholder | **“O que você quer ouvir?”** |
| Ícone | Lupa à esquerda |
| Fundo | `surfaceContainerHighest` pill full-width |

## Conteúdo — browse (sem query)

| Elemento | Descrição |
|----------|-----------|
| Seção | **“Navegar por todas as categorias”** |
| Layout | Grid 2 colunas |
| Card | `BentoCategoryCard` — ilustração + label canto inferior |
| Categorias visíveis | Caboclos · Egunitá _ Oroiná · Iansã · Iemanjá (+ parcial na dobra) |
| Tap | `CategoryScreen(category)` |

## Conteúdo — com query (código, não capturado)

| Estado | Visual |
|--------|--------|
| Loading | Indicador central |
| Resultados | `TrackListTile` por letra encontrada |
| Vazio | Mensagem sem resultados |
| Erro | Mensagem + snackbar |

## Bottom navigation

| Índice | Label | Estado no screenshot |
|--------|-------|----------------------|
| 0 | Início | Inativo |
| 1 | Buscar | **Ativo (verde)** |
| 2 | Top | Inativo |
| 3 | Gostei | Inativo |
| 4 | Admin | Inativo (admin) |

## Navegação

- Voltar → pop
- Card categoria → `CategoryScreen`
- Resultado → `LyricViewScreen`
