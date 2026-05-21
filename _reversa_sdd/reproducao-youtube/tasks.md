# Reprodução YouTube — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Dependência `youtube_player_flutter: ^9.1.3` no `pubspec.yaml`.
- [ ] 🟢 Modelo `Lyric` com campos base (`id`, `categoryId`, `title`, `content`, `updatedAt`).
- [ ] 🟢 Tabela `lyrics` no SQLite com suporte a migrations incrementais (`DbHelper`).
- [ ] 🟢 `SyncRepository` operacional para persistir letras local e remotamente.
- [ ] 🟢 `LyricViewScreen` como tela de detalhe da letra (hospedeira do player).
- [ ] 🟢 `AudioPlayerService` disponível para pausa cruzada ao alternar para vídeo.
- [ ] 🟢 Permissão de rede no Android/iOS para carregar embed YouTube.

## Tarefas

- [ ] T-01, Adicionar campo `youtubeLink` ao modelo `Lyric`
  - Origem no legado: `lib/models/lyric.dart`
  - Critério de pronto: propriedade `String? youtubeLink` presente no construtor; `toMap`, `fromMap` (com alias `youtube_url`) e `toSupabaseMap` incluem `youtube_link`.
  - Confiança: 🟢

- [ ] T-02, Migrar schema SQLite com coluna `youtube_link`
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: DDL inicial ou `ALTER TABLE lyrics ADD COLUMN youtube_link TEXT` executa em upgrade; leituras/escritas não falham em bases antigas.
  - Confiança: 🟢

- [ ] T-03, Adicionar campo de formulário "Link do YouTube"
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: `TextEditingController` com `labelText: "Link do YouTube"`, ícone `video_library`, pré-preenchimento em edição.
  - Confiança: 🟢

- [ ] T-04, Validar URL no save do formulário
  - Origem no legado: `lib/screens/lyric_form_screen.dart` → `_save()`
  - Critério de pronto: se URL não vazia e `YoutubePlayer.convertUrlToId(url) == null`, exibe snackbar "Link do YouTube inválido." e aborta persistência; URL vazia grava `youtubeLink: null`.
  - Confiança: 🟢

- [ ] T-05, Implementar `_initYoutubePlayer` na tela de detalhe
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: cria `YoutubePlayerController` somente quando `youtubeLink != null` e `convertUrlToId` retorna ID; flags `autoPlay: false`, `mute: false`, `enableCaption: true`.
  - Confiança: 🟢

- [ ] T-06, Implementar enum e estado `_PlayerMode`
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: estados `none`, `audio`, `video`; botões `Áudio`/`Vídeo` habilitados conforme `hasAudio` e `canPlayVideo`; texto orientativo em `none`.
  - Confiança: 🟢

- [ ] T-07, Implementar pausas cruzadas áudio ↔ vídeo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: ao escolher áudio, `pause()` no YouTube; ao escolher vídeo, `togglePlayPause()` no áudio se letra atual está tocando; ao fechar, pausa mídia do modo ativo.
  - Confiança: 🟢

- [ ] T-08, Renderizar widget `YoutubePlayer` no modo vídeo
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: quando `_playerMode == video` e controller existe, renderiza player com progress indicator, cores do tema e `bottomActions` (posição, barra, restante, velocidade, fullscreen).
  - Confiança: 🟢

- [ ] T-09, Recriar controller após refresh e edição
  - Origem no legado: `lib/screens/lyric_view_screen.dart` (`RefreshIndicator`, retorno de `LyricFormScreen`)
  - Critério de pronto: `dispose()` do controller antigo, `_initYoutubePlayer()` com letra atualizada; se modo atual ficou inválido (`audio` sem áudio ou `video` sem controller), volta para `none`.
  - Confiança: 🟢

- [ ] T-10, Liberar controller no dispose da tela
  - Origem no legado: `lib/screens/lyric_view_screen.dart` → `dispose()`
  - Critério de pronto: `_youtubeController?.dispose()` sempre que instanciado.
  - Confiança: 🟢

- [ ] T-11, Propagar `youtubeLink` no sync
  - Origem no legado: `lib/services/sync_repository.dart`
  - Critério de pronto: push/pull de letras preserva `youtubeLink` sem perda ou renomeação indevida.
  - Confiança: 🟢

- [ ] T-12, Exibir card "Sem mídia" quando não há áudio nem vídeo válido
  - Origem no legado: `lib/screens/lyric_view_screen.dart`
  - Critério de pronto: mensagem orientando adicionar MP3 ou link YouTube quando `!hasAudio && !canPlayVideo`.
  - Confiança: 🟢

- [ ] T-13, Indicador opcional de vídeo em tiles de categoria
  - Origem no legado: `lib/screens/category_screen.dart`
  - Critério de pronto: `hasVideo` derivado de `youtubeLink?.isNotEmpty`; documentar limitação vs validação por ID.
  - Confiança: 🟡

- [ ] T-14, Testes unitários de serialização do link
  - Origem no legado: `test/unit/lyric_test.dart`
  - Critério de pronto: testes cobrem `youtubeLink` presente, `null` e `toSupabaseMap`; CI passa.
  - Confiança: 🟢

## Tarefas futuras (não implementadas no legado)

- [ ] T-15, Tratar erro de embed indisponível com UI dedicada
  - Origem: lacuna 🔴 identificada na análise
  - Critério de pronto: quando player falha (vídeo removido/privado), usuário vê mensagem acionável em vez de player vazio.
  - Confiança: 🔴

- [ ] T-16, Alinhar `hasVideo` em listas com `convertUrlToId`
  - Origem: inconsistência 🟡 entre lista e detalhe
  - Critério de pronto: indicador de vídeo só aparece quando ID é extraível.
  - Confiança: 🟡

## Ordem sugerida de implementação

1. T-01 → T-02 (modelo e schema)
2. T-03 → T-04 (captura e validação)
3. T-11 (sync)
4. T-05 → T-10 (player na tela de detalhe)
5. T-12, T-13 (UX complementar)
6. T-14 (testes)

## Definição de pronto da unit

- [ ] Link YouTube válido persiste, sincroniza e reproduz na tela de detalhe.
- [ ] Link inválido é bloqueado no formulário.
- [ ] Áudio e vídeo não tocam simultaneamente na mesma tela.
- [ ] Controller é recriado/descartado corretamente em refresh, edição e dispose.
- [ ] Testes unitários de serialização passam.
