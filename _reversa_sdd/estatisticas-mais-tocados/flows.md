# Estatísticas / Mais Tocados — Fluxos Operacionais

## Fluxo 1 — Incrementar contador ao tocar áudio

```mermaid
flowchart TD
  A["AudioPlayerService.play(lyric)"] --> B{"lyric.id != current?"}
  B -- "não" --> C["toggle pause/resume SEM incremento"]
  B -- "sim" --> D["playMediaItem"]
  D --> E["incrementPlayCount(lyric.id)"]
  E --> F["rpc increment_play_count"]
  F --> G{"ok?"}
  G -- "sim" --> H["log sucesso"]
  G -- "não" --> I["fallback SELECT/UPDATE/INSERT"]
  I --> J{"erro fallback?"}
  J -- "sim" --> K["debugPrint silencioso"]
  J -- "não" --> H
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Incremento é assíncrono e não bloqueia `playMediaItem`.
- 🟢 **CONFIRMADO** — Mesma letra em pause/resume não reconta.
- 🔴 **LACUNA** — RPC ideal não está no schema versionado.

## Fluxo 2 — Incremento em playlist (skip / play all)

```mermaid
flowchart TD
  A["playAll ou skipNext"] --> B["_playCurrentTrack"]
  B --> C["set _currentLyric"]
  C --> D["playMediaItem"]
  D --> E["incrementPlayCount(lyric.id)"]
  E --> F["Fluxo 1 RPC/fallback"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Cada faixa nova na playlist incrementa uma vez ao iniciar.
- 🟢 **CONFIRMADO** — Repeat no fim da playlist reinicia do índice 0 e incrementa de novo ao tocar faixa 1.

## Fluxo 3 — Carregar ranking Mais Tocados

```mermaid
flowchart TD
  A["TopPlayedScreen init"] --> B["_loadTopPlayed"]
  B --> C["getTopPlayed limit 50"]
  C --> D["Supabase order play_count desc"]
  D --> E{"stats vazios?"}
  E -- "sim" --> F["empty state UI"]
  E -- "não" --> G["loop stats"]
  G --> H["getLyricById local"]
  H --> I{"lyric existe?"}
  I -- "não" --> J["omitir item"]
  I -- "sim" --> K["LyricWithStats + categoryName"]
  K --> L["ListView com rank"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Limite 50 na tela vs default 20 no serviço.
- 🟢 **CONFIRMADO** — Erro de rede define `_error` e botão Tentar novamente.
- 🟡 **INFERIDO** — Ranking exibido pode ter menos itens que 50 se muitos IDs não existem localmente.

## Fluxo 4 — Tocar todos do ranking

```mermaid
flowchart TD
  A["Tap play all AppBar"] --> B{"_topPlayed vazio?"}
  B -- "sim" --> C["return"]
  B -- "não" --> D["filtrar lyrics com áudio"]
  D --> E{"lista vazia?"}
  E -- "sim" --> F["snackbar Nenhum ponto com áudio"]
  E -- "não" --> G["AudioPlayerService.playAll"]
  G --> H["snackbar Reproduzindo N pontos"]
  H --> I["Cada faixa dispara Fluxo 2"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Botão play all só visível se `_topPlayed.isNotEmpty`.
- 🟢 **CONFIRMADO** — Ordem da playlist segue ordem do ranking (após filtro).

## Fluxo 5 — Interação com item do ranking

```mermaid
flowchart TD
  A["ListTile item"] --> B{"ação?"}
  B -- "tap linha" --> C["Navigator LyricViewScreen"]
  B -- "play button" --> D{"current e playing?"}
  D -- "sim" --> E["pause"]
  D -- "não" --> F["play lyric"]
  F --> G["Fluxo 1 incremento se nova"]
  B -- "visual" --> H["highlight se currentLyric"]
  H --> I["graphic_eq se isPlaying"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `Consumer<AudioPlayerService>` atualiza ícones em tempo real.
- 🟢 **CONFIRMADO** — Top 3 mantém troféu mesmo quando não está tocando (exceto quando `isPlaying` substitui por equalizer).

## Fluxo 6 — Refresh da lista

```mermaid
flowchart TD
  A["Pull-to-refresh ou ícone refresh"] --> B["_loadTopPlayed"]
  B --> C["isLoading true"]
  C --> D["getTopPlayed"]
  D --> E["atualiza _topPlayed"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Refresh não altera playback em andamento.
- 🟢 **CONFIRMADO** — Stats refletem incrementos remotos de outros dispositivos após reload.

## Fluxo 7 — Fallback manual de incremento

```mermaid
sequenceDiagram
  participant PS as PlayStatsService
  participant SB as Supabase
  PS->>SB: SELECT lyric_play_stats WHERE lyric_id
  alt existe
    SB-->>PS: row
    PS->>SB: UPDATE play_count+1, timestamps
  else não existe
    PS->>SB: INSERT play_count=1
  end
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Usado apenas quando RPC falha.
- 🟡 **INFERIDO** — Concorrência pode perder incrementos sem transação.

## Fluxo 8 — Acesso pela Home

```mermaid
flowchart LR
  H["HomeScreen bottom nav"] --> I["index 2 Mais Tocados"]
  I --> T["TopPlayedScreen"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Push route; não altera tab index da Home (index 2 não seleciona aba home).

## Matriz fluxo × RF

| Fluxo | RF |
|-------|-----|
| Incremento play | RF-01, RF-02, RF-03, RF-04, RF-05 |
| Playlist increment | RF-01 |
| Carregar ranking | RF-06, RF-07, RF-12 |
| Play all | RF-10 |
| Item ranking | RF-08, RF-09, RF-11, RF-14 |
| Refresh | RF-12 |
| Fallback | RF-04 |
| Home nav | RF-06 |
