# Busca — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Modelo `Lyric` implementado e compatível com SQLite.
- [ ] 🟢 Tabela local `lyrics` contém `title`, `content` e `is_deleted`.
- [ ] 🟢 `SyncRepository` expõe consulta local de letras.
- [ ] 🟢 Tela de visualização de letra disponível para navegação.

## Tarefas

- [ ] T-01, Implementar método local de busca no DAO
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: `searchLyrics(query)` consulta `lyrics` com `(title LIKE ? OR content LIKE ?) AND is_deleted = 0`, argumentos `%query%` e ordenação `title ASC`.
  - Confiança: 🟢

- [ ] T-02, Implementar proxy de busca no repository
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: `SyncRepository.searchLyrics(query)` delega para o DAO local e retorna `Future<List<Lyric>>`.
  - Confiança: 🟢

- [ ] T-03, Implementar tela `SearchScreen`
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: tela possui `TextEditingController`, `_results`, `_isLoading`, `TextField` com label "Pesquisar por nome ou trecho" e lista de resultados.
  - Confiança: 🟢

- [ ] T-04, Implementar submissão de busca
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: ao submeter query não vazia, `_performSearch()` ativa loading, chama repository, salva resultados e desativa loading.
  - Confiança: 🟢

- [ ] T-05, Implementar limpeza de resultados para query vazia
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: ao submeter query vazia, `_results` vira lista vazia e loading é encerrado.
  - Confiança: 🟢

- [ ] T-06, Implementar renderização de resultado
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: cada item exibe título capitalizado, trecho de conteúdo com uma linha, ícone e chevron.
  - Confiança: 🟢

- [ ] T-07, Implementar destaque do item em reprodução
  - Origem no legado: `lib/screens/search_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: se `currentLyric.id` coincide com o resultado, o item usa estilo visual de item atual/reproduzindo.
  - Confiança: 🟢

- [ ] T-08, Implementar navegação para visualização
  - Origem no legado: `lib/screens/search_screen.dart`, `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: toque em resultado executa `Navigator.push` para `LyricViewScreen(lyric: lyric)`.
  - Confiança: 🟢

- [ ] T-09, Implementar refresh com sync
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: `RefreshIndicator` chama `syncData()` e refaz busca se o campo não está vazio.
  - Confiança: 🟢

- [ ] T-10, Definir estado vazio para busca sem resultados
  - Origem no legado: lacuna em `_reversa_sdd/busca/design.md`
  - Critério de pronto: UX moderna decide e implementa mensagem ou estado visual para zero resultados.
  - Confiança: 🔴

- [ ] T-11, Definir tratamento de erro da busca
  - Origem no legado: lacuna em `_reversa_sdd/busca/design.md`
  - Critério de pronto: falhas do DAO/repository são capturadas e exibidas sem quebrar a tela.
  - Confiança: 🔴

## Tarefas de Teste

- [ ] TT-01, Testar busca por título
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: query presente em `title` retorna a letra esperada.
  - Confiança: 🟢

- [ ] TT-02, Testar busca por conteúdo
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: query presente em `content` retorna a letra esperada.
  - Confiança: 🟢

- [ ] TT-03, Testar filtro de excluídos
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: letra com `is_deleted = 1` não aparece mesmo quando combina com a query.
  - Confiança: 🟢

- [ ] TT-04, Testar query vazia
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: submissão de query vazia limpa resultados sem chamar repository.
  - Confiança: 🟢

- [ ] TT-05, Testar navegação para detalhe
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: toque em resultado abre `LyricViewScreen` com a letra correta.
  - Confiança: 🟢

- [ ] TT-06, Testar refresh
  - Origem no legado: `lib/screens/search_screen.dart`
  - Critério de pronto: pull-to-refresh chama `syncData()` e refaz busca quando há query.
  - Confiança: 🟢

- [ ] TT-07, Testar estado visual de reprodução
  - Origem no legado: `lib/screens/search_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: item atual muda estilo quando `AudioPlayerService.currentLyric` corresponde ao resultado.
  - Confiança: 🟢

## Tarefas de Migração de Dados

Não há migração específica para busca. 🟢 A unit depende apenas dos campos já existentes em `lyrics`.

## Ordem Sugerida

1. Implementar `Lyric` e `DatabaseHelper.searchLyrics`.
2. Implementar `SyncRepository.searchLyrics`.
3. Implementar `SearchScreen` com campo, loading, lista e navegação.
4. Adicionar refresh com sync.
5. Adicionar testes de DAO e widget.
6. Decidir melhorias modernas: estado vazio e tratamento de erro.

## Lacunas Pendentes (🔴)

- 🔴 Estado vazio para nenhum resultado não existe no legado.
- 🔴 Tratamento explícito de erro de busca não existe no legado.
- 🟡 Normalização de acentos/maiúsculas não é especificada.

