# Visualização de Letra — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Modelo `Lyric` implementado com campos de texto, categoria, mídia e sequência.
- [ ] 🟢 Modelo `Category` implementado com `id`, `name` e `code`.
- [ ] 🟢 `SyncRepository` expõe `getCategory`, `getLyric`, `syncData` e `deleteLyric`.
- [ ] 🟢 `AudioPlayerService` expõe `play`, `togglePlayPause`, `seek`, `currentLyric`, `isPlaying`, `duration` e `position`.
- [ ] 🟢 `FavoritesService` disponível no provider raiz.
- [ ] 🟢 `AuthService` disponível no provider raiz com `canEditLyrics` e `canDeleteLyrics`.
- [ ] 🟢 Dependência `youtube_player_flutter` disponível.

## Tarefas

- [ ] T-01, Implementar tela `LyricViewScreen`
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: tela recebe `Lyric lyric` obrigatório no construtor e inicializa `_lyric = widget.lyric` em `initState`.
  - Confiança: 🟢

- [ ] T-02, Implementar estado local da tela
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: estado contém `_lyric`, `_category`, `_youtubeController` e `_playerMode` com enum `none`, `audio`, `video`.
  - Confiança: 🟢

- [ ] T-03, Carregar categoria associada
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: `_loadCategory()` chama `SyncRepository.getCategory(_lyric.categoryId)` e atualiza `_category` quando a categoria existe e a tela ainda está montada.
  - Confiança: 🟢

- [ ] T-04, Implementar título com referência de categoria
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: AppBar usa `{category.code}{sequenceNumber.padLeft(2)} - {title.toUpperCase()}` quando há código; caso contrário usa apenas `title.toUpperCase()`.
  - Confiança: 🟢

- [ ] T-05, Implementar layout textual da letra
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: corpo usa `SingleChildScrollView`, largura máxima de 600 e exibe `_lyric.content` em painel legível.
  - Confiança: 🟢

- [ ] T-06, Implementar detecção de áudio disponível
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/models/lyric.dart`
  - Critério de pronto: `hasAudio` é verdadeiro quando `audioUrl` ou `localAudioPath` está preenchido após `trim`.
  - Confiança: 🟢

- [ ] T-07, Implementar inicialização do player YouTube
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `_initYoutubePlayer()` converte `youtubeLink` via `YoutubePlayer.convertUrlToId` e cria `YoutubePlayerController` com `autoPlay=false`, `mute=false`, `enableCaption=true` quando o ID é válido.
  - Confiança: 🟢

- [ ] T-08, Implementar dispose do YouTube controller
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `dispose()` chama `_youtubeController?.dispose()` antes de `super.dispose()`.
  - Confiança: 🟢

- [ ] T-09, Implementar card de mídia
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: quando há áudio ou vídeo válido, tela mostra botões `Áudio` e `Vídeo`, desabilitando cada botão quando a mídia correspondente não existe.
  - Confiança: 🟢

- [ ] T-10, Implementar estado sem mídia
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: quando não há áudio nem vídeo válido, tela mostra mensagem orientando adicionar MP3 ou link YouTube.
  - Confiança: 🟢

- [ ] T-11, Implementar seleção de modo áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: ao tocar `Áudio`, o YouTube pausa e `_playerMode` passa para `audio`.
  - Confiança: 🟢

- [ ] T-12, Implementar seleção de modo vídeo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: ao tocar `Vídeo`, áudio em reprodução é pausado via `togglePlayPause()` e `_playerMode` passa para `video`.
  - Confiança: 🟢

- [ ] T-13, Implementar fechamento do player ativo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: botão fechar pausa áudio da letra atual ou vídeo ativo e define `_playerMode = none`.
  - Confiança: 🟢

- [ ] T-14, Implementar reprodução de áudio da letra
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: `_togglePlay()` não faz nada sem áudio e chama `AudioPlayerService.play(_lyric)` quando há áudio.
  - Confiança: 🟢

- [ ] T-15, Implementar controles de áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: modo áudio mostra botão play/pause, slider, posição e duração formatadas em `mm:ss`; slider chama `seek` apenas quando `currentLyric.id == _lyric.id`.
  - Confiança: 🟢

- [ ] T-16, Implementar botão de favorito no modo áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/favorites_service.dart`
  - Critério de pronto: modo áudio consome `FavoritesService`, mostra coração preenchido/contornado, alterna favorito e exibe snackbar conforme estado anterior.
  - Confiança: 🟢

- [ ] T-17, Implementar renderização do player YouTube
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: modo vídeo com controller válido renderiza `YoutubePlayer` com progress indicator, progress bar, posição, duração restante, playback speed e fullscreen.
  - Confiança: 🟢

- [ ] T-18, Implementar refresh manual
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: `RefreshIndicator` executa `syncData()`, busca `getLyric(_lyric.id)` e atualiza a tela quando a letra ainda existe.
  - Confiança: 🟢

- [ ] T-19, Implementar reinicialização de mídia após reload
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: após refresh ou edição, controller YouTube antigo é descartado, novo controller é criado quando aplicável e `_playerMode` volta para `none` se a mídia ativa deixou de existir.
  - Confiança: 🟢

- [ ] T-20, Implementar ação de edição protegida
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/screens/lyric_form_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: AppBar mostra botão editar quando `canEditLyrics` é verdadeiro e abre `LyricFormScreen(categoryId: _lyric.categoryId, lyric: _lyric)`.
  - Confiança: 🟢

- [ ] T-21, Implementar comportamento pós-edição
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: se retorno da edição é `true`, fecha `LyricViewScreen`; caso contrário, recarrega a letra local por ID e reinicializa mídia.
  - Confiança: 🟢

- [ ] T-22, Implementar ação de exclusão protegida
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: AppBar mostra botão excluir quando `canDeleteLyrics` é verdadeiro, abre dialog de confirmação e chama `SyncRepository.deleteLyric(_lyric.id)` ao confirmar.
  - Confiança: 🟢

- [ ] T-23, Implementar fechamento e feedback após exclusão
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: após excluir, tela fecha e tenta exibir snackbar de sucesso quando a letra não é mais encontrada localmente.
  - Confiança: 🟢

- [ ] T-24, Definir tratamento moderno para falhas de refresh/delete
  - Origem no legado: lacuna em `_reversa_sdd/visualizacao-letra/design.md`
  - Critério de pronto: decidir e implementar feedback quando `syncData`, `getLyric` ou `deleteLyric` falham.
  - Confiança: 🟡

## Tarefas de Teste

- [ ] TT-01, Testar título com categoria carregada
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: categoria com `code="OX"` e `sequenceNumber=1` gera título contendo `OX01 -`.
  - Confiança: 🟢

- [ ] TT-02, Testar fallback de título sem categoria
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: quando categoria não existe ou `code` está vazio, AppBar exibe apenas `title.toUpperCase()`.
  - Confiança: 🟢

- [ ] TT-03, Testar renderização de conteúdo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `lyric.content` aparece integralmente no corpo da tela.
  - Confiança: 🟢

- [ ] TT-04, Testar estado sem mídia
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: letra sem `audioUrl`, `localAudioPath` e YouTube válido exibe aviso "Sem mídia para tocar".
  - Confiança: 🟢

- [ ] TT-05, Testar habilitação do botão áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: letra com `audioUrl` ou `localAudioPath` habilita botão `Áudio`.
  - Confiança: 🟢

- [ ] TT-06, Testar YouTube válido
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `youtubeLink` válido habilita botão `Vídeo` e renderiza player ao selecionar vídeo.
  - Confiança: 🟢

- [ ] TT-07, Testar YouTube inválido
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: `youtubeLink` inválido não cria controller e não habilita reprodução de vídeo.
  - Confiança: 🟢

- [ ] TT-08, Testar pausa cruzada ao selecionar áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: ao selecionar `Áudio`, controller YouTube ativo recebe pause.
  - Confiança: 🟢

- [ ] TT-09, Testar pausa cruzada ao selecionar vídeo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: com áudio tocando, selecionar `Vídeo` chama `togglePlayPause`.
  - Confiança: 🟢

- [ ] TT-10, Testar play e seek de áudio
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/audio_player_service.dart`
  - Critério de pronto: botão play chama `play(_lyric)` e slider chama `seek` quando a letra atual coincide.
  - Confiança: 🟢

- [ ] TT-11, Testar favorito na visualização
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/favorites_service.dart`
  - Critério de pronto: tocar coração alterna favorito e exibe snackbar correto.
  - Confiança: 🟢

- [ ] TT-12, Testar refresh com letra existente
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: pull-to-refresh chama `syncData`, recarrega `getLyric(id)` e atualiza conteúdo/mídia.
  - Confiança: 🟢

- [ ] TT-13, Testar ajuste de modo após mídia removida
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: se modo atual é áudio/vídeo e a letra recarregada não tem mais essa mídia, `_playerMode` volta para `none`.
  - Confiança: 🟢

- [ ] TT-14, Testar gates de edição
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: `moderator` e `admin` veem editar; anônimo/user não veem.
  - Confiança: 🟢

- [ ] TT-15, Testar gates de exclusão
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: apenas `admin` vê excluir.
  - Confiança: 🟢

- [ ] TT-16, Testar confirmação de exclusão
  - Origem no legado: `lib/screens/lyric_view_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: confirmar dialog chama `deleteLyric(_lyric.id)`; cancelar não chama.
  - Confiança: 🟢

- [ ] TT-17, Testar dispose de YouTube controller
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: ao descartar a tela, controller criado é descartado.
  - Confiança: 🟢

## Tarefas de Migração de Dados

Não há migração específica para visualização de letra. 🟢 A unit depende dos campos já existentes em `lyrics` e `categories`.

## Ordem Sugerida

1. Implementar `LyricViewScreen` com estado local, título e conteúdo textual.
2. Integrar `SyncRepository.getCategory` e fallback de título.
3. Implementar detecção de áudio/vídeo e layout com/sem mídia.
4. Implementar `_PlayerMode` e pausas cruzadas.
5. Integrar `AudioPlayerService` e `YoutubePlayerController`.
6. Integrar `FavoritesService` no modo áudio.
7. Implementar refresh/reload e reinicialização de mídia.
8. Implementar gates de edição/exclusão e navegação para formulário.
9. Adicionar testes de widget/service mocks para mídia, refresh e RBAC.
10. Decidir melhorias modernas para falhas de refresh/delete.

## Lacunas Pendentes (🔴)

- 🟡 Falhas em refresh, carregamento de categoria e delete não possuem feedback explícito.
- 🟡 Se a letra desaparece durante refresh, o legado mantém a tela com estado antigo.
- 🟡 A ação de exclusão tenta mostrar snackbar após `Navigator.pop`, exigindo cuidado de contexto em reimplementação.

