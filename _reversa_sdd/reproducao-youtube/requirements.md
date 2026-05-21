# Reprodução YouTube — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre reprodução de vídeo YouTube associada a uma letra/ponto: persistência do link, conversão de URL para ID, ciclo de vida do `YoutubePlayerController`, renderização do player embutido e exclusividade mútua com o player de áudio.  
🟢 **CONFIRMADO** — O app usa o pacote `youtube_player_flutter` (^9.1.3) e o campo `Lyric.youtubeLink` mapeado para `youtube_link` no SQLite e Supabase.  
🟢 **CONFIRMADO** — A reprodução ocorre na `LyricViewScreen`; não há playlist nem player compacto para vídeo — apenas faixa única embutida na tela de detalhe.  
🟡 **INFERIDO** — Indicadores de vídeo em listas (`CategoryScreen`) usam presença de string no link, não validação de ID; links inválidos podem exibir ícone sem player funcional no detalhe.

## Responsabilidades

- 🟢 **CONFIRMADO** — Persistir `youtube_link` opcional por letra no modelo local e remoto.
- 🟢 **CONFIRMADO** — Converter URL YouTube em `videoId` via `YoutubePlayer.convertUrlToId`.
- 🟢 **CONFIRMADO** — Criar `YoutubePlayerController` somente quando a conversão retorna ID válido.
- 🟢 **CONFIRMADO** — Configurar flags do player: `autoPlay: false`, `mute: false`, `enableCaption: true`.
- 🟢 **CONFIRMADO** — Renderizar `YoutubePlayer` com barra de progresso, velocidade e tela cheia quando o modo vídeo está ativo.
- 🟢 **CONFIRMADO** — Pausar YouTube ao alternar para modo áudio ou ao fechar o player.
- 🟢 **CONFIRMADO** — Pausar áudio em reprodução ao alternar para modo vídeo.
- 🟢 **CONFIRMADO** — Recriar controller após edição, refresh ou mudança de `youtubeLink`.
- 🟢 **CONFIRMADO** — Liberar controller no `dispose` da tela.
- 🟢 **CONFIRMADO** — Bloquear salvamento de link inválido no formulário (validação na unit `edicao-letra`, consumida aqui).
- 🟢 **CONFIRMADO** — Sincronizar `youtubeLink` no push/pull de letras via `SyncRepository`.
- 🟡 **INFERIDO** — Exibir indicador visual de vídeo em tiles de categoria quando `youtubeLink` não está vazio.

## Regras de Negócio

- 🟢 **CONFIRMADO** — `youtubeLink` é opcional; ausência significa letra sem vídeo.
- 🟢 **CONFIRMADO** — `Lyric.fromMap` aceita alias legado `youtube_url` além de `youtube_link`.
- 🟢 **CONFIRMADO** — Link vazio no formulário persiste como `null`, não string vazia.
- 🟢 **CONFIRMADO** — URL inválida (sem `videoId` extraível) bloqueia `_save()` com snackbar "Link do YouTube inválido.".
- 🟢 **CONFIRMADO** — Vídeo reproduzível na tela de detalhe exige `YoutubePlayer.convertUrlToId(youtubeLink) != null`, não apenas string não vazia.
- 🟢 **CONFIRMADO** — `_initYoutubePlayer` só instancia controller quando `youtubeLink != null` e `videoId != null`.
- 🟢 **CONFIRMADO** — Modo vídeo não inicia automaticamente; usuário deve tocar botão `Vídeo` após `_PlayerMode.none`.
- 🟢 **CONFIRMADO** — Ao escolher `Áudio`, `_youtubeController?.pause()` executa antes de `_playerMode = audio`.
- 🟢 **CONFIRMADO** — Ao escolher `Vídeo`, se `AudioPlayerService.isPlaying` para a letra atual, `togglePlayPause()` pausa o áudio.
- 🟢 **CONFIRMADO** — Ao fechar player (`_PlayerMode.none`), pausa YouTube se modo era vídeo e pausa áudio se modo era áudio e letra atual está tocando.
- 🟢 **CONFIRMADO** — Após recarregar letra (refresh/edição), controller anterior é `dispose()` e recriado; modo inválido volta para `none`.
- 🟢 **CONFIRMADO** — Não há integração de YouTube com `AudioPlayerService`, notificação de mídia nem `playAll`.
- 🟡 **INFERIDO** — Reprodução YouTube requer conectividade; offline o botão `Vídeo` fica desabilitado se controller não foi criado.
- 🔴 **LACUNA** — Política de embed restrito (vídeo privado, idade, região) não tem tratamento explícito na UI além do comportamento padrão do widget.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O modelo deve expor `youtubeLink` serializável. | Must | Dado letra com link, quando `toMap`/`toSupabaseMap`, então chave `youtube_link` contém URL; `fromMap` restaura valor. |
| RF-02 | 🟢 O sistema deve migrar coluna `youtube_link` no SQLite. | Must | Dado banco existente, quando `DbHelper` inicializa, então `ALTER TABLE lyrics ADD COLUMN youtube_link` executa se necessário. |
| RF-03 | 🟢 O formulário deve rejeitar URL YouTube inválida. | Must | Dado URL sem `videoId`, quando usuário salva, então snackbar de erro e letra não persiste. |
| RF-04 | 🟢 A tela de detalhe deve inicializar player somente com ID válido. | Must | Dado `youtubeLink` conversível, quando `initState`, então `YoutubePlayerController(initialVideoId: videoId)` existe. |
| RF-05 | 🟢 A tela de detalhe não deve criar player para link inválido. | Must | Dado `youtubeLink` não conversível, quando `initState`, então `_youtubeController` permanece `null` e botão `Vídeo` desabilitado. |
| RF-06 | 🟢 O sistema deve aplicar flags padrão do player. | Should | Dado controller criado, quando flags são lidas, então `autoPlay=false`, `mute=false`, `enableCaption=true`. |
| RF-07 | 🟢 O sistema deve renderizar player embutido no modo vídeo. | Must | Dado `_playerMode == video` e controller válido, quando UI renderiza, então `YoutubePlayer` aparece com `showVideoProgressIndicator: true`. |
| RF-08 | 🟢 O player deve expor controles de posição, velocidade e fullscreen. | Should | Dado modo vídeo, quando player renderiza, então `bottomActions` inclui `CurrentPosition`, `ProgressBar`, `RemainingDuration`, `PlaybackSpeedButton`, `FullScreenButton`. |
| RF-09 | 🟢 O sistema deve pausar YouTube ao selecionar áudio. | Must | Dado vídeo carregado, quando usuário toca `Áudio`, então `pause()` no controller YouTube antes de mudar modo. |
| RF-10 | 🟢 O sistema deve pausar áudio ao selecionar vídeo. | Must | Dado áudio tocando na letra atual, quando usuário toca `Vídeo`, então `togglePlayPause()` no `AudioPlayerService`. |
| RF-11 | 🟢 O sistema deve pausar mídia ao fechar o card de player. | Should | Dado player ativo, quando usuário toca fechar, então mídia do modo atual pausa e modo volta para `none`. |
| RF-12 | 🟢 O sistema deve recriar player após mudança de link. | Must | Dado letra recarregada com `youtubeLink` alterado, quando `setState` pós-refresh/edição, então controller antigo é descartado e `_initYoutubePlayer` roda de novo. |
| RF-13 | 🟢 O sistema deve ajustar modo quando mídia deixa de existir. | Must | Dado modo `video` sem controller válido após reload, então `_playerMode` volta para `none`. |
| RF-14 | 🟢 O sistema deve liberar recursos ao sair da tela. | Must | Dado tela descartada, quando `dispose`, então `_youtubeController?.dispose()` executa. |
| RF-15 | 🟢 O sync deve propagar `youtubeLink` em push e pull. | Must | Dado letra com link, quando `SyncRepository` sincroniza, então campo persiste local e remoto. |
| RF-16 | 🟡 Listas podem indicar presença de link de vídeo. | Could | Dado tile de categoria, quando `youtubeLink?.isNotEmpty`, então UI pode sinalizar vídeo (sem garantir ID válido). |
| RF-17 | 🟢 Testes unitários devem cobrir serialização do link. | Should | Dado `Lyric` com/sem `youtubeLink`, quando testes rodam, então `toMap`/`fromMap`/`toSupabaseMap` preservam valor. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Dependência externa | Playback depende da API/embed do YouTube e rede. | `youtube_player_flutter`, player embutido | 🟢 |
| Exclusividade de mídia | Áudio e vídeo não devem tocar simultaneamente na mesma tela. | Pausas cruzadas em `_PlayerMode` | 🟢 |
| Recursos | Controller deve ser descartado para evitar vazamento. | `dispose` em tela e antes de recriar | 🟢 |
| Acessibilidade | Legendas habilitadas por padrão no embed. | `enableCaption: true` | 🟢 |
| UX | Autoplay desligado para não iniciar vídeo sem ação do usuário. | `autoPlay: false` | 🟢 |
| Consistência de dados | Alias `youtube_url` suportado na leitura local legada. | `Lyric.fromMap` | 🟢 |
| Privacidade | Reproduzir vídeo não exige role específica. | Sem gate RBAC no player | 🟢 |
| Resiliência embed | Falhas de vídeo indisponível não têm UI customizada. | Sem handler de erro explícito | 🔴 |

## Critérios de Aceitação

```gherkin
Dado uma letra com youtubeLink válido (youtu.be ou youtube.com)
Quando LyricViewScreen abre
Então YoutubePlayerController é criado com o videoId extraído

Dado uma letra com youtubeLink preenchido mas inválido
Quando LyricViewScreen abre
Então não há controller YouTube e o botão Vídeo fica desabilitado

Dado uma letra sem youtubeLink
Quando LyricViewScreen abre
Então não há controller YouTube

Dado modo vídeo ativo
Quando o usuário toca o botão Áudio
Então o YouTube pausa e o modo muda para áudio

Dado áudio da letra atual em reprodução
Quando o usuário toca o botão Vídeo
Então o áudio pausa e o modo muda para vídeo

Dado modo vídeo ativo
Quando o usuário toca fechar no card de mídia
Então o YouTube pausa e o modo volta para none

Dado formulário com URL YouTube inválida
Quando o usuário salva a letra
Então aparece "Link do YouTube inválido." e nada é persistido

Dado letra salva com link válido
Quando sync push/pull executa
Então youtube_link permanece consistente entre SQLite e Supabase

Dado controller YouTube criado
Quando a tela é fechada
Então dispose() do controller é chamado
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Persistência e sync de `youtube_link` | Must | 🟢 Base de dados da feature. |
| Validação de URL no save | Must | 🟢 Evita links quebrados no acervo. |
| Player embutido no detalhe | Must | 🟢 Entrega principal da feature. |
| Exclusividade áudio/vídeo | Must | 🟢 UX e recurso de dispositivo. |
| Recriação/dispose do controller | Must | 🟢 Estabilidade ao editar/refresh. |
| Controles avançados (speed, fullscreen) | Should | 🟢 Já fornecidos pelo widget. |
| Indicador de vídeo em listas | Could | 🟡 Heurística fraca (`isNotEmpty`). |
| Playlist YouTube | Won't | 🟢 Não implementado; só áudio tem `playAll`. |
| Player em background/notificação | Won't | 🟢 Escopo do `audio_service`, não YouTube. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/models/lyric.dart` | `youtubeLink`, `toMap`, `fromMap`, `toSupabaseMap` | 🟢 |
| `lib/services/db_helper.dart` | DDL `youtube_link`, migration `ALTER TABLE` | 🟢 |
| `lib/screens/lyric_view_screen.dart` | `_initYoutubePlayer`, `_PlayerMode`, `YoutubePlayer` | 🟢 |
| `lib/screens/lyric_form_screen.dart` | validação `convertUrlToId`, campo YouTube | 🟢 |
| `lib/screens/category_screen.dart` | `hasVideo` em tile | 🟡 |
| `lib/services/sync_repository.dart` | push/pull com `youtubeLink` | 🟢 |
| `test/unit/lyric_test.dart` | serialização `youtube_link` | 🟢 |
| `pubspec.yaml` | `youtube_player_flutter: ^9.1.3` | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `visualizacao-letra` | Hospeda o card de mídia e alternância de modos na mesma tela. |
| `edicao-letra` | Responsável por capturar e validar o link no formulário. |
| `reproducao-audio` | Compartilha exclusividade mútua; não compartilha engine de playback. |
| `sincronizacao-offline` | Propaga `youtube_link` entre local e Supabase. |
