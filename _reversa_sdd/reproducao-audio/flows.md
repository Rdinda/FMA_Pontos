# Reprodução de Áudio — Fluxos Operacionais

## Fluxo 1 — Inicializar serviço de áudio no bootstrap

```mermaid
sequenceDiagram
  participant Main as main.dart
  participant Svc as AudioPlayerService
  participant AS as AudioService
  participant H as MyAudioHandler
  participant App as MyApp

  Main->>Svc: await create()
  Svc->>H: new MyAudioHandler()
  H->>H: setAudioContext Android/iOS
  Svc->>AS: AudioService.init(builder, config)
  AS-->>Svc: AudioHandler
  Svc->>Svc: _setupListeners()
  Main->>App: runApp(audioService)
  App->>App: ChangeNotifierProvider.value
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `AudioPlayerService.create()` termina antes de `runApp`.
- 🟢 **CONFIRMADO** — Canal Android: `com.fmapontos.channel.audio`.
- 🟢 **CONFIRMADO** — `androidStopForegroundOnPause: false` mantém notificação ao pausar.
- 🟢 **CONFIRMADO** — Listeners de duração, posição e `playbackState` são registrados na criação.

## Fluxo 2 — Reproduzir uma letra (faixa única)

```mermaid
flowchart TD
  A["Usuário aciona play em LyricViewScreen ou lista"] --> B{"lyric tem audioUrl ou localAudioPath?"}
  B -- "não" --> C["Retornar sem ação / botão desabilitado"]
  B -- "sim" --> D["AudioPlayerService.play lyric"]
  D --> E{"lyric.id == currentLyric.id?"}
  E -- "não" --> F["_currentLyric = lyric"]
  F --> G["Montar MediaItem com extras url/localPath"]
  G --> H["playMediaItem"]
  H --> I{"localPath preenchido?"}
  I -- "sim" --> J["DeviceFileSource"]
  I -- "não" --> K{"url preenchido?"}
  K -- "sim" --> L["UrlSource"]
  K -- "não" --> M["broadcast error"]
  J --> N["broadcast ready/playing"]
  L --> N
  N --> O["incrementPlayCount lyric.id"]
  E -- "sim" --> P{"isPlaying?"}
  P -- "sim" --> Q["pause"]
  P -- "não" --> R["play/resume ou reload se stopped"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Faixa local tem prioridade sobre URL remota.
- 🟢 **CONFIRMADO** — Segundo play na mesma letra alterna pause/resume sem novo incremento de estatística.
- 🟢 **CONFIRMADO** — `play(lyric)` isolado **não** popula `_playlist`.
- 🟢 **CONFIRMADO** — Player compacto permanece oculto (`hasPlaylist == false`).

## Fluxo 3 — Iniciar playlist com "Tocar Todas"

```mermaid
flowchart TD
  A["CategoryScreen / FavoritesScreen / TopPlayedScreen"] --> B["Usuário toca Tocar Todas"]
  B --> C["playAll lyrics"]
  C --> D{"lista vazia?"}
  D -- "sim" --> E["return"]
  D -- "não" --> F["filtrar letras com audioUrl ou localAudioPath"]
  F --> G{"lyricsWithAudio vazio?"}
  G -- "sim" --> E
  G -- "não" --> H["_playlist = filtrada"]
  H --> I["_currentIndex = 0"]
  I --> J["Registrar callbacks no MyAudioHandler"]
  J --> K["_playCurrentTrack"]
  K --> L["playMediaItem + incrementPlayCount"]
  L --> M["CategoryPlayerWidget visível"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Letras sem áudio são excluídas da fila.
- 🟢 **CONFIRMADO** — Playlist sempre começa no índice 0.
- 🟢 **CONFIRMADO** — Callbacks `onTrackComplete`, `onSkipNext`, `onSkipPrevious`, `onToggleRepeat` são ligados somente em `playAll`.
- 🟢 **CONFIRMADO** — Telas de lista embutem `CategoryPlayerWidget` via `bottomSheet`.

## Fluxo 4 — Auto-avanço ao fim da faixa

```mermaid
flowchart TD
  A["AudioPlayer onPlayerComplete"] --> B["onTrackComplete callback"]
  B --> C{"currentIndex < playlist.length - 1?"}
  C -- "sim" --> D["skipNext"]
  D --> E["_currentIndex++"]
  E --> F["_playCurrentTrack"]
  C -- "não" --> G{"isRepeatEnabled?"}
  G -- "sim" --> H["_currentIndex = 0"]
  H --> F
  G -- "não" --> I["clearPlaylist"]
  I --> J["stop handler"]
  J --> K["limpar playlist, lyric, posição"]
  K --> L["CategoryPlayerWidget oculto"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Há próxima faixa: avanço automático via `skipNext`.
- 🟢 **CONFIRMADO** — Última faixa + repeat: reinicia do índice 0.
- 🟢 **CONFIRMADO** — Última faixa sem repeat: `clearPlaylist` encerra fila e notificação.

## Fluxo 5 — Pular para próxima faixa

```mermaid
flowchart TD
  A["UI ou notificação: skipNext"] --> B{"playlist vazia?"}
  B -- "sim" --> C["return"]
  B -- "não" --> D{"currentIndex < length - 1?"}
  D -- "sim" --> E["currentIndex++"]
  D -- "não" --> F{"isRepeatEnabled?"}
  F -- "sim" --> G["currentIndex = 0"]
  F -- "não" --> C
  E --> H["_playCurrentTrack"]
  G --> H
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — No último índice sem repeat, `skipNext` não avança.
- 🟢 **CONFIRMADO** — Com repeat no fim, volta para a primeira faixa.
- 🟢 **CONFIRMADO** — Cada faixa nova dispara `incrementPlayCount`.

## Fluxo 6 — Voltar faixa ou reiniciar (regra dos 3 segundos)

```mermaid
flowchart TD
  A["UI ou notificação: skipPrevious"] --> B{"playlist vazia?"}
  B -- "sim" --> C["return"]
  B -- "não" --> D{"position.inSeconds > 3?"}
  D -- "sim" --> E["seek Duration.zero"]
  D -- "não" --> F{"currentIndex > 0?"}
  F -- "sim" --> G["currentIndex--"]
  G --> H["_playCurrentTrack"]
  F -- "não" --> I{"isRepeatEnabled?"}
  I -- "sim" --> J["currentIndex = length - 1"]
  J --> H
  I -- "não" --> K["seek Duration.zero no início"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Após 3 segundos de reprodução, "anterior" reinicia a faixa atual.
- 🟢 **CONFIRMADO** — Nos primeiros 3 segundos, volta para faixa anterior se existir.
- 🟢 **CONFIRMADO** — No início com repeat, vai para a última faixa da playlist.

## Fluxo 7 — Alternar repeat e pause/play

```mermaid
flowchart TD
  subgraph Repeat
    A1["toggleRepeat na UI"] --> B1["_isRepeatEnabled = !flag"]
    B1 --> C1["notifyListeners"]
    A2["setRepeatMode na notificação"] --> B2["handler alterna AudioServiceRepeatMode"]
    B2 --> C2["onToggleRepeat -> toggleRepeat no service"]
  end
  subgraph PlayPause
    D1["togglePlayPause"] --> E1{"isPlaying?"}
    E1 -- "sim" --> F1["pause"]
    E1 -- "não" --> G1["play/resume"]
  end
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Repeat afeta limites de `hasNext`/`hasPrevious` e loop nos extremos.
- 🟢 **CONFIRMADO** — Repeat de playlist não faz loop de faixa única no `AudioPlayer`.
- 🟡 **INFERIDO** — Repeat da notificação e flag do service são sincronizados via callback, não por espelhamento direto de enum.

## Fluxo 8 — Fechar playlist e player compacto

```mermaid
flowchart TD
  A["Usuário toca fechar no CategoryPlayerWidget"] --> B["clearPlaylist"]
  B --> C["_playlist = []"]
  C --> D["_currentIndex = -1"]
  D --> E["Remover callbacks do handler"]
  E --> F["await stop no AudioHandler"]
  F --> G["_currentLyric = null"]
  G --> H["_isPlaying = false"]
  H --> I["position/duration = zero"]
  I --> J["notifyListeners"]
  J --> K["Widget retorna SizedBox.shrink"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `stop()` limpa `mediaItem` e remove notificação.
- 🟢 **CONFIRMADO** — Estado de UI é totalmente resetado após fechar.
- 🟢 **CONFIRMADO** — Callbacks de playlist são anulados para evitar avanço fantasma.

## Fluxo 9 — Player compacto: letra e favorito

```mermaid
flowchart TD
  A["CategoryPlayerWidget"] --> B{"hasPlaylist?"}
  B -- "não" --> C["SizedBox.shrink"]
  B -- "sim" --> D["Exibir barra de progresso e controles"]
  D --> E["Usuário toca ícone artigo"]
  E --> F{"_showLyrics?"}
  F -- "não" --> G["Expandir painel até 65% altura"]
  G --> H["Exibir currentLyric.content"]
  F -- "sim" --> I["Recolher painel"]
  D --> J["Usuário toca coração"]
  J --> K["FavoritesService.toggleFavorite currentLyric.id"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Barra de progresso é somente leitura (sem seek no compacto).
- 🟢 **CONFIRMADO** — Favorito delega à unit Favoritos.
- 🟢 **CONFIRMADO** — Índice exibido como `(currentIndex + 1)/total`.

## Fluxo 10 — Registrar estatística de reprodução

```mermaid
flowchart TD
  A["play ou _playCurrentTrack inicia faixa"] --> B["incrementPlayCount lyricId"]
  B --> C["Supabase.rpc increment_play_count"]
  C --> D{"RPC sucesso?"}
  D -- "sim" --> E["Log sucesso"]
  D -- "não" --> F["select lyric_play_stats"]
  F --> G{"registro existe?"}
  G -- "sim" --> H["update play_count + last_played_at"]
  G -- "não" --> I["insert play_count = 1"]
  H --> J["Log fallback ok"]
  I --> J
  C --> K{"qualquer erro?"}
  K -- "sim" --> L["Log erro sem throw"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Falha de estatística não interrompe playback.
- 🟢 **CONFIRMADO** — Toggle na mesma faixa não dispara novo incremento.
- 🔴 **LACUNA** — SQL da RPC `increment_play_count` não versionado no repositório.

## Fluxo 11 — Controles de notificação e sistema

```mermaid
flowchart TD
  A["MyAudioHandler._broadcastState"] --> B["MediaControl skipToPrevious"]
  A --> C["MediaControl play ou pause"]
  A --> D["MediaControl skipToNext"]
  A --> E["MediaControl stop"]
  B --> F["onSkipPrevious callback"]
  D --> G["onSkipNext callback"]
  C --> H["play ou pause no player"]
  E --> I["stop + mediaItem null"]
  J["MediaAction seek na notificação"] --> K["_player.seek"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Controles compactos na notificação: índices [0,1,2] = anterior, play/pause, próximo.
- 🟢 **CONFIRMADO** — `systemActions` inclui seek forward/backward e `setRepeatMode`.
- 🟢 **CONFIRMADO** — Skip na notificação delega lógica de playlist ao service via callbacks.

## Fluxo 12 — Áudio na visualização de letra (integração)

```mermaid
flowchart TD
  A["LyricViewScreen modo audio"] --> B["Consumer AudioPlayerService"]
  B --> C{"currentLyric.id == _lyric.id?"}
  C -- "sim" --> D["Exibir slider position/duration"]
  C -- "não" --> E["Posição e duração zeradas"]
  D --> F["Play chama _togglePlay -> play _lyric"]
  D --> G["Seek chama audioService.seek"]
  H["Usuário seleciona Vídeo"] --> I{"audio tocando mesma letra?"}
  I -- "sim" --> J["togglePlayPause pausa áudio"]
  I -- "não" --> K["Seguir para modo vídeo"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Seek só afeta slider quando a letra exibida é a faixa atual.
- 🟢 **CONFIRMADO** — Alternar para vídeo pausa áudio da mesma letra se estiver tocando.
- 🟢 **CONFIRMADO** — Detalhe da letra usa `play` unitário, não `playAll`.

## Estados relevantes

```mermaid
stateDiagram-v2
  [*] --> Idle: bootstrap
  Idle --> PlayingSingle: play lyric sem playlist
  PlayingSingle --> PausedSingle: pause mesma letra
  PausedSingle --> PlayingSingle: resume
  Idle --> PlaylistActive: playAll
  PlaylistActive --> PlayingTrack: _playCurrentTrack
  PlayingTrack --> PlayingTrack: skipNext/skipPrevious
  PlayingTrack --> PausedPlaylist: pause
  PausedPlaylist --> PlayingTrack: resume
  PlayingTrack --> PlaylistActive: auto-next
  PlaylistActive --> Idle: clearPlaylist ou fim sem repeat
  PlayingSingle --> Idle: stop ou trocar contexto
  PlayingTrack --> Error: sem fonte ou exceção
  Error --> Idle: nova tentativa ou clear
```

## Pontos de falha

| Falha | Comportamento legado | Confiança |
|-------|----------------------|-----------|
| Sem `localPath` e sem `url` | `AudioProcessingState.error`, não toca | 🟢 |
| Exceção em `play()` | Log + broadcast error | 🟢 |
| `playAll` com lista sem áudio | Retorna sem iniciar playlist | 🟢 |
| RPC de estatística indisponível | Fallback manual em `lyric_play_stats` | 🟢 |
| Fallback de estatística falha | Log apenas, playback continua | 🟢 |
| Resume após `stop` | `play()` recarrega `playMediaItem` | 🟢 |
| Rede indisponível para URL remota | Depende do `audioplayers`; sem retry explícito | 🟡 |
| `play(lyric)` durante playlist ativa | Troca `currentLyric` sem reindexar playlist | 🟡 |

## Lacunas

- 🔴 **LACUNA** — Contrato SQL da RPC `increment_play_count` ausente no repo.
- 🟡 **INFERIDO** — Comportamento offline de estatísticas e de URL remota não está formalizado.
- 🟡 **INFERIDO** — Conflito entre faixa única e playlist simultânea não tem regra explícita no código.
