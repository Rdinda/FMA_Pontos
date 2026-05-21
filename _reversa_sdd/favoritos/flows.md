# Favoritos — Fluxos Operacionais

## Fluxo 1 — Inicializar favoritos locais

```mermaid
flowchart TD
  A["main.dart cria Provider"] --> B["FavoritesService()"]
  B --> C["_loadFavorites"]
  C --> D["SharedPreferences.getInstance"]
  D --> E["getStringList favorite_lyrics"]
  E --> F{"Lista existe?"}
  F -- "não" --> G["Usar lista vazia"]
  F -- "sim" --> H["Carregar IDs"]
  G --> I["_favorites.clear + addAll"]
  H --> I
  I --> J["_isLoaded = true"]
  J --> K["notifyListeners"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — A chave de persistência é `favorite_lyrics`.
- 🟢 **CONFIRMADO** — O serviço carrega favoritos automaticamente no construtor.
- 🟢 **CONFIRMADO** — O estado carregado é exposto por `isLoaded`.
- 🟢 **CONFIRMADO** — Falha de leitura é capturada, marca `isLoaded = true` e notifica listeners.

## Fluxo 2 — Favoritar ou remover favorito na tela de letra

```mermaid
flowchart TD
  A["LyricViewScreen renderiza letra"] --> B["Consumer FavoritesService"]
  B --> C["isFavorite lyric.id"]
  C --> D{"Letra favoritada?"}
  D -- "sim" --> E["Mostrar Icons.favorite"]
  D -- "não" --> F["Mostrar Icons.favorite_border"]
  E --> G["Usuário toca coração"]
  F --> G
  G --> H["Capturar wasFav"]
  H --> I["toggleFavorite lyric.id"]
  I --> J{"wasFav?"}
  J -- "sim" --> K["Snackbar Removido dos favoritos"]
  J -- "não" --> L["Snackbar Adicionado aos favoritos"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O ícone é derivado de `FavoritesService.isFavorite(_lyric.id)`.
- 🟢 **CONFIRMADO** — A mensagem do snackbar depende do estado antes do toggle.
- 🟢 **CONFIRMADO** — A operação não exige login ou role.
- 🟢 **CONFIRMADO** — `notifyListeners()` atualiza o botão após a alteração.

## Fluxo 3 — Alternar favorito no player compacto

```mermaid
flowchart TD
  A["CategoryPlayerWidget"] --> B["Consumer AudioPlayerService"]
  B --> C{"currentLyric != null?"}
  C -- "não" --> D["Não exibir botão de favorito"]
  C -- "sim" --> E["Consumer FavoritesService"]
  E --> F["isFavorite currentLyric.id"]
  F --> G{"Favoritado?"}
  G -- "sim" --> H["Mostrar coração preenchido"]
  G -- "não" --> I["Mostrar coração contornado"]
  H --> J["Usuário toca botão"]
  I --> J
  J --> K["toggleFavorite currentLyric.id"]
  K --> L["notifyListeners atualiza player"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O botão só existe quando há letra atual no player.
- 🟢 **CONFIRMADO** — O player compacto alterna favorito sem navegar para outra tela.
- 🟢 **CONFIRMADO** — O estado visual usa a mesma fonte (`FavoritesService`) da tela de letra e da lista "Gostei".

## Fluxo 4 — Abrir tela "Gostei" vazia ou carregando

```mermaid
flowchart TD
  A["HomeScreen abre FavoritesScreen"] --> B["Consumer2 FavoritesService SyncRepository"]
  B --> C{"favoritesService.isLoaded?"}
  C -- "não" --> D["Mostrar CircularProgressIndicator"]
  C -- "sim" --> E{"favorites vazio?"}
  E -- "sim" --> F["Mostrar estado vazio Nenhuma música favorita"]
  E -- "não" --> G["Resolver letras favoritas"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Antes de `isLoaded`, a tela mostra loading.
- 🟢 **CONFIRMADO** — Quando não há favoritos, a tela exibe orientação para tocar no coração.
- 🟢 **CONFIRMADO** — O botão "Tocar Todas" não aparece quando `favorites` está vazio.

## Fluxo 5 — Resolver e listar favoritos

```mermaid
flowchart TD
  A["FavoritesScreen recebe Set de IDs"] --> B["_getFavoriteLyricsWithCategory"]
  B --> C["repo.getCategories"]
  C --> D["Montar categoryMap por id"]
  D --> E["Iterar favoriteIds"]
  E --> F["repo.getLyric id"]
  F --> G{"Letra existe?"}
  G -- "não" --> H["Ignorar ID órfão"]
  G -- "sim" --> I["Buscar categoria no map"]
  I --> J{"Categoria existe?"}
  J -- "sim" --> K["Usar name/code da categoria"]
  J -- "não" --> L["Fallback Categoria / ??"]
  K --> M["Adicionar LyricWithCategory"]
  L --> M
  H --> N{"Há próximo ID?"}
  M --> N
  N -- "sim" --> E
  N -- "não" --> O["Ordenar por título"]
  O --> P{"Lista vazia?"}
  P -- "sim" --> Q["Mostrar Músicas favoritas não encontradas"]
  P -- "não" --> R["Renderizar ListView"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — A tela resolve letras a partir dos IDs locais usando `SyncRepository.getLyric`.
- 🟢 **CONFIRMADO** — IDs sem letra correspondente não são exibidos.
- 🟢 **CONFIRMADO** — Categoria ausente usa fallback visual.
- 🟢 **CONFIRMADO** — A ordenação final é alfabética por `lyric.title`.

## Fluxo 6 — Remover favorito pela lista "Gostei"

```mermaid
flowchart TD
  A["ListView de favoritos"] --> B["Usuário toca coração preenchido"]
  B --> C["favoritesService.toggleFavorite lyric.id"]
  C --> D["Remover ID do Set"]
  D --> E["notifyListeners"]
  E --> F["_saveFavorites"]
  F --> G["SharedPreferences.setStringList"]
  E --> H["Snackbar Removido dos favoritos"]
  E --> I["Consumer reconstrói lista"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O botão da lista sempre representa remoção, pois todo item listado já é favorito.
- 🟢 **CONFIRMADO** — A mensagem exibida é "Removido dos favoritos".
- 🟢 **CONFIRMADO** — A lista é reconstruída a partir do novo conjunto.

## Fluxo 7 — Navegar de favorito para visualização

```mermaid
flowchart TD
  A["Item favorito renderizado"] --> B["Usuário toca item"]
  B --> C["Navigator.push"]
  C --> D["LyricViewScreen lyric"]
  D --> E["Tela de detalhe usa mesma instância de Lyric"]
  E --> F["Favorito pode ser alterado no detalhe"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — O destino é `LyricViewScreen(lyric: lyric)`.
- 🟢 **CONFIRMADO** — A navegação não recarrega a letra remotamente.
- 🟢 **CONFIRMADO** — Alterar favorito no detalhe reflete na lista ao retornar, pois ambas consomem `FavoritesService`.

## Fluxo 8 — Tocar todas as favoritas

```mermaid
flowchart TD
  A["AppBar da FavoritesScreen"] --> B{"favorites vazio?"}
  B -- "sim" --> C["Ocultar botão Tocar Todas"]
  B -- "não" --> D["Exibir botão play_circle_outline"]
  D --> E["Usuário toca Tocar Todas"]
  E --> F["_playAllFavorites"]
  F --> G{"favorites vazio?"}
  G -- "sim" --> H["Snackbar Nenhuma música favorita"]
  G -- "não" --> I["Iterar IDs favoritos"]
  I --> J["repo.getLyric id"]
  J --> K{"Letra existe?"}
  K -- "não" --> L["Ignorar"]
  K -- "sim" --> M["Adicionar à lista favoriteLyrics"]
  L --> N{"Próximo ID?"}
  M --> N
  N -- "sim" --> I
  N -- "não" --> O{"favoriteLyrics vazio?"}
  O -- "sim" --> P["Snackbar Nenhuma música favorita encontrada"]
  O -- "não" --> Q["Ordenar por título"]
  Q --> R["audioService.playAll favoriteLyrics"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — A ação é disponibilizada apenas quando há IDs favoritos.
- 🟢 **CONFIRMADO** — Letras órfãs são ignoradas também na playlist.
- 🟢 **CONFIRMADO** — A playlist é ordenada por título antes de tocar.
- 🟢 **CONFIRMADO** — O fluxo chama `AudioPlayerService.playAll`, sem filtro explícito local na tela para remover letras sem áudio antes da chamada.

## Estados relevantes

```mermaid
stateDiagram-v2
  [*] --> PreferenciasCarregando
  PreferenciasCarregando --> SemFavoritos: carregou lista vazia ou erro
  PreferenciasCarregando --> ComFavoritos: carregou IDs
  SemFavoritos --> ComFavoritos: toggle adiciona ID
  ComFavoritos --> SemFavoritos: remover último ID
  ComFavoritos --> ComFavoritos: adicionar/remover mantendo outros IDs
  ComFavoritos --> FavoritosOrfaos: IDs salvos não existem no acervo local
  FavoritosOrfaos --> ComFavoritos: sync/acervo local volta a conter IDs
```

## Pontos de falha

| Falha | Comportamento legado | Confiança |
|---|---|---|
| Erro ao carregar `SharedPreferences` | Loga erro, marca carregado e continua com conjunto vazio | 🟢 |
| Erro ao salvar `SharedPreferences` | Loga erro, UI mantém estado em memória | 🟢 |
| ID favorito sem letra local | Ignora ID na lista e na playlist | 🟢 |
| Categoria da letra não encontrada | Exibe fallback `Categoria` e `??` | 🟢 |
| Tocar todas sem letras resolvidas | Snackbar `Nenhuma música favorita encontrada.` | 🟢 |
| Sincronização de favoritos entre aparelhos | Não existe no legado | 🟢 |

## Lacunas

- 🟡 **INFERIDO** — Não há rollback do estado em memória quando salvar em `SharedPreferences` falha.
- 🟡 **INFERIDO** — Não há rotina para limpar IDs órfãos da chave `favorite_lyrics`.
- 🟡 **INFERIDO** — Não há otimização em lote para resolver muitos favoritos; o legado usa chamadas sequenciais a `getLyric`.

