# Visualização de Letra — Fluxos Operacionais

## Fluxo 1 — Abrir visualização da letra

```mermaid
flowchart TD
  A["Tela anterior chama Navigator.push"] --> B["LyricViewScreen lyric"]
  B --> C["initState"]
  C --> D["_lyric = widget.lyric"]
  D --> E["_loadCategory"]
  D --> F["_initYoutubePlayer"]
  E --> G["SyncRepository.getCategory categoryId"]
  G --> H{"Categoria encontrada?"}
  H -- "sim" --> I["setState _category"]
  H -- "não" --> J["Manter _category null"]
  F --> K{"youtubeLink converte para videoId?"}
  K -- "sim" --> L["Criar YoutubePlayerController"]
  K -- "não" --> M["_youtubeController null"]
  I --> N["build"]
  J --> N
  L --> N
  M --> N
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — A tela recebe `Lyric` já resolvida da navegação.
- 🟢 **CONFIRMADO** — Categoria é carregada localmente, de forma assíncrona.
- 🟢 **CONFIRMADO** — Falha em carregar categoria não bloqueia a tela.
- 🟢 **CONFIRMADO** — Player YouTube só é criado se o link produzir ID válido.

## Fluxo 2 — Renderizar título e conteúdo

```mermaid
flowchart TD
  A["build AppBar"] --> B{"_category != null e code não vazio?"}
  B -- "sim" --> C["Título: code + sequenceNumber 2 dígitos + title uppercase"]
  B -- "não" --> D["Título: title uppercase"]
  C --> E["Renderizar AppBar"]
  D --> E
  E --> F["Renderizar corpo"]
  F --> G["SingleChildScrollView"]
  G --> H["ConstrainedBox maxWidth 600"]
  H --> I["Painel com _lyric.content"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O conteúdo textual sempre vem de `_lyric.content`.
- 🟢 **CONFIRMADO** — A referência com código é enriquecimento visual, não dependência obrigatória.
- 🟢 **CONFIRMADO** — O título usa `sequenceNumber.toString().padLeft(2, '0')`.

## Fluxo 3 — Decidir disponibilidade de mídia

```mermaid
flowchart TD
  A["Consumer AudioPlayerService"] --> B["Calcular hasAudio"]
  A --> C["Calcular canPlayVideo"]
  B --> D{"hasAudio ou canPlayVideo?"}
  C --> D
  D -- "não" --> E["Mostrar card Sem mídia para tocar"]
  D -- "sim" --> F["Mostrar card de mídia"]
  F --> G["Botão Áudio habilitado se hasAudio"]
  F --> H["Botão Vídeo habilitado se canPlayVideo"]
  F --> I{"_playerMode"}
  I -- "none" --> J["Mostrar Escolha um player"]
  I -- "audio" --> K["Mostrar controles de áudio"]
  I -- "video" --> L["Mostrar YoutubePlayer"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `hasAudio` exige `audioUrl` ou `localAudioPath` preenchido.
- 🟢 **CONFIRMADO** — `canPlayVideo` exige `_youtubeController != null`.
- 🟢 **CONFIRMADO** — Letra sem mídia mostra mensagem informativa em vez de botões desabilitados.

## Fluxo 4 — Selecionar e controlar áudio

```mermaid
flowchart TD
  A["Usuário toca Áudio"] --> B{"hasAudio?"}
  B -- "não" --> C["Botão desabilitado"]
  B -- "sim" --> D["_youtubeController.pause"]
  D --> E["setState _playerMode = audio"]
  E --> F["Renderizar controles de áudio"]
  F --> G["Usuário toca play/pause"]
  G --> H["_togglePlay"]
  H --> I{"hasAudio ainda verdadeiro?"}
  I -- "não" --> J["Não faz nada"]
  I -- "sim" --> K["AudioPlayerService.play _lyric"]
  F --> L["Usuário move slider"]
  L --> M{"currentLyric.id == _lyric.id?"}
  M -- "sim" --> N["AudioPlayerService.seek posição"]
  M -- "não" --> O["Ignorar seek"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Selecionar áudio pausa YouTube.
- 🟢 **CONFIRMADO** — Play usa `AudioPlayerService.play(_lyric)`.
- 🟢 **CONFIRMADO** — Slider só busca posição quando a letra visualizada é a letra atual do serviço.
- 🟢 **CONFIRMADO** — Tempo é exibido no formato `mm:ss`.

## Fluxo 5 — Selecionar e controlar vídeo

```mermaid
flowchart TD
  A["Usuário toca Vídeo"] --> B{"canPlayVideo?"}
  B -- "não" --> C["Botão desabilitado"]
  B -- "sim" --> D{"audioService.isPlaying?"}
  D -- "sim" --> E["AudioPlayerService.togglePlayPause"]
  D -- "não" --> F["Sem pausa necessária"]
  E --> G["setState _playerMode = video"]
  F --> G
  G --> H["Renderizar YoutubePlayer"]
  H --> I["Usuário usa controles YouTube"]
  I --> J["Controller gerencia progresso, velocidade e fullscreen"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Selecionar vídeo pausa áudio quando algum áudio está tocando.
- 🟢 **CONFIRMADO** — O player usa controles de posição, barra de progresso, velocidade e fullscreen.
- 🟢 **CONFIRMADO** — URL inválida não cria controller e impede esse fluxo.

## Fluxo 6 — Fechar player ativo

```mermaid
flowchart TD
  A["Usuário toca fechar"] --> B{"_playerMode"}
  B -- "audio" --> C{"audioService.isPlaying e currentLyric.id == _lyric.id?"}
  C -- "sim" --> D["AudioPlayerService.togglePlayPause"]
  C -- "não" --> E["Sem pausa de áudio"]
  B -- "video" --> F["_youtubeController.pause"]
  B -- "none" --> G["Botão não aparece"]
  D --> H["setState _playerMode = none"]
  E --> H
  F --> H
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O botão fechar aparece apenas quando `_playerMode != none`.
- 🟢 **CONFIRMADO** — Fechar áudio pausa apenas se a letra visualizada é a que está tocando.
- 🟢 **CONFIRMADO** — Fechar vídeo pausa YouTube.

## Fluxo 7 — Favoritar no modo áudio

```mermaid
flowchart TD
  A["_playerMode = audio"] --> B["Consumer FavoritesService"]
  B --> C["isFavorite _lyric.id"]
  C --> D{"Favoritada?"}
  D -- "sim" --> E["Mostrar coração preenchido"]
  D -- "não" --> F["Mostrar coração contornado"]
  E --> G["Usuário toca coração"]
  F --> G
  G --> H["Capturar wasFav"]
  H --> I["FavoritesService.toggleFavorite _lyric.id"]
  I --> J{"wasFav?"}
  J -- "sim" --> K["Snackbar Removido dos favoritos"]
  J -- "não" --> L["Snackbar Adicionado aos favoritos"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Favoritar usa estado local, sem RBAC.
- 🟢 **CONFIRMADO** — A mensagem depende do estado anterior.
- 🟢 **CONFIRMADO** — O botão aparece dentro dos controles de áudio.

## Fluxo 8 — Refresh manual da letra

```mermaid
flowchart TD
  A["Usuário puxa para atualizar"] --> B["RefreshIndicator.onRefresh"]
  B --> C["SyncRepository.syncData"]
  C --> D["SyncRepository.getLyric _lyric.id"]
  D --> E{"updated != null e mounted?"}
  E -- "não" --> F["Manter estado atual"]
  E -- "sim" --> G["setState _lyric = updated"]
  G --> H["Dispose controller YouTube antigo"]
  H --> I["_youtubeController = null"]
  I --> J["_initYoutubePlayer"]
  J --> K["Recalcular hasAudio e hasVideo"]
  K --> L{"Modo atual ainda é válido?"}
  L -- "sim" --> M["Manter _playerMode"]
  L -- "não" --> N["_playerMode = none"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Refresh tenta sincronizar antes de recarregar a letra.
- 🟢 **CONFIRMADO** — A tela só atualiza se a letra recarregada existe.
- 🟢 **CONFIRMADO** — Controller YouTube é recriado após alteração.
- 🟢 **CONFIRMADO** — Modo de player inválido é fechado.
- 🟡 **INFERIDO** — Se a letra não existir mais, a tela não exibe aviso explícito.

## Fluxo 9 — Editar letra

```mermaid
flowchart TD
  A["AppBar actions"] --> B{"AuthService.canEditLyrics?"}
  B -- "não" --> C["Não renderizar botão editar"]
  B -- "sim" --> D["Renderizar botão editar"]
  D --> E["Usuário toca editar"]
  E --> F["Navigator.push LyricFormScreen"]
  F --> G["Usuário salva/volta"]
  G --> H{"result == true?"}
  H -- "sim" --> I["Navigator.pop LyricViewScreen"]
  H -- "não" --> J["SyncRepository.getLyric _lyric.id"]
  J --> K{"updated != null?"}
  K -- "não" --> L["Manter estado atual"]
  K -- "sim" --> M["Atualizar _lyric e reinicializar mídia"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `moderator` e `admin` podem editar.
- 🟢 **CONFIRMADO** — Edição abre `LyricFormScreen` com o mesmo `categoryId` e a letra atual.
- 🟢 **CONFIRMADO** — Retorno `true` fecha a visualização.
- 🟢 **CONFIRMADO** — Retorno diferente de `true` recarrega a letra local.

## Fluxo 10 — Excluir letra

```mermaid
flowchart TD
  A["AppBar actions"] --> B{"AuthService.canDeleteLyrics?"}
  B -- "não" --> C["Não renderizar botão excluir"]
  B -- "sim" --> D["Renderizar botão excluir"]
  D --> E["Usuário toca excluir"]
  E --> F["Dialog Excluir Letra?"]
  F --> G{"Confirmou?"}
  G -- "não" --> H["Fechar dialog"]
  G -- "sim" --> I["Fechar dialog"]
  I --> J["SyncRepository.deleteLyric _lyric.id"]
  J --> K["Navigator.pop LyricViewScreen"]
  K --> L["SyncRepository.getLyric _lyric.id"]
  L --> M{"updated == null?"}
  M -- "sim" --> N["Snackbar Letra excluída com sucesso"]
  M -- "não" --> O["Sem feedback específico"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Apenas `admin` pode excluir pela UI.
- 🟢 **CONFIRMADO** — Exclusão exige confirmação.
- 🟢 **CONFIRMADO** — O repository cuida do delete local/remoto conforme sync.
- 🟡 **INFERIDO** — O feedback após `Navigator.pop` exige cuidado com `context.mounted` na reimplementação.

## Estados relevantes

```mermaid
stateDiagram-v2
  [*] --> DetalheCarregado
  DetalheCarregado --> SemMidia: sem audio e sem video
  DetalheCarregado --> MidiaDisponivel: audio ou video disponível
  MidiaDisponivel --> PlayerNenhum: _PlayerMode.none
  PlayerNenhum --> PlayerAudio: selecionar Áudio
  PlayerNenhum --> PlayerVideo: selecionar Vídeo
  PlayerAudio --> PlayerVideo: selecionar Vídeo / pausar áudio
  PlayerVideo --> PlayerAudio: selecionar Áudio / pausar YouTube
  PlayerAudio --> PlayerNenhum: fechar
  PlayerVideo --> PlayerNenhum: fechar
  DetalheCarregado --> Recarregando: pull-to-refresh ou retorno de edição
  Recarregando --> DetalheCarregado: letra encontrada
  Recarregando --> DetalheCarregado: letra não encontrada / mantém estado legado
  DetalheCarregado --> Fechada: exclusão confirmada ou retorno true da edição
```

## Pontos de falha

| Falha | Comportamento legado | Confiança |
|---|---|---|
| Categoria não encontrada | AppBar usa apenas título da letra | 🟢 |
| YouTube inválido | Controller não é criado e botão vídeo fica indisponível | 🟢 |
| Sem áudio e sem vídeo | Mostra card informativo de ausência de mídia | 🟢 |
| Refresh retorna letra inexistente | Mantém estado atual, sem aviso específico | 🟡 |
| `syncData` falha | Não há tratamento explícito local na tela | 🟡 |
| Delete falha | Não há feedback específico de falha na tela | 🟡 |
| Edição remove mídia ativa | Modo volta para `none` se a mídia atual deixou de existir | 🟢 |
| Sair da tela com YouTube ativo | Controller é descartado no `dispose` | 🟢 |

## Lacunas

- 🟡 **INFERIDO** — Falhas de refresh/delete deveriam ter feedback explícito em uma reimplementação moderna.
- 🟡 **INFERIDO** — Se a letra é removida durante refresh, o legado não navega automaticamente para fora.
- 🟡 **INFERIDO** — O snackbar após exclusão pode depender de contexto já desmontado; reimplementar com mensageria no destino seria mais robusto.

