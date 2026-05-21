# Favoritos — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 `Lyric` implementado com `id`, `title`, `categoryId`, `audioUrl` e `localAudioPath`.
- [ ] 🟢 `SyncRepository` expõe leitura local de letras e categorias.
- [ ] 🟢 `AudioPlayerService` disponível para tocar uma letra ou uma playlist.
- [ ] 🟢 `SharedPreferences` disponível para persistência local de preferências.
- [ ] 🟢 `Provider`/`ChangeNotifier` disponível na árvore principal do app.

## Tarefas

- [ ] T-01, Implementar `FavoritesService`
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: serviço estende `ChangeNotifier`, mantém `Set<String> _favorites`, expõe `favorites`, `count`, `isLoaded`, `isFavorite`, `toggleFavorite`, `addFavorite`, `removeFavorite` e `clearAll`.
  - Confiança: 🟢

- [ ] T-02, Implementar carregamento local de favoritos
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: construtor chama `_loadFavorites()`, lê `SharedPreferences.getStringList('favorite_lyrics')`, popula `_favorites`, define `_isLoaded = true` e chama `notifyListeners()`.
  - Confiança: 🟢

- [ ] T-03, Implementar persistência local de favoritos
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: `_saveFavorites()` grava `_favorites.toList()` em `SharedPreferences.setStringList('favorite_lyrics', ...)` e captura falhas sem derrubar a UI.
  - Confiança: 🟢

- [ ] T-04, Implementar alternância de favorito
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: `toggleFavorite(lyricId)` remove se já existir, adiciona se não existir, notifica listeners e salva a lista local.
  - Confiança: 🟢

- [ ] T-05, Registrar `FavoritesService` no provider raiz
  - Origem no legado: `lib/main.dart`
  - Critério de pronto: `MultiProvider` inclui `ChangeNotifierProvider(create: (_) => FavoritesService())`.
  - Confiança: 🟢

- [ ] T-06, Implementar botão de favorito na visualização da letra
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `LyricViewScreen` consome `FavoritesService`, renderiza coração preenchido/contornado conforme `isFavorite(_lyric.id)` e alterna estado ao tocar.
  - Confiança: 🟢

- [ ] T-07, Implementar feedback de favorito na visualização
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: após alternar favorito, snackbar informa "Adicionado aos favoritos" ou "Removido dos favoritos" de acordo com o estado anterior.
  - Confiança: 🟢

- [ ] T-08, Implementar botão de favorito no player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: quando há `currentLyric`, o player mostra botão de coração conectado a `FavoritesService.toggleFavorite(currentLyric.id)`.
  - Confiança: 🟢

- [ ] T-09, Implementar tela `FavoritesScreen`
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: tela possui AppBar "Gostei", consome `FavoritesService` e `SyncRepository`, renderiza loading, estado vazio, estado não encontrado ou lista de favoritos.
  - Confiança: 🟢

- [ ] T-10, Implementar resolução de favoritos com categoria
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: `_getFavoriteLyricsWithCategory(favoriteIds, repo)` carrega categorias, monta mapa por ID, busca cada letra por `repo.getLyric(id)`, ignora nulos e retorna `LyricWithCategory`.
  - Confiança: 🟢

- [ ] T-11, Implementar ordenação de favoritos por título
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: lista resolvida e playlist de favoritos são ordenadas por `lyric.title.compareTo`.
  - Confiança: 🟢

- [ ] T-12, Implementar renderização de item favorito
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: item exibe número sequencial, título capitalizado, referência `categoryCode + sequenceNumber`, nome da categoria, botão de remover favorito e play opcional.
  - Confiança: 🟢

- [ ] T-13, Implementar remoção pela tela "Gostei"
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: botão de coração preenchido chama `favoritesService.toggleFavorite(lyric.id)` e exibe snackbar "Removido dos favoritos".
  - Confiança: 🟢

- [ ] T-14, Implementar navegação do favorito para detalhe
  - Origem no legado: `lib/screens/favorites_screen.dart`, `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: toque no item navega para `LyricViewScreen(lyric: lyric)`.
  - Confiança: 🟢

- [ ] T-15, Implementar ação "Tocar Todas"
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: AppBar mostra botão de play quando há favoritos; ação resolve letras existentes, ordena por título e chama `AudioPlayerService.playAll(favoriteLyrics)`.
  - Confiança: 🟢

- [ ] T-16, Implementar estados vazios e de órfãos
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: tela mostra mensagem de nenhum favorito quando o conjunto está vazio e mensagem de músicas não encontradas quando os IDs não resolvem para letras locais.
  - Confiança: 🟢

- [ ] T-17, Implementar destaque de reprodução na lista
  - Origem no legado: `lib/screens/favorites_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: item da letra atual muda borda/cor e alterna ícone de play/pause conforme `currentLyric` e `isPlaying`.
  - Confiança: 🟢

- [ ] T-18, Implementar navegação para favoritos na Home
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: comando visual de favoritos abre `FavoritesScreen` via `Navigator.push`.
  - Confiança: 🟢

- [ ] T-19, Definir estratégia moderna para falha de escrita em preferências
  - Origem no legado: lacuna em `_reversa_sdd/favoritos/design.md`
  - Critério de pronto: decidir se falha em `_saveFavorites()` permanece apenas em log ou se deve reverter estado/mostrar feedback.
  - Confiança: 🟡

## Tarefas de Teste

- [ ] TT-01, Testar carga inicial de favoritos
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: dado `favorite_lyrics` com IDs, ao criar o serviço, `favorites` contém os IDs e `isLoaded` vira verdadeiro.
  - Confiança: 🟢

- [ ] TT-02, Testar carga inicial com erro
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: dado erro em `SharedPreferences`, serviço não lança exceção, marca `isLoaded` verdadeiro e notifica listeners.
  - Confiança: 🟢

- [ ] TT-03, Testar `toggleFavorite`
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: alternar ID ausente adiciona e alternar ID presente remove, salvando em `favorite_lyrics`.
  - Confiança: 🟢

- [ ] TT-04, Testar imutabilidade do getter `favorites`
  - Origem no legado: `lib/services/favorites_service.dart`
  - Critério de pronto: consumidor externo não consegue modificar diretamente o conjunto interno.
  - Confiança: 🟢

- [ ] TT-05, Testar botão de favorito na visualização
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: ícone muda entre coração preenchido e contornado conforme `FavoritesService`.
  - Confiança: 🟢

- [ ] TT-06, Testar tela "Gostei" vazia
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: sem favoritos, tela exibe estado vazio e não exibe botão "Tocar Todas".
  - Confiança: 🟢

- [ ] TT-07, Testar montagem da lista de favoritos
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: IDs válidos são resolvidos via repository, enriquecidos com categoria e ordenados por título.
  - Confiança: 🟢

- [ ] TT-08, Testar IDs órfãos
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: IDs sem letra correspondente são ignorados e não quebram a renderização.
  - Confiança: 🟢

- [ ] TT-09, Testar remoção pela lista
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: tocar no coração de item favorito remove o ID e exibe snackbar de remoção.
  - Confiança: 🟢

- [ ] TT-10, Testar navegação para detalhe
  - Origem no legado: `lib/screens/favorites_screen.dart`
  - Critério de pronto: toque no item abre `LyricViewScreen` com a letra correta.
  - Confiança: 🟢

- [ ] TT-11, Testar "Tocar Todas"
  - Origem no legado: `lib/screens/favorites_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: ação resolve letras favoritas existentes, ordena por título e chama `playAll` com a coleção correta.
  - Confiança: 🟢

- [ ] TT-12, Testar botão do player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: com `currentLyric`, botão de coração reflete e alterna favorito sem navegar.
  - Confiança: 🟢

## Tarefas de Migração de Dados

Não há migração de banco para favoritos. 🟢 A unit usa somente `SharedPreferences.favorite_lyrics`.

## Ordem Sugerida

1. Implementar `FavoritesService` e testes unitários de estado/persistência.
2. Registrar provider raiz.
3. Integrar botão de favorito na visualização de letra.
4. Integrar botão de favorito no player compacto.
5. Implementar `FavoritesScreen` com loading, vazio, órfãos e lista.
6. Implementar remoção, navegação e `Tocar Todas`.
7. Adicionar testes de widget para estados principais.
8. Decidir tratamento moderno para falha de escrita em preferências.

## Lacunas Pendentes (🔴)

- 🟡 Não há feedback ao usuário quando `_saveFavorites()` falha.
- 🟡 Não há limpeza persistente automática de IDs órfãos em `favorite_lyrics`.
- 🟡 A resolução de favoritos executa leituras sequenciais por ID; pode exigir otimização se o acervo crescer muito.

