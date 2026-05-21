# Reprodução de Áudio — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre reprodução de áudio de letras/pontos, playlists, player compacto, notificação/control center via `audio_service` e estatísticas de reprodução.  
🟢 **CONFIRMADO** — O sistema usa `AudioPlayerService` como `ChangeNotifier` e `MyAudioHandler` como ponte com `audio_service` e `audioplayers`.  
🟢 **CONFIRMADO** — A reprodução prioriza arquivo local (`localAudioPath`) e usa URL remota (`audioUrl`) quando não há arquivo local.

## Responsabilidades

- 🟢 **CONFIRMADO** — Inicializar serviço de áudio antes de `runApp`.
- 🟢 **CONFIRMADO** — Registrar `AudioPlayerService` como provider global.
- 🟢 **CONFIRMADO** — Reproduzir uma única letra com áudio local ou remoto.
- 🟢 **CONFIRMADO** — Alternar pause/resume quando a mesma letra já é a atual.
- 🟢 **CONFIRMADO** — Montar e reproduzir playlists filtrando apenas letras com áudio.
- 🟢 **CONFIRMADO** — Avançar automaticamente para a próxima faixa quando uma faixa termina.
- 🟢 **CONFIRMADO** — Encerrar playlist ao terminar a última faixa quando repeat está desligado.
- 🟢 **CONFIRMADO** — Reiniciar playlist do começo quando repeat está ligado.
- 🟢 **CONFIRMADO** — Permitir próximo, anterior, pause/play, seek, repeat e stop.
- 🟢 **CONFIRMADO** — Expor estado de `currentLyric`, `isPlaying`, `duration`, `position`, playlist e índice atual para a UI.
- 🟢 **CONFIRMADO** — Renderizar player compacto quando há playlist ativa.
- 🟢 **CONFIRMADO** — Permitir expandir/ocultar painel com letra atual no player compacto.
- 🟢 **CONFIRMADO** — Permitir favoritar a letra atual pelo player compacto.
- 🟢 **CONFIRMADO** — Registrar estatística de reprodução quando uma letra começa a tocar.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Letra tem áudio se `audioUrl` ou `localAudioPath` está preenchido.
- 🟢 **CONFIRMADO** — `MyAudioHandler.playMediaItem` usa `DeviceFileSource(localPath)` quando `localPath` existe.
- 🟢 **CONFIRMADO** — Se não há `localPath`, usa `UrlSource(url)` quando `url` existe.
- 🟢 **CONFIRMADO** — Se não há fonte de áudio, o handler emite estado de erro e não toca.
- 🟢 **CONFIRMADO** — `AudioPlayerService.play(lyric)` troca a letra atual quando o ID é diferente.
- 🟢 **CONFIRMADO** — Tocar uma letra diferente cria `MediaItem` com `id`, `album`, `title`, `artist` e extras `url`/`localPath`.
- 🟢 **CONFIRMADO** — Tocar uma letra diferente chama `playMediaItem` e incrementa estatística de play.
- 🟢 **CONFIRMADO** — Tocar a mesma letra alterna pause/resume, sem incrementar estatística novamente nesse caminho.
- 🟢 **CONFIRMADO** — `playAll` ignora lista vazia.
- 🟢 **CONFIRMADO** — `playAll` filtra letras sem áudio antes de iniciar playlist.
- 🟢 **CONFIRMADO** — Se nenhuma letra da lista tem áudio, `playAll` retorna sem iniciar playlist.
- 🟢 **CONFIRMADO** — Playlist inicia em índice `0`.
- 🟢 **CONFIRMADO** — `skipPrevious` reinicia a faixa quando a posição atual é maior que 3 segundos.
- 🟢 **CONFIRMADO** — `skipPrevious` vai para faixa anterior quando posição é até 3 segundos e há faixa anterior.
- 🟢 **CONFIRMADO** — Se repeat está ligado, `skipNext` no fim volta para primeira faixa e `skipPrevious` no começo vai para última.
- 🟢 **CONFIRMADO** — `clearPlaylist` limpa fila, callbacks, estado atual, posição/duração e para o handler.
- 🟢 **CONFIRMADO** — O player compacto só aparece quando `audioService.hasPlaylist` é verdadeiro.
- 🟢 **CONFIRMADO** — Controles de notificação incluem anterior, play/pause, próximo e stop.
- 🟢 **CONFIRMADO** — `PlayStatsService.incrementPlayCount` tenta RPC `increment_play_count` e usa fallback manual se a RPC falhar.
- 🔴 **LACUNA** — A definição SQL da RPC `increment_play_count` não foi encontrada nos arquivos analisados.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve inicializar `AudioPlayerService` antes do app renderizar. | Must | Dado bootstrap do app, quando `main()` executa, então `AudioPlayerService.create()` conclui antes de `runApp`. |
| RF-02 | 🟢 O sistema deve expor áudio como provider global. | Must | Dado árvore do app, quando `MultiProvider` renderiza, então contém `ChangeNotifierProvider.value(value: audioService)`. |
| RF-03 | 🟢 O sistema deve tocar áudio local quando disponível. | Must | Dado `Lyric.localAudioPath` preenchido, quando `play(lyric)` executa, então `DeviceFileSource(localPath)` é usado. |
| RF-04 | 🟢 O sistema deve tocar áudio remoto quando local não existe. | Must | Dado `localAudioPath` vazio e `audioUrl` preenchido, quando toca, então `UrlSource(audioUrl)` é usado. |
| RF-05 | 🟢 O sistema deve emitir erro quando não há fonte de áudio. | Must | Dado `localPath` e `url` vazios, quando `playMediaItem` executa, então broadcast usa `AudioProcessingState.error`. |
| RF-06 | 🟢 O sistema deve alternar pause/resume para a mesma letra. | Must | Dado letra atual igual à letra solicitada, quando `play(lyric)` é chamado, então pausa se está tocando e retoma se está pausado. |
| RF-07 | 🟢 O sistema deve atualizar estado ao trocar de letra. | Must | Dado letra diferente da atual, quando `play(lyric)` é chamado, então `currentLyric` muda e listeners são notificados. |
| RF-08 | 🟢 O sistema deve registrar play count ao iniciar uma letra. | Should | Dado letra nova ou faixa de playlist iniciada, quando `playMediaItem` é chamado pelo service, então `incrementPlayCount(lyric.id)` é acionado. |
| RF-09 | 🟢 O sistema deve iniciar playlist apenas com letras que têm áudio. | Must | Dado lista com letras sem áudio, quando `playAll` executa, então somente letras com `audioUrl` ou `localAudioPath` entram na playlist. |
| RF-10 | 🟢 O sistema deve avançar automaticamente ao fim da faixa. | Must | Dado playlist com próxima faixa, quando player completa a faixa atual, então `skipNext()` toca a próxima. |
| RF-11 | 🟢 O sistema deve encerrar playlist ao fim sem repeat. | Must | Dado última faixa e repeat desligado, quando completa, então `clearPlaylist()` executa. |
| RF-12 | 🟢 O sistema deve repetir playlist quando repeat está ligado. | Should | Dado última faixa e repeat ligado, quando completa, então índice volta para `0` e toca a primeira faixa. |
| RF-13 | 🟢 O sistema deve permitir skip next e previous. | Must | Dado playlist ativa, quando usuário aciona próximo/anterior, então índice muda conforme limites e repeat. |
| RF-14 | 🟢 O sistema deve reiniciar faixa no previous após 3 segundos. | Should | Dado posição maior que 3 segundos, quando usuário aciona anterior, então `seek(Duration.zero)` executa. |
| RF-15 | 🟢 O sistema deve permitir seek. | Must | Dado áudio carregado, quando usuário move slider ou sistema action seek, então handler executa `_player.seek(position)`. |
| RF-16 | 🟢 O sistema deve exibir player compacto para playlist ativa. | Should | Dado `hasPlaylist == true`, quando telas com bottomSheet renderizam, então `CategoryPlayerWidget` aparece. |
| RF-17 | 🟢 O player compacto deve exibir progresso, título e posição na playlist. | Should | Dado playlist ativa, quando renderiza, então mostra barra de progresso, título atual, índice/total e tempo atual/duração. |
| RF-18 | 🟢 O player compacto deve permitir abrir painel de letra. | Should | Dado letra atual, quando usuário toca artigo, então painel expande/oculta com `currentLyric.content`. |
| RF-19 | 🟢 O player compacto deve permitir favoritar a letra atual. | Should | Dado `currentLyric != null`, quando usuário toca coração, então `FavoritesService.toggleFavorite(currentLyric.id)` executa. |
| RF-20 | 🟢 O sistema deve limpar playlist e notificação ao fechar. | Must | Dado playlist ativa, quando usuário toca fechar, então `clearPlaylist()` chama `stop()`, limpa estado e notifica listeners. |
| RF-21 | 🟢 O handler deve publicar estado para notificação/control center. | Must | Dado mudança de playback, quando `_broadcastState` executa, então `playbackState` contém controles e estado `playing/processingState`. |
| RF-22 | 🟢 O sistema deve cancelar subscriptions no dispose. | Should | Dado descarte de `AudioPlayerService`, quando `dispose()` executa, então cancela subscriptions e callbacks. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Operação offline | Áudio baixado localmente deve tocar sem rede. | Prioridade para `localAudioPath` | 🟢 |
| Resiliência | Falha ao tocar fonte deve emitir erro sem quebrar app. | `try/catch` em `playMediaItem` | 🟢 |
| Experiência contínua | Notificação Android deve permanecer em pausa. | `androidStopForegroundOnPause: false` | 🟢 |
| Integração nativa | Controles de notificação devem suportar seek/skip/repeat. | `AudioServiceConfig`, `playbackState.controls/systemActions` | 🟢 |
| Observabilidade UI | Estado de posição/duração/playback deve notificar consumidores. | Streams e `notifyListeners()` | 🟢 |
| Privacidade/Autorização | Reproduzir áudio não exige role específica. | Matriz de permissões | 🟢 |
| Estatísticas | Falha de estatística não deve interromper playback. | Fallback/log em `PlayStatsService` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que uma letra possui localAudioPath
Quando o usuário toca a letra
Então o player deve usar o arquivo local como fonte de áudio

Dado que uma letra não possui localAudioPath mas possui audioUrl
Quando o usuário toca a letra
Então o player deve usar a URL remota como fonte de áudio

Dado que uma letra não possui fonte de áudio
Quando o handler tenta reproduzir
Então o estado de playback deve indicar erro

Dado que uma playlist contém letras com e sem áudio
Quando o usuário aciona tocar todas
Então a playlist deve conter somente letras com áudio

Dado que uma playlist está tocando e a faixa termina
Quando existe próxima faixa
Então o sistema deve tocar a próxima automaticamente

Dado que uma playlist está na última faixa com repeat desligado
Quando a faixa termina
Então o sistema deve limpar a playlist e parar a notificação

Dado que uma playlist está na última faixa com repeat ligado
Quando a faixa termina
Então o sistema deve voltar para a primeira faixa

Dado que a posição da faixa é maior que 3 segundos
Quando o usuário toca anterior
Então o sistema deve reiniciar a faixa atual

Dado que uma faixa começa a tocar
Quando `AudioPlayerService` inicia a reprodução
Então o contador remoto de plays deve ser incrementado ou tentar fallback
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Tocar áudio local/remoto | Must | 🟢 Núcleo da feature de áudio. |
| Pause/resume/seek | Must | 🟢 Controles básicos de reprodução. |
| Playlist filtrada por áudio | Must | 🟢 Evita tentar tocar letras sem fonte. |
| Auto-next e clear no fim | Must | 🟢 Comportamento esperado de playlist. |
| Notificação/control center | Must | 🟢 Serviço foi construído em cima de `audio_service`. |
| Player compacto | Should | 🟢 UX importante em listas, mas reprodução funciona sem ele. |
| Repeat | Should | 🟢 Conveniência de playback. |
| Favorito no player compacto | Should | 🟢 Integração útil, mas pertence também à unit Favoritos. |
| Estatísticas de play | Should | 🟢 Valor de ranking, mas falha não pode bloquear áudio. |
| Tocar letras sem áudio | Won't | 🟢 Filtrado/erro conforme fonte ausente. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/audio_player_service.dart` | `AudioPlayerService`, `create`, `play`, `playAll`, `skipNext`, `skipPrevious`, `toggleRepeat`, `clearPlaylist`, `togglePlayPause` | 🟢 |
| `lib/services/audio_player_service.dart` | `MyAudioHandler`, `playMediaItem`, `play`, `pause`, `seek`, `stop`, `skipToNext`, `skipToPrevious`, `setRepeatMode` | 🟢 |
| `lib/widgets/category_player_widget.dart` | `CategoryPlayerWidget`, `_showLyrics`, controles compactos | 🟢 |
| `lib/services/play_stats_service.dart` | `incrementPlayCount`, `_incrementPlayCountFallback` | 🟢 |
| `lib/models/lyric.dart` | `audioUrl`, `localAudioPath`, `title`, `content` | 🟢 |
| `lib/screens/lyric_view_screen.dart` | `_togglePlay`, controles de áudio no detalhe | 🟢 |
| `lib/screens/category_screen.dart` | `playAll`, `play` por item, `CategoryPlayerWidget` | 🟢 |
| `lib/screens/favorites_screen.dart` | `playAll`, `play` por item, `CategoryPlayerWidget` | 🟢 |
| `lib/screens/top_played_screen.dart` | `playAll`, `play` por item, `CategoryPlayerWidget` | 🟢 |
| `lib/main.dart` | `AudioPlayerService.create`, provider global | 🟢 |

