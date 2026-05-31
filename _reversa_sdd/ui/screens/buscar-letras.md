# Tela: Buscar Letras

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/search_screen.dart` |
| Estado capturado | Vazio (inicial) |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Busca global por título ou trecho de letra em todas as categorias.

## App bar

| Elemento | Descrição |
|----------|-----------|
| Leading | Voltar |
| Título | “Buscar Letras” |

## Formulário de busca

| Campo | Tipo | Placeholder | Obrigatório |
|-------|------|-------------|-------------|
| Query | `TextField` | “Pesquisar por nome ou trecho” | Não (vazio = sem resultados) |

- Ícone lupa à esquerda
- Busca disparada por submit / botão (não visível no screenshot vazio)

## Área de resultados

| Estado | Visual |
|--------|--------|
| Inicial (screenshot) | Branco vazio abaixo do campo |
| Loading | Indicador + “Buscando…” |
| Com resultados | Lista similar à CategoryScreen — título, código, ícones mídia |
| Sem resultados | Mensagem “Nenhum ponto encontrado” |
| Erro | Mensagem de erro + retry 🟡 INFERIDO |

## Interações por resultado

- Tap → `LyricViewScreen`
- Play inline se áudio disponível

## Navegação

- **Entrada:** Tab Buscar (Home ou CategoryScreen)
- **Saída:** LyricViewScreen ou back
