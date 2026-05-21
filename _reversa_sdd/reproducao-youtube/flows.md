# Reprodução YouTube — Fluxos Operacionais

## Fluxo 1 — Persistir link YouTube no formulário

```mermaid
sequenceDiagram
  participant U as Usuário
  participant Form as LyricFormScreen
  participant Conv as YoutubePlayer.convertUrlToId
  participant Repo as SyncRepository
  participant DB as SQLite

  U->>Form: preenche Link do YouTube + Salvar
  Form->>Form: trim(youtubeUrl)
  alt youtubeUrl vazio
    Form->>Repo: addLyric(youtubeLink: null)
    Repo->>DB: upsert lyrics
  else youtubeUrl preenchido
    Form->>Conv: convertUrlToId(url)
    alt videoId null
      Conv-->>Form: null
      Form-->>U: snackbar "Link do YouTube inválido."
    else videoId válido
      Conv-->>Form: videoId
      Form->>Repo: addLyric(youtubeLink: url)
      Repo->>DB: upsert lyrics
      Form-->>U: Navigator.pop
    end
  end
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Validação ocorre apenas no save, não em tempo real no campo.
- 🟢 **CONFIRMADO** — URL original é persistida, não apenas o `videoId`.
- 🟢 **CONFIRMADO** — Título vazio aborta save antes da validação YouTube (`if (title.isEmpty) return`).
- 🟡 **INFERIDO** — Edição e criação compartilham a mesma regra de validação.

## Fluxo 2 — Inicializar player na abertura da letra

```mermaid
flowchart TD
  A["LyricViewScreen.initState"] --> B["_initYoutubePlayer()"]
  B --> C{"youtubeLink != null?"}
  C -- "não" --> D["_youtubeController = null"]
  C -- "sim" --> E["videoId = convertUrlToId(link)"]
  E --> F{"videoId != null?"}
  F -- "não" --> D
  F -- "sim" --> G["new YoutubePlayerController(initialVideoId, flags)"]
  G --> H["canPlayVideo = true na UI"]
  D --> I["botão Vídeo desabilitado"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `autoPlay: false` — vídeo não inicia até usuário escolher modo `Vídeo`.
- 🟢 **CONFIRMADO** — `enableCaption: true` por padrão.
- 🟢 **CONFIRMADO** — Link inválido persistido (ex.: dados legados) resulta em ausência de controller, não crash.

## Fluxo 3 — Alternar para modo vídeo (com exclusividade de áudio)

```mermaid
sequenceDiagram
  participant U as Usuário
  participant LVS as LyricViewScreen
  participant Audio as AudioPlayerService
  participant YT as YoutubePlayerController

  U->>LVS: toca botão Vídeo
  alt audioService.isPlaying e currentLyric == _lyric
    LVS->>Audio: togglePlayPause()
    Audio-->>LVS: áudio pausado
  end
  LVS->>LVS: setState(_playerMode = video)
  Note over LVS,YT: YoutubePlayer renderizado
  U->>YT: play via controles nativos do widget
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Alternância para vídeo não chama `AudioPlayerService.play`.
- 🟢 **CONFIRMADO** — Controles de play/pause do YouTube são do próprio `youtube_player_flutter`.
- 🟡 **INFERIDO** — Estatísticas de play (`PlayStatsService`) não são incrementadas ao assistir vídeo.

## Fluxo 4 — Alternar para modo áudio (pausar YouTube)

```mermaid
sequenceDiagram
  participant U as Usuário
  participant LVS as LyricViewScreen
  participant YT as YoutubePlayerController

  U->>LVS: toca botão Áudio
  LVS->>YT: pause()
  LVS->>LVS: setState(_playerMode = audio)
  Note over LVS: UI de áudio com play/slider/favorito
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — YouTube pausa antes da troca de modo, mesmo se estava tocando.
- 🟢 **CONFIRMADO** — Modo áudio reutiliza `AudioPlayerService` da unit `reproducao-audio`.

## Fluxo 5 — Fechar card de mídia

```mermaid
flowchart TD
  A["Usuário toca ícone fechar"] --> B{"_playerMode?"}
  B -- "audio" --> C{"áudio da letra tocando?"}
  C -- "sim" --> D["togglePlayPause()"]
  C -- "não" --> E["skip pause áudio"]
  B -- "video" --> F["_youtubeController.pause()"]
  D --> G["setState(_playerMode = none)"]
  E --> G
  F --> G
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Fechar não descarta o controller; apenas pausa e oculta UI do player.
- 🟢 **CONFIRMADO** — Usuário pode reabrir modo áudio ou vídeo sem recarregar a tela.

## Fluxo 6 — Recriar player após refresh ou edição

```mermaid
sequenceDiagram
  participant U as Usuário
  participant LVS as LyricViewScreen
  participant Repo as SyncRepository
  participant YT as YoutubePlayerController

  alt Pull-to-refresh
    U->>LVS: RefreshIndicator
    LVS->>Repo: syncData()
  else Retorno de LyricFormScreen
    U->>LVS: volta da edição
    LVS->>Repo: getLyric(id)
  end
  Repo-->>LVS: Lyric atualizada
  LVS->>YT: dispose()
  LVS->>LVS: _youtubeController = null
  LVS->>LVS: _initYoutubePlayer()
  LVS->>LVS: ajustar _playerMode se mídia atual inválida
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `RefreshIndicator` sincroniza antes de recarregar letra local.
- 🟢 **CONFIRMADO** — Se formulário retorna `true` (exclusão), tela de visualização fecha sem recriar player.
- 🟢 **CONFIRMADO** — Modo `video` sem controller válido após reload → `none`.

## Fluxo 7 — Indicador de vídeo em lista (heurística)

```mermaid
flowchart LR
  A["CategoryScreen tile"] --> B{"youtubeLink?.isNotEmpty"}
  B -- "sim" --> C["hasVideo = true"]
  B -- "não" --> D["hasVideo = false"]
  C --> E["UI pode sinalizar vídeo"]
  E --> F["LyricViewScreen valida com convertUrlToId"]
```

### Contrato do fluxo

- 🟡 **INFERIDO** — Lista não garante player funcional; detalhe é fonte de verdade para reprodução.
- 🟢 **CONFIRMADO** — Navegação para detalhe não depende de `hasVideo` para abrir a tela.

## Matriz de cenários

| Cenário | Controller | Botão Vídeo | Botão Áudio | UI |
|---------|------------|-------------|-------------|-----|
| Sem link | null | desabilitado | conforme áudio | "Sem mídia" ou só áudio |
| Link inválido | null | desabilitado | conforme áudio | idem |
| Link válido, modo none | criado | habilitado | conforme áudio | "Escolha um player" |
| Modo video | ativo | destacado | habilitado | YoutubePlayer |
| Modo audio | criado mas pausado | habilitado | destacado | controles áudio |
| Após dispose tela | — | — | — | recursos liberados |
