# Busca — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a busca local de letras/pontos por título ou trecho do conteúdo.  
🟢 **CONFIRMADO** — A busca usa dados SQLite já sincronizados/localmente disponíveis, sem chamada remota direta.  
🟢 **CONFIRMADO** — Resultados permitem navegar para a visualização completa da letra.

## Responsabilidades

- 🟢 **CONFIRMADO** — Capturar texto de busca digitado pelo usuário.
- 🟢 **CONFIRMADO** — Executar busca quando o usuário submete o campo.
- 🟢 **CONFIRMADO** — Pesquisar em `title` e `content` da tabela local `lyrics`.
- 🟢 **CONFIRMADO** — Ignorar letras com `is_deleted = 1`.
- 🟢 **CONFIRMADO** — Exibir resultado com título, trecho do conteúdo e indicador visual de reprodução atual.
- 🟢 **CONFIRMADO** — Navegar para `LyricViewScreen` ao tocar em um resultado.
- 🟢 **CONFIRMADO** — Permitir refresh manual que sincroniza dados e repete a busca se houver query.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Query vazia limpa os resultados.
- 🟢 **CONFIRMADO** — Query não vazia executa `SyncRepository.searchLyrics(query)`.
- 🟢 **CONFIRMADO** — A busca local usa `(title LIKE ? OR content LIKE ?) AND is_deleted = 0`.
- 🟢 **CONFIRMADO** — Resultados são ordenados por `title ASC`.
- 🟢 **CONFIRMADO** — A busca não exige autenticação específica.
- 🟢 **CONFIRMADO** — Refresh executa `syncData()` antes de refazer a busca atual.
- 🟡 **INFERIDO** — A busca é case-insensitive dependendo do comportamento padrão do SQLite para `LIKE` no ambiente.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve exibir um campo de busca com label "Pesquisar por nome ou trecho". | Must | Dado a tela de busca aberta, quando renderizada, então o campo de texto aparece com ícone de busca. |
| RF-02 | 🟢 O sistema deve executar busca ao submeter o campo. | Must | Dado query não vazia, quando o usuário submete, então `SyncRepository.searchLyrics(query)` é chamado. |
| RF-03 | 🟢 O sistema deve limpar resultados quando a query estiver vazia. | Must | Dado resultados anteriores, quando a busca é submetida com query vazia, então `_results` fica vazio. |
| RF-04 | 🟢 O sistema deve pesquisar por título ou conteúdo. | Must | Dado letras locais, quando a query aparece no título ou conteúdo, então a letra aparece nos resultados. |
| RF-05 | 🟢 O sistema deve ocultar letras excluídas. | Must | Dado uma letra com `is_deleted = 1`, quando a query combina com ela, então ela não aparece. |
| RF-06 | 🟢 O sistema deve ordenar resultados por título. | Should | Dado múltiplos resultados, quando a busca retorna, então a lista vem em `title ASC`. |
| RF-07 | 🟢 O sistema deve indicar visualmente a letra atualmente reproduzida. | Should | Dado que `AudioPlayerService.currentLyric.id` coincide com resultado, quando a lista renderiza, então o item usa estado visual de atual/reproduzindo. |
| RF-08 | 🟢 O sistema deve abrir a tela de visualização ao tocar em resultado. | Must | Dado um resultado, quando o usuário toca, então navega para `LyricViewScreen(lyric)`. |
| RF-09 | 🟢 O sistema deve permitir refresh com sincronização prévia. | Should | Dado uma query ativa, quando o usuário puxa para atualizar, então `syncData()` roda e a busca é refeita. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Operação offline | Busca deve funcionar com dados locais mesmo sem rede. | `lib/services/db_helper.dart`, `lib/services/sync_repository.dart` | 🟢 |
| Performance | Busca usa `LIKE '%query%'` sem índice dedicado; adequada para acervo pequeno/médio. | `lib/services/db_helper.dart` | 🟡 |
| Usabilidade | Exibir loading linear durante busca assíncrona. | `lib/screens/search_screen.dart` | 🟢 |
| Consistência | Refresh deve sincronizar antes de refazer a busca. | `lib/screens/search_screen.dart` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que existem letras locais com título contendo "Oxum"
Quando o usuário pesquisa por "Oxum"
Então as letras cujo título contém "Oxum" devem aparecer nos resultados

Dado que existem letras locais cujo conteúdo contém "beira mar"
Quando o usuário pesquisa por "beira mar"
Então as letras cujo conteúdo contém o trecho devem aparecer nos resultados

Dado que uma letra está marcada como excluída
Quando a busca combina com seu título ou conteúdo
Então a letra excluída não deve ser exibida

Dado que a query está vazia
Quando o usuário submete a busca
Então a lista de resultados deve ser limpa

Dado que há uma busca preenchida
Quando o usuário puxa a tela para atualizar
Então o sistema deve sincronizar dados e repetir a busca

Dado que há um resultado na lista
Quando o usuário toca nele
Então o sistema deve abrir a tela de visualização da letra
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Busca por título/conteúdo | Must | 🟢 Caminho crítico para localizar pontos no acervo. |
| Filtrar excluídos | Must | 🟢 Necessário para consistência com soft delete. |
| Navegar para detalhe | Must | 🟢 Resultado precisa permitir consumo da letra. |
| Limpar resultados com query vazia | Must | 🟢 Evita estado visual enganoso. |
| Refresh com sync | Should | 🟢 Importante para atualizar acervo, mas busca local ainda funciona sem refresh. |
| Indicador de reprodução atual | Should | 🟢 Melhora contexto de mídia, mas não é essencial para encontrar letras. |
| Busca remota direta | Won't | 🟢 O legado faz busca local via SQLite, não API remota. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/screens/search_screen.dart` | `SearchScreen`, `_SearchScreenState`, `_performSearch` | 🟢 |
| `lib/services/sync_repository.dart` | `searchLyrics` | 🟢 |
| `lib/services/db_helper.dart` | `searchLyrics` | 🟢 |
| `lib/models/lyric.dart` | `Lyric` | 🟢 |
| `lib/services/audio_player_service.dart` | `currentLyric`, `isPlaying` usados pela UI | 🟢 |
| `lib/screens/lyric_view_screen.dart` | destino de navegação do resultado | 🟢 |

