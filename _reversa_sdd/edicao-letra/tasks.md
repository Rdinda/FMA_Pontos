# Edição de Letra — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Modelo `Lyric` implementado com serialização local/remota.
- [ ] 🟢 Tabela local `lyrics` contém `audio_url`, `youtube_link` e `sequence_number`.
- [ ] 🟢 `SyncRepository` expõe `addLyric`, `deleteLyric` e `getNextSequenceNumber`.
- [ ] 🟢 `SupabaseService` expõe `uploadAudio`, `deleteAudioByUrl`, `upsertLyric` e `deleteLyric`.
- [ ] 🟢 `AuthService` expõe gates de criação, edição e exclusão nos fluxos chamadores.
- [ ] 🟢 Dependências `uuid`, `file_picker` e `youtube_player_flutter` disponíveis.

## Tarefas

- [ ] T-01, Implementar modelo `Lyric` com mídia e sequência
  - Origem no legado: `lib/models/lyric.dart`
  - Critério de pronto: modelo contém `audioUrl`, `localAudioPath`, `youtubeLink`, `sequenceNumber`, flags de sync/delete e serialização para SQLite/Supabase.
  - Confiança: 🟢

- [ ] T-02, Implementar schema local de letras
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: tabela `lyrics` contém `id`, `category_id`, `title`, `content`, `updated_at`, `is_synced`, `is_deleted`, `audio_url`, `local_audio_path`, `youtube_link`, `sequence_number`.
  - Confiança: 🟢

- [ ] T-03, Implementar migrações locais de mídia e sequência
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: upgrades adicionam `audio_url`, `local_audio_path`, `youtube_link` e `sequence_number` para bancos antigos.
  - Confiança: 🟢

- [ ] T-04, Implementar `LyricFormScreen`
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: tela recebe `categoryId` obrigatório e `Lyric? lyric`, renderizando `Nova Letra` ou `Editar Letra` conforme modo.
  - Confiança: 🟢

- [ ] T-05, Implementar estado e controllers do formulário
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: estado possui controllers de título, YouTube e conteúdo, `_audioUrl`, `_isUploadingAudio`, e descarta controllers em `dispose`.
  - Confiança: 🟢

- [ ] T-06, Implementar preenchimento em modo edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em edição, título, YouTube, conteúdo e URL de áudio são inicializados a partir de `widget.lyric`.
  - Confiança: 🟢

- [ ] T-07, Implementar conversão de conteúdo JSON legado
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: `_initContent` tenta decodificar conteúdo iniciado por `[` ou `{`, concatena valores `insert` quando for lista de ops e usa fallback texto plano em erro.
  - Confiança: 🟢

- [ ] T-08, Implementar layout do formulário
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: tela tem campo título, bloco de áudio, campo YouTube e campo expandido de letra, além de ações salvar/excluir no AppBar.
  - Confiança: 🟢

- [ ] T-09, Implementar validação de título
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: `_save()` retorna sem persistir quando título está vazio.
  - Confiança: 🟢

- [ ] T-10, Implementar validação de YouTube
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: link não vazio precisa passar por `YoutubePlayer.convertUrlToId`; falha mostra snackbar `Link do YouTube inválido.` e bloqueia save.
  - Confiança: 🟢

- [ ] T-11, Implementar criação de letra
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: modo criação calcula próxima sequência, cria `Lyric` com UUID e chama `SyncRepository.addLyric`.
  - Confiança: 🟢

- [ ] T-12, Implementar edição de letra
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: modo edição cria `Lyric` preservando `id` e `sequenceNumber`, atualiza `updatedAt`, define `isSynced=false` e chama `addLyric`.
  - Confiança: 🟢

- [ ] T-13, Implementar upsert local offline-first
  - Origem no legado: `lib/services/db_helper.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: `addLyric` salva localmente via `upsertLyric`, notifica listeners e tenta push remoto apenas se não estiver offline.
  - Confiança: 🟢

- [ ] T-14, Implementar push remoto e marcação sincronizada
  - Origem no legado: `lib/services/sync_repository.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: se online, `upsertLyric` remoto é chamado e sucesso marca `is_synced = 1`; falha é logada e mantém pendência local.
  - Confiança: 🟢

- [ ] T-15, Implementar cálculo de sequência
  - Origem no legado: `lib/services/db_helper.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: `getNextSequenceNumber(categoryId)` retorna `MAX(sequence_number) + 1` para a categoria.
  - Confiança: 🟢

- [ ] T-16, Implementar seleção de arquivo de áudio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: `_pickAndUploadAudio` usa `FilePicker.pickFiles(type: FileType.audio)` e só prossegue quando há path.
  - Confiança: 🟢

- [ ] T-17, Implementar upload de áudio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: upload gera nome com UUID, sanitiza nome no service, grava em `audio/lyrics/` e retorna URL pública.
  - Confiança: 🟢

- [ ] T-18, Implementar estado visual de upload
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: enquanto upload está ativo, `_isUploadingAudio = true` e UI exibe `CircularProgressIndicator`.
  - Confiança: 🟢

- [ ] T-19, Implementar autosave após upload em edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em modo edição, upload com URL salva imediatamente uma nova versão da letra com `audioUrl` atualizado.
  - Confiança: 🟢

- [ ] T-20, Implementar remoção de áudio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: `_removeAudio` chama `deleteAudioByUrl`, limpa `_audioUrl` e exibe feedback de remoção quando aplicável.
  - Confiança: 🟢

- [ ] T-21, Implementar autosave após remoção em edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em modo edição, remoção de áudio salva imediatamente nova versão da letra com `audioUrl = null`.
  - Confiança: 🟢

- [ ] T-22, Implementar exclusão no formulário
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em modo edição, botão excluir abre confirmação; confirmar chama `SyncRepository.deleteLyric(id)` e fecha o formulário retornando `true`.
  - Confiança: 🟢

- [ ] T-23, Implementar delete local/remoto de letra
  - Origem no legado: `lib/services/sync_repository.dart`, `lib/services/db_helper.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: delete faz soft delete local, notifica listeners e, quando online, remove/soft-delete remoto conforme decisão da reconstrução e finaliza com hard delete local.
  - Confiança: 🟡

- [ ] T-24, Implementar gates externos de permissão
  - Origem no legado: `lib/screens/category_screen.dart`, `lib/screens/lyric_view_screen.dart`, `lib/services/auth_service.dart`
  - Critério de pronto: somente usuários permitidos conseguem abrir criação/edição/exclusão; formulário não deve ser ponto público de bypass.
  - Confiança: 🟡

- [ ] T-25, Definir feedback moderno para título/conteúdo inválidos
  - Origem no legado: lacunas em `_reversa_sdd/edicao-letra/design.md`
  - Critério de pronto: decidir se título vazio continua silencioso ou passa a exibir erro; decidir se conteúdo vazio deve ser bloqueado.
  - Confiança: 🟡

- [ ] T-26, Definir limpeza de arquivos órfãos em criação
  - Origem no legado: lacuna em `_reversa_sdd/edicao-letra/design.md`
  - Critério de pronto: decidir o que acontece com áudio enviado durante criação se usuário abandona ou remove antes de salvar.
  - Confiança: 🟡

## Tarefas de Teste

- [ ] TT-01, Testar modo criação
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: com `lyric == null`, AppBar mostra `Nova Letra`, campos iniciam vazios e botão excluir não aparece.
  - Confiança: 🟢

- [ ] TT-02, Testar modo edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: com `lyric != null`, AppBar mostra `Editar Letra`, campos são preenchidos e botão excluir aparece.
  - Confiança: 🟢

- [ ] TT-03, Testar conversão JSON legado
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: conteúdo `[{"insert":"A"},{"insert":"B"}]` resulta em campo texto `AB`.
  - Confiança: 🟢

- [ ] TT-04, Testar fallback de conteúdo
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: conteúdo texto simples ou JSON inválido é preservado como texto original.
  - Confiança: 🟢

- [ ] TT-05, Testar título vazio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: salvar com título vazio não chama `SyncRepository.addLyric`.
  - Confiança: 🟢

- [ ] TT-06, Testar YouTube inválido
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: link inválido mostra snackbar e não salva.
  - Confiança: 🟢

- [ ] TT-07, Testar YouTube vazio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: campo vazio salva `youtubeLink = null`.
  - Confiança: 🟢

- [ ] TT-08, Testar criação com sequência
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/sync_repository.dart`
  - Critério de pronto: criar letra chama `getNextSequenceNumber(categoryId)` e usa o número retornado.
  - Confiança: 🟢

- [ ] TT-09, Testar edição preservando id/sequência
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: editar letra mantém `id` e `sequenceNumber`, atualiza `updatedAt` e envia `isSynced=false`.
  - Confiança: 🟢

- [ ] TT-10, Testar upsert local offline
  - Origem no legado: `lib/services/sync_repository.dart`, `lib/services/db_helper.dart`
  - Critério de pronto: com `_isOffline=true`, `addLyric` grava localmente e não tenta push remoto.
  - Confiança: 🟢

- [ ] TT-11, Testar push remoto online
  - Origem no legado: `lib/services/sync_repository.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: com online e remote mockado com sucesso, `upsertLyric` remoto é chamado e letra é marcada sincronizada.
  - Confiança: 🟢

- [ ] TT-12, Testar seleção/upload de áudio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: picker com arquivo válido chama upload, mostra loading e grava URL em `_audioUrl`.
  - Confiança: 🟢

- [ ] TT-13, Testar erro de picker/upload
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: falha desliga `_isUploadingAudio` e exibe snackbar de erro apropriado.
  - Confiança: 🟢

- [ ] TT-14, Testar autosave de upload em edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em edição, upload bem-sucedido chama `addLyric` com `audioUrl` novo.
  - Confiança: 🟢

- [ ] TT-15, Testar remoção de áudio
  - Origem no legado: `lib/screens/lyric_form_screen.dart`, `lib/services/supabase_service.dart`
  - Critério de pronto: remover áudio chama `deleteAudioByUrl`, limpa `_audioUrl` e muda UI para nenhum áudio selecionado.
  - Confiança: 🟢

- [ ] TT-16, Testar autosave de remoção em edição
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: em edição, remover áudio chama `addLyric` com `audioUrl = null`.
  - Confiança: 🟢

- [ ] TT-17, Testar exclusão confirmada
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: confirmar dialog chama `deleteLyric(id)` e retorna `true`.
  - Confiança: 🟢

- [ ] TT-18, Testar cancelamento de exclusão
  - Origem no legado: `lib/screens/lyric_form_screen.dart`
  - Critério de pronto: cancelar dialog não chama `deleteLyric`.
  - Confiança: 🟢

- [ ] TT-19, Testar sanitização de nome de áudio
  - Origem no legado: `lib/services/supabase_service.dart`
  - Critério de pronto: nome com espaços/caracteres inseguros é convertido para path seguro em `audio/lyrics/`.
  - Confiança: 🟢

- [ ] TT-20, Testar gates externos de permissão
  - Origem no legado: `lib/services/auth_service.dart`, telas chamadoras
  - Critério de pronto: `anonymous` não abre criação/edição; `user` cria; `moderator` edita; `admin` exclui.
  - Confiança: 🟡

## Tarefas de Migração de Dados

- [ ] TM-01, Adicionar campos de mídia e YouTube em bancos locais antigos
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: bancos antigos recebem `audio_url`, `local_audio_path` e `youtube_link`.
  - Confiança: 🟢

- [ ] TM-02, Adicionar `sequence_number` em bancos locais antigos
  - Origem no legado: `lib/services/db_helper.dart`
  - Critério de pronto: bancos antigos recebem `sequence_number INTEGER NOT NULL DEFAULT 0`.
  - Confiança: 🟢

- [ ] TM-03, Garantir colunas remotas de mídia e sequência
  - Origem no legado: `supabase/migrations`, `supabase_schema.sql`
  - Critério de pronto: tabela remota `lyrics` contém `audio_url`, `youtube_link`, `sequence_number` e `is_deleted` compatíveis com sync.
  - Confiança: 🟢

## Ordem Sugerida

1. Implementar modelo `Lyric`, schema local e migrations.
2. Implementar DAO/repository para upsert, delete e sequência.
3. Implementar `LyricFormScreen` com modo criação/edição e layout básico.
4. Implementar conversão de conteúdo legado e validações.
5. Implementar criação/edição offline-first.
6. Implementar upload/remover áudio e autosaves em edição.
7. Implementar exclusão com confirmação.
8. Garantir gates externos de permissão nas telas chamadoras.
9. Adicionar testes de modelo, DAO, repository e widget.
10. Resolver decisões modernas: feedback de título/conteúdo, cleanup de órfãos e divergência de delete remoto.

## Lacunas Pendentes (🔴)

- 🟡 O formulário não mostra feedback quando título está vazio.
- 🟡 O formulário permite conteúdo vazio apesar da regra de domínio indicar conteúdo obrigatório.
- 🟡 Upload de áudio em criação pode deixar arquivo órfão se o usuário abandonar antes de salvar.
- 🟡 `SyncRepository.deleteLyric` online usa delete físico remoto, enquanto `SupabaseService.deleteLyric` implementa soft delete.
- 🟡 RBAC é aplicado por telas chamadoras, não pelo formulário em si.

