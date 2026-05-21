# Reprodução de Áudio — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Modelo `Lyric` com `id`, `title`, `content`, `audioUrl` e `localAudioPath`.
- [ ] 🟢 Dependências `audioplayers`, `audio_service` e `provider` configuradas no projeto.
- [ ] 🟢 Permissões Android/iOS para reprodução em background e notificação de mídia (se aplicável à plataforma).
- [ ] 🟢 `PlayStatsService` e tabela/remota `lyric_play_stats` disponíveis (ou fallback documentado).
- [ ] 🟢 `FavoritesService` disponível para integração opcional no player compacto.
- [ ] 🟢 `SyncRepository` nas telas que montam listas para `playAll`.

## Tarefas

- [ ] T-01, Implementar `MyAudioHandler` com `AudioPlayer` interno
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: classe estende `BaseAudioHandler` com `QueueHandler` e `SeekHandler`, expõe `durationStream` e `positionStream`, e inicializa contexto de áudio Android/iOS.
  - Confiança: 🟢

- [ ] T-02, Implementar broadcast de estado para notificação
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `_broadcastState` publica `playbackState` com controles previous/play-pause/next/stop, `systemActions` de seek/skip/repeat e `updatePosition` sincronizado.
  - Confiança: 🟢

- [ ] T-03, Implementar `playMediaItem` com prioridade local/remota
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: método para player, usa `DeviceFileSource` quando `localPath` preenchido, `UrlSource` quando só `url` existe, emite `AudioProcessingState.error` sem fonte e trata exceções com broadcast de erro.
  - Confiança: 🟢

- [ ] T-04, Implementar `play`, `pause`, `seek` e `stop` no handler
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `pause` e `seek` delegam ao player; `stop` limpa `mediaItem` e volta a `idle`; `play` recarrega mídia quando estado é `stopped` ou `completed`.
  - Confiança: 🟢

- [ ] T-05, Implementar callbacks de playlist no handler
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `onPlayerComplete` chama `onTrackComplete`; `skipToNext`/`skipToPrevious` delegam a callbacks; `setRepeatMode` alterna modo e chama `onToggleRepeat`.
  - Confiança: 🟢

- [ ] T-06, Implementar factory `AudioPlayerService.create`
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `AudioService.init` usa `MyAudioHandler`, configura canal `com.fmapontos.channel.audio`, `androidStopForegroundOnPause: false` e retorna instância pronta.
  - Confiança: 🟢

- [ ] T-07, Implementar listeners de estado no service
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: service escuta `durationStream`, `positionStream`, `playbackState` e `mediaItem`, atualizando `_duration`, `_position`, `_isPlaying` e notificando UI.
  - Confiança: 🟢

- [ ] T-08, Implementar `play(Lyric)` com toggle na mesma faixa
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: faixa diferente monta `MediaItem`, chama `playMediaItem` e `incrementPlayCount`; mesma faixa alterna pause/resume sem novo incremento.
  - Confiança: 🟢

- [ ] T-09, Implementar `playAll` com filtro de letras com áudio
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: ignora lista vazia, filtra por `audioUrl` ou `localAudioPath`, retorna se nenhuma letra válida, define `_playlist`/`_currentIndex = 0`, registra callbacks e chama `_playCurrentTrack`.
  - Confiança: 🟢

- [ ] T-10, Implementar auto-avanço e encerramento de playlist
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `_onTrackComplete` chama `skipNext` se há próxima faixa, reinicia do índice 0 com repeat ligado, ou `clearPlaylist` na última faixa sem repeat.
  - Confiança: 🟢

- [ ] T-11, Implementar `skipNext` e `skipPrevious`
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: `skipNext` avança ou faz loop com repeat; `skipPrevious` reinicia faixa após 3s de posição, volta faixa anterior ou loop para última com repeat.
  - Confiança: 🟢

- [ ] T-12, Implementar `toggleRepeat`, `togglePlayPause` e `clearPlaylist`
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: repeat alterna flag e notifica; clear remove callbacks, chama `stop`, zera playlist, letra atual, posição/duração e estado playing.
  - Confiança: 🟢

- [ ] T-13, Implementar `dispose` com cancelamento de subscriptions
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: cancela todas as subscriptions e limpa callbacks do handler sem vazamento.
  - Confiança: 🟢

- [ ] T-14, Inicializar áudio antes de `runApp`
  - Origem no legado: `lib/main.dart`
  - Critério de pronto: `main()` aguarda `AudioPlayerService.create()` e injeta instância em `MyApp`.
  - Confiança: 🟢

- [ ] T-15, Registrar provider global de áudio
  - Origem no legado: `lib/main.dart`
  - Critério de pronto: `MultiProvider` inclui `ChangeNotifierProvider.value(value: audioService)`.
  - Confiança: 🟢

- [ ] T-16, Implementar `PlayStatsService.incrementPlayCount`
  - Origem no legado: `lib/services/play_stats_service.dart`
  - Critério de pronto: tenta RPC `increment_play_count` com `p_lyric_id`; em falha executa fallback select/update/insert em `lyric_play_stats` sem propagar erro ao player.
  - Confiança: 🟢

- [ ] T-17, Integrar estatísticas no início de reprodução
  - Origem no legado: `lib/services/audio_player_service.dart`, `lib/services/play_stats_service.dart`
  - Critério de pronto: `play()` e `_playCurrentTrack()` chamam `incrementPlayCount` ao iniciar faixa nova; toggle na mesma faixa não incrementa.
  - Confiança: 🟢

- [ ] T-18, Implementar `CategoryPlayerWidget`
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: widget só renderiza quando `hasPlaylist`; exibe progresso, título, índice/total, tempos, controles repeat/previous/play-pause/next e botão fechar.
  - Confiança: 🟢

- [ ] T-19, Implementar painel expansível de letra no player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: botão artigo alterna painel até 65% da altura da tela com `currentLyric.content` scrollável.
  - Confiança: 🟢

- [ ] T-20, Integrar favorito no player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: com `currentLyric`, botão coração usa `FavoritesService.toggleFavorite` e reflete `isFavorite`.
  - Confiança: 🟢

- [ ] T-21, Integrar player compacto nas telas de lista
  - Origem no legado: `lib/screens/category_screen.dart`, `lib/screens/favorites_screen.dart`, `lib/screens/top_played_screen.dart`
  - Critério de pronto: telas usam `bottomSheet: CategoryPlayerWidget()` e ações `playAll`/`play` por item.
  - Confiança: 🟢

- [ ] T-22, Implementar controles de áudio em `LyricViewScreen`
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: tela verifica presença de áudio, chama `play(_lyric)`, mostra play/pause/seek quando letra é a atual e respeita exclusão com modo vídeo.
  - Confiança: 🟢

- [ ] T-23, Configurar manifest Android para serviço de áudio
  - Origem no legado: `android/app/src/main/AndroidManifest.xml`
  - Critério de pronto: permissões e service/receiver exigidos por `audio_service` estão declarados conforme documentação da versão usada.
  - Confiança: 🟡

- [ ] T-24, Validar contrato RPC `increment_play_count` no Supabase
  - Origem no legado: lacuna em `_reversa_sdd/reproducao-audio/design.md`
  - Critério de pronto: função SQL versionada no repo ou migration documentada; parâmetro `p_lyric_id` e upsert em `lyric_play_stats` confirmados.
  - Confiança: 🔴

## Tarefas de Teste

- [ ] TT-01, Testar reprodução com arquivo local
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: dado `localAudioPath` válido, `playMediaItem` usa `DeviceFileSource` e estado passa para `ready`/`playing`.
  - Confiança: 🟢

- [ ] TT-02, Testar reprodução com URL remota
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: sem local e com `audioUrl`, player usa `UrlSource` e inicia reprodução.
  - Confiança: 🟢

- [ ] TT-03, Testar ausência de fonte de áudio
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: sem `localPath` e sem `url`, handler emite `AudioProcessingState.error` e não toca.
  - Confiança: 🟢

- [ ] TT-04, Testar toggle na mesma letra
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: segundo `play` na mesma letra pausa se tocando e retoma se pausado, sem segundo incremento de estatística.
  - Confiança: 🟢

- [ ] TT-05, Testar `playAll` com filtro
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: lista mista resulta em playlist só com letras com áudio; lista sem áudio não inicia reprodução.
  - Confiança: 🟢

- [ ] TT-06, Testar auto-avanço ao fim da faixa
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: com próxima faixa na playlist, completion chama `skipNext` e toca faixa seguinte.
  - Confiança: 🟢

- [ ] TT-07, Testar encerramento de playlist sem repeat
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: última faixa completa com repeat desligado executa `clearPlaylist` e oculta player compacto.
  - Confiança: 🟢

- [ ] TT-08, Testar repeat de playlist
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: última faixa com repeat ligado volta ao índice 0; `skipNext` no fim e `skipPrevious` no início fazem loop.
  - Confiança: 🟢

- [ ] TT-09, Testar regra dos 3 segundos no anterior
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: posição > 3s reinicia faixa; posição ≤ 3s volta faixa anterior quando existir.
  - Confiança: 🟢

- [ ] TT-10, Testar resume após stop
  - Origem no legado: `lib/services/audio_player_service.dart`
  - Critério de pronto: após `stop`, `play()` recarrega `mediaItem` em vez de apenas `resume()`.
  - Confiança: 🟢

- [ ] TT-11, Testar incremento de estatísticas com fallback
  - Origem no legado: `lib/services/play_stats_service.dart`
  - Critério de pronto: RPC ausente aciona fallback manual; falha no fallback não interrompe playback.
  - Confiança: 🟢

- [ ] TT-12, Testar visibilidade do player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: `play(lyric)` isolado não exibe widget; `playAll` exibe controles e fecha com `clearPlaylist`.
  - Confiança: 🟢

- [ ] TT-13, Testar controles no player compacto
  - Origem no legado: `lib/widgets/category_player_widget.dart`
  - Critério de pronto: repeat, skip, play/pause, fechar e painel de letra respondem ao service sem crash.
  - Confiança: 🟢

- [ ] TT-14, Testar seek na visualização de letra
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: slider de áudio na letra atual chama `audioService.seek` com nova posição.
  - Confiança: 🟢

## Tarefas de Migração de Dados

- [ ] TM-01, Provisionar RPC e tabela de estatísticas no Supabase
  - Origem no legado: `lib/services/play_stats_service.dart`, lacuna de schema
  - Critério de pronto: `lyric_play_stats` existe com `lyric_id`, `play_count`, `last_played_at`, `updated_at`; RPC `increment_play_count(p_lyric_id uuid)` faz upsert atômico.
  - Confiança: 🔴

Não há migração SQLite específica desta unit — reprodução consome caminhos/URLs já persistidos em `lyrics`. 🟢

## Ordem Sugerida

1. Implementar `MyAudioHandler` (T-01 a T-05) e validar reprodução unitária com testes TT-01 a TT-04.
2. Implementar `AudioPlayerService` e bootstrap (T-06 a T-15, T-14-T-15).
3. Implementar playlist e repeat (T-09 a T-12) com testes TT-05 a TT-09.
4. Integrar `PlayStatsService` (T-16, T-17, TM-01, TT-11).
5. Implementar `CategoryPlayerWidget` e integrações de lista (T-18 a T-21, TT-12, TT-13).
6. Integrar `LyricViewScreen` (T-22, TT-14).
7. Revisar manifest/plataforma (T-23) e fechar lacuna da RPC (T-24).

## Lacunas Pendentes (🔴)

- 🔴 Definição SQL da RPC `increment_play_count` não encontrada no repositório — validar no Supabase antes de depender só do fallback.
- 🟡 Comportamento offline de estatísticas (sem rede) não está especificado — decidir fila local ou aceitar perda silenciosa.
- 🟡 Interação entre `play(lyric)` durante playlist ativa e consistência de índice da fila não está formalizada.
- 🟡 Sincronização entre repeat da notificação (`AudioServiceRepeatMode`) e `_isRepeatEnabled` do service merece teste de regressão.
