# Visualização de Letra — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a tela de detalhe de uma letra/ponto, incluindo conteúdo textual, referência da categoria, mídia de áudio, mídia YouTube, favoritos, refresh e ações editoriais.  
🟢 **CONFIRMADO** — A tela recebe uma instância de `Lyric` por navegação e carrega a `Category` associada localmente via `SyncRepository`.  
🟢 **CONFIRMADO** — Consulta e reprodução são públicas; edição e exclusão dependem de permissões RBAC.

## Responsabilidades

- 🟢 **CONFIRMADO** — Exibir título da letra em caixa alta.
- 🟢 **CONFIRMADO** — Compor o título do AppBar com `category.code + sequenceNumber` quando a categoria carregada possui código.
- 🟢 **CONFIRMADO** — Exibir o conteúdo textual completo da letra.
- 🟢 **CONFIRMADO** — Carregar categoria local pelo `categoryId` da letra.
- 🟢 **CONFIRMADO** — Inicializar player YouTube quando `youtubeLink` contém URL reconhecida.
- 🟢 **CONFIRMADO** — Exibir card de seleção de mídia quando há áudio ou vídeo disponível.
- 🟢 **CONFIRMADO** — Exibir mensagem de ausência de mídia quando não há áudio nem vídeo válido.
- 🟢 **CONFIRMADO** — Permitir escolher entre modo de player `Áudio`, `Vídeo` ou nenhum.
- 🟢 **CONFIRMADO** — Pausar YouTube ao escolher áudio.
- 🟢 **CONFIRMADO** — Pausar áudio ao escolher vídeo.
- 🟢 **CONFIRMADO** — Permitir reproduzir/pausar áudio da letra via `AudioPlayerService`.
- 🟢 **CONFIRMADO** — Permitir buscar posição no áudio quando a letra atual está carregada no serviço.
- 🟢 **CONFIRMADO** — Permitir favoritar/desfavoritar a letra no modo de áudio.
- 🟢 **CONFIRMADO** — Permitir refresh manual que sincroniza dados e recarrega a letra local.
- 🟢 **CONFIRMADO** — Permitir edição para usuários com `canEditLyrics`.
- 🟢 **CONFIRMADO** — Permitir exclusão para usuários com `canDeleteLyrics`.

## Regras de Negócio

- 🟢 **CONFIRMADO** — A tela usa a `Lyric` recebida como estado inicial.
- 🟢 **CONFIRMADO** — Categoria é carregada por `SyncRepository.getCategory(_lyric.categoryId)`.
- 🟢 **CONFIRMADO** — Se a categoria carregada possui `code`, o título usa formato `{code}{sequenceNumber com 2 dígitos} - {title em caixa alta}`.
- 🟢 **CONFIRMADO** — Se a categoria não carrega ou não possui código, o título usa apenas `title.toUpperCase()`.
- 🟢 **CONFIRMADO** — Uma letra tem áudio se `audioUrl` ou `localAudioPath` está preenchido após `trim`.
- 🟢 **CONFIRMADO** — Uma letra tem vídeo reproduzível se `YoutubePlayer.convertUrlToId(youtubeLink)` retorna ID válido.
- 🟢 **CONFIRMADO** — O YouTube controller usa `autoPlay: false`, `mute: false` e `enableCaption: true`.
- 🟢 **CONFIRMADO** — `_PlayerMode.none` exibe orientação para escolher um player.
- 🟢 **CONFIRMADO** — Ao acionar modo áudio, o controller YouTube é pausado.
- 🟢 **CONFIRMADO** — Ao acionar modo vídeo, se houver áudio tocando, `AudioPlayerService.togglePlayPause()` é chamado antes de trocar o modo.
- 🟢 **CONFIRMADO** — Ao fechar o player, se o modo era áudio e a letra atual estava tocando, o áudio é pausado; se era vídeo, o YouTube é pausado.
- 🟢 **CONFIRMADO** — Refresh executa `SyncRepository.syncData()` e depois tenta recarregar a letra por ID.
- 🟢 **CONFIRMADO** — Depois de edição, a tela recarrega a letra local, reinicializa YouTube e ajusta o modo se a mídia atual deixou de existir.
- 🟢 **CONFIRMADO** — Se o formulário de edição retorna `true`, a tela de visualização é fechada.
- 🟢 **CONFIRMADO** — Exclusão confirma em dialog, chama `SyncRepository.deleteLyric(_lyric.id)` e fecha a tela.
- 🟢 **CONFIRMADO** — Botão editar aparece para `moderator` e `admin`.
- 🟢 **CONFIRMADO** — Botão excluir aparece apenas para `admin`.
- 🟢 **CONFIRMADO** — Favoritar localmente não exige autenticação.
- 🟡 **INFERIDO** — A tela não possui estado de erro explícito para falha de refresh, carregamento de categoria ou exclusão.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve abrir a visualização a partir de uma `Lyric` existente. | Must | Dado uma letra recebida por navegação, quando `LyricViewScreen` inicializa, então `_lyric` deve copiar `widget.lyric`. |
| RF-02 | 🟢 O sistema deve carregar a categoria associada à letra. | Should | Dado `categoryId`, quando a tela inicializa, então deve chamar `SyncRepository.getCategory(categoryId)` e atualizar `_category` se encontrada. |
| RF-03 | 🟢 O sistema deve exibir referência com código e sequência quando disponíveis. | Should | Dado categoria com `code` e letra com `sequenceNumber`, quando o AppBar renderiza, então o título segue `{code}{sequenceNumber.padLeft(2)} - {title.toUpperCase()}`. |
| RF-04 | 🟢 O sistema deve exibir conteúdo completo da letra. | Must | Dado uma letra, quando a tela renderiza, então `lyric.content` aparece no painel textual. |
| RF-05 | 🟢 O sistema deve detectar áudio disponível. | Must | Dado `audioUrl` ou `localAudioPath` preenchido, quando a tela renderiza, então o botão `Áudio` fica disponível. |
| RF-06 | 🟢 O sistema deve detectar vídeo YouTube válido. | Must | Dado `youtubeLink` conversível para ID, quando a tela inicializa, então cria `YoutubePlayerController` e habilita botão `Vídeo`. |
| RF-07 | 🟢 O sistema deve exibir aviso quando não há mídia. | Should | Dado letra sem áudio e sem vídeo válido, quando a tela renderiza, então mostra mensagem "Sem mídia para tocar...". |
| RF-08 | 🟢 O sistema deve permitir alternar para modo áudio. | Must | Dado áudio disponível, quando usuário toca `Áudio`, então YouTube pausa e `_playerMode` vira `audio`. |
| RF-09 | 🟢 O sistema deve permitir alternar para modo vídeo. | Must | Dado vídeo disponível, quando usuário toca `Vídeo`, então áudio em reprodução é pausado e `_playerMode` vira `video`. |
| RF-10 | 🟢 O sistema deve permitir fechar o player ativo. | Should | Dado `_playerMode != none`, quando usuário toca fechar, então mídia ativa pausa e `_playerMode` vira `none`. |
| RF-11 | 🟢 O sistema deve reproduzir áudio da letra. | Must | Dado modo áudio e áudio disponível, quando usuário toca play, então `AudioPlayerService.play(_lyric)` é chamado. |
| RF-12 | 🟢 O sistema deve exibir duração, posição e slider do áudio atual. | Should | Dado `AudioPlayerService.currentLyric.id == _lyric.id`, quando a UI renderiza, então usa `duration`, `position` e permite `seek`. |
| RF-13 | 🟢 O sistema deve permitir favoritar/desfavoritar no modo áudio. | Should | Dado modo áudio, quando usuário toca coração, então `FavoritesService.toggleFavorite(_lyric.id)` executa e snackbar informa o resultado. |
| RF-14 | 🟢 O sistema deve renderizar player YouTube no modo vídeo. | Must | Dado `_playerMode == video` e controller válido, quando a UI renderiza, então exibe `YoutubePlayer` com barra de progresso e controles. |
| RF-15 | 🟢 O sistema deve permitir refresh da letra. | Should | Dado a tela aberta, quando usuário puxa para atualizar, então `syncData()` roda e a letra é recarregada por ID se existir. |
| RF-16 | 🟢 O sistema deve atualizar mídia após refresh ou edição. | Must | Dado letra recarregada com mudanças em áudio/vídeo, quando estado atualiza, então controller YouTube é recriado e modo inválido volta para `none`. |
| RF-17 | 🟢 O sistema deve permitir edição para quem pode editar letras. | Must | Dado `AuthService.canEditLyrics == true`, quando AppBar renderiza, então botão editar aparece e abre `LyricFormScreen`. |
| RF-18 | 🟢 O sistema deve ocultar edição para quem não pode editar letras. | Must | Dado usuário sem `canEditLyrics`, quando AppBar renderiza, então botão editar não aparece. |
| RF-19 | 🟢 O sistema deve permitir exclusão para quem pode excluir letras. | Must | Dado `AuthService.canDeleteLyrics == true`, quando AppBar renderiza, então botão excluir aparece e confirma antes de chamar `deleteLyric`. |
| RF-20 | 🟢 O sistema deve ocultar exclusão para quem não pode excluir letras. | Must | Dado usuário sem `canDeleteLyrics`, quando AppBar renderiza, então botão excluir não aparece. |
| RF-21 | 🟢 O sistema deve liberar recursos do YouTube ao fechar a tela. | Must | Dado controller YouTube criado, quando a tela é descartada, então `_youtubeController.dispose()` é chamado. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Operação offline | Tela deve renderizar letra e categoria a partir do estado local. | `LyricViewScreen`, `SyncRepository.getCategory`, `getLyric` | 🟢 |
| Consistência de mídia | Áudio e vídeo não devem tocar simultaneamente ao alternar modos. | `_playerMode`, pausas cruzadas | 🟢 |
| Responsividade | Conteúdo é limitado a `maxWidth: 600` dentro de scroll. | `ConstrainedBox(maxWidth: 600)` | 🟢 |
| Acessibilidade básica | Botões de editar, excluir e favorito têm tooltips. | `IconButton.tooltip` | 🟢 |
| Segurança | Edição/exclusão dependem de `AuthService` e não aparecem sem permissão. | `Consumer<AuthService>` | 🟢 |
| Resiliência | Categoria ausente não impede leitura da letra. | Título cai para `title.toUpperCase()` | 🟢 |
| Gestão de recursos | Controller YouTube deve ser descartado e recriado quando necessário. | `dispose`, refresh/edit reload | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que uma letra possui categoria com código "OX" e sequenceNumber 1
Quando a tela de visualização renderiza o AppBar
Então o título deve começar com "OX01 - "

Dado que uma letra possui conteúdo textual
Quando a tela de visualização é aberta
Então o conteúdo completo da letra deve ser exibido

Dado que a letra possui audioUrl ou localAudioPath
Quando a tela renderiza a área de mídia
Então o botão Áudio deve estar habilitado

Dado que a letra possui youtubeLink válido
Quando a tela inicializa
Então o botão Vídeo deve estar habilitado
E o player YouTube deve aparecer ao selecionar Vídeo

Dado que áudio está tocando
Quando o usuário seleciona Vídeo
Então o áudio deve ser pausado antes de mostrar o player de vídeo

Dado que vídeo está ativo
Quando o usuário seleciona Áudio
Então o YouTube deve ser pausado antes de trocar o modo para áudio

Dado que o usuário tem role moderator
Quando abre a tela de visualização
Então o botão editar deve estar disponível
E o botão excluir não deve estar disponível

Dado que o usuário tem role admin
Quando abre a tela de visualização
Então os botões editar e excluir devem estar disponíveis

Dado que o usuário puxa a tela para atualizar
Quando a sincronização termina e a letra ainda existe localmente
Então a tela deve atualizar o conteúdo, mídia e modo de player conforme a nova letra
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Exibir título e conteúdo da letra | Must | 🟢 Valor principal da tela de detalhe. |
| Reproduzir áudio | Must | 🟢 Uso central para pontos com mídia. |
| Reproduzir YouTube válido | Must | 🟢 Feature explícita do legado para mídia externa. |
| Gates de editar/excluir | Must | 🟢 Necessário para preservar RBAC. |
| Dispose/recriação de YouTube controller | Must | 🟢 Evita vazamento e estado incorreto após edição/refresh. |
| Favoritar na tela | Should | 🟢 Conveniência já presente, mas a feature de favoritos existe em outra unit. |
| Refresh com sync | Should | 🟢 Importante para atualização manual, mas leitura local continua funcional. |
| Referência código+sequência | Should | 🟢 Importante para organização, mas a letra ainda é legível sem categoria carregada. |
| Reproduzir áudio e vídeo simultaneamente | Won't | 🟢 A tela pausa uma mídia ao alternar para a outra. |
| Editar/excluir sem permissão | Won't | 🟢 Bloqueado por RBAC. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/screens/lyric_view_screen.dart` | `LyricViewScreen`, `_LyricViewScreenState` | 🟢 |
| `lib/models/lyric.dart` | `Lyric`, campos de texto/mídia/sync | 🟢 |
| `lib/models/category.dart` | `Category.code`, `Category.name` | 🟢 |
| `lib/services/sync_repository.dart` | `getCategory`, `getLyric`, `deleteLyric`, `syncData` | 🟢 |
| `lib/services/audio_player_service.dart` | `play`, `togglePlayPause`, `seek`, `duration`, `position`, `currentLyric` | 🟢 |
| `lib/services/favorites_service.dart` | `isFavorite`, `toggleFavorite` | 🟢 |
| `lib/services/auth_service.dart` | `canEditLyrics`, `canDeleteLyrics` | 🟢 |
| `lib/screens/lyric_form_screen.dart` | destino de edição | 🟢 |
| `youtube_player_flutter` | `YoutubePlayer`, `YoutubePlayerController`, `convertUrlToId` | 🟢 |

