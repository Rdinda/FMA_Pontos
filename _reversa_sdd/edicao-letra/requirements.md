# Edição de Letra — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre criação, edição, remoção, validação de YouTube e anexação/remoção de áudio de letras/pontos.  
🟢 **CONFIRMADO** — A tela de formulário opera em dois modos: nova letra quando `lyric == null` e edição quando `lyric != null`.  
🟢 **CONFIRMADO** — A persistência de letras é offline-first via `SyncRepository.addLyric`, com push remoto assíncrono quando há conectividade.  
🟢 **CONFIRMADO** — A regra de acesso é definida fora do formulário: usuários `user`, `moderator` e `admin` podem adicionar; apenas `moderator` e `admin` editam; apenas `admin` exclui.

## Responsabilidades

- 🟢 **CONFIRMADO** — Renderizar formulário com título, áudio, link YouTube e conteúdo da letra.
- 🟢 **CONFIRMADO** — Preencher campos com dados existentes quando a letra é editada.
- 🟢 **CONFIRMADO** — Converter conteúdo legado JSON com operações `insert` para texto plano no formulário.
- 🟢 **CONFIRMADO** — Permitir selecionar arquivo de áudio local via file picker.
- 🟢 **CONFIRMADO** — Fazer upload do áudio para Supabase Storage no bucket `audio`, pasta `lyrics/`.
- 🟢 **CONFIRMADO** — Atualizar automaticamente a letra após upload de áudio quando o formulário está em modo edição.
- 🟢 **CONFIRMADO** — Remover áudio do storage por URL e limpar `audioUrl` no formulário.
- 🟢 **CONFIRMADO** — Atualizar automaticamente a letra após remoção de áudio quando o formulário está em modo edição.
- 🟢 **CONFIRMADO** — Validar link YouTube não vazio usando `YoutubePlayer.convertUrlToId`.
- 🟢 **CONFIRMADO** — Criar nova letra com UUID, `categoryId`, `title`, `content`, `updatedAt`, `audioUrl`, `youtubeLink` e `sequenceNumber`.
- 🟢 **CONFIRMADO** — Calcular `sequenceNumber` de nova letra por `MAX(sequence_number) + 1` dentro da categoria.
- 🟢 **CONFIRMADO** — Atualizar letra existente preservando `id` e `sequenceNumber`.
- 🟢 **CONFIRMADO** — Marcar letra editada como não sincronizada.
- 🟢 **CONFIRMADO** — Excluir letra existente mediante confirmação.

## Regras de Negócio

- 🟢 **CONFIRMADO** — `categoryId` é obrigatório para abrir o formulário.
- 🟢 **CONFIRMADO** — O modo de criação é identificado por `widget.lyric == null`.
- 🟢 **CONFIRMADO** — O modo de edição é identificado por `widget.lyric != null`.
- 🟢 **CONFIRMADO** — Em edição, `title`, `youtubeLink`, `content` e `audioUrl` são preenchidos a partir da letra existente.
- 🟢 **CONFIRMADO** — Conteúdo que começa com `[` ou `{` é tentativamente decodificado como JSON.
- 🟢 **CONFIRMADO** — Se o JSON decodificado é uma lista de operações com chave `insert`, o formulário concatena os valores `insert`.
- 🟢 **CONFIRMADO** — Se a conversão JSON falha, o conteúdo é usado como texto plano.
- 🟢 **CONFIRMADO** — Título vazio impede salvar sem mensagem explícita.
- 🟡 **INFERIDO** — Conteúdo vazio não impede salvar, apesar de o domínio declarar que letra exige `content`.
- 🟢 **CONFIRMADO** — Link YouTube vazio é salvo como `null`.
- 🟢 **CONFIRMADO** — Link YouTube não vazio precisa ser aceito por `YoutubePlayer.convertUrlToId`; caso contrário, a tela exibe snackbar de erro e não salva.
- 🟢 **CONFIRMADO** — Nova letra recebe `Uuid().v4()`.
- 🟢 **CONFIRMADO** — Nova letra recebe `sequenceNumber = repo.getNextSequenceNumber(categoryId)`.
- 🟢 **CONFIRMADO** — Letra editada preserva `id` e `sequenceNumber` da letra original.
- 🟢 **CONFIRMADO** — `updatedAt` é atualizado para `DateTime.now()` ao salvar, anexar áudio em edição ou remover áudio em edição.
- 🟢 **CONFIRMADO** — `SyncRepository.addLyric` é usado tanto para criar quanto para atualizar.
- 🟢 **CONFIRMADO** — Exclusão no formulário chama `SyncRepository.deleteLyric(widget.lyric!.id)` e retorna `true` para a tela anterior.
- 🟢 **CONFIRMADO** — Upload de áudio gera nome com UUID prefixado ao nome original.
- 🟢 **CONFIRMADO** — `SupabaseService.uploadAudio` sanitiza nome, grava em `audio/lyrics/` e retorna URL pública.
- 🟢 **CONFIRMADO** — Remoção de áudio por URL extrai o último segmento do path e remove do storage.
- 🟡 **INFERIDO** — O formulário em si não checa RBAC; ele depende das telas que o abrem para respeitar permissões.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve abrir formulário de nova letra com `categoryId`. | Must | Dado `lyric == null`, quando a tela abre, então o AppBar mostra "Nova Letra" e os campos iniciam vazios. |
| RF-02 | 🟢 O sistema deve abrir formulário de edição com dados existentes. | Must | Dado `lyric != null`, quando a tela abre, então título, YouTube, conteúdo e áudio são preenchidos a partir da letra. |
| RF-03 | 🟢 O sistema deve converter conteúdo JSON legado para texto editável. | Should | Dado conteúdo JSON de ops com `insert`, quando `_initContent` executa, então o campo letra recebe a concatenação dos inserts. |
| RF-04 | 🟢 O sistema deve manter conteúdo como texto plano quando não for JSON válido. | Must | Dado conteúdo simples ou JSON inválido, quando `_initContent` executa, então o conteúdo original aparece no campo letra. |
| RF-05 | 🟢 O sistema deve impedir salvar sem título. | Must | Dado título vazio, quando usuário toca salvar, então nenhuma chamada a `addLyric` ocorre. |
| RF-06 | 🟢 O sistema deve validar link YouTube não vazio. | Must | Dado link YouTube inválido, quando usuário salva, então snackbar "Link do YouTube inválido." aparece e a letra não é salva. |
| RF-07 | 🟢 O sistema deve salvar link YouTube vazio como `null`. | Should | Dado campo YouTube vazio, quando salva, então `youtubeLink` da letra é `null`. |
| RF-08 | 🟢 O sistema deve criar nova letra com UUID e sequência automática. | Must | Dado formulário novo válido, quando salva, então cria `Lyric` com UUID e `sequenceNumber = getNextSequenceNumber(categoryId)`. |
| RF-09 | 🟢 O sistema deve preservar ID e sequência ao editar. | Must | Dado formulário de edição válido, quando salva, então a letra atualizada mantém `id` e `sequenceNumber` originais. |
| RF-10 | 🟢 O sistema deve persistir criação/edição via repository offline-first. | Must | Dado letra criada ou editada, quando salva, então `SyncRepository.addLyric(lyric)` é chamado. |
| RF-11 | 🟢 O sistema deve fechar o formulário após salvar. | Must | Dado save concluído e tela montada, quando termina, então `Navigator.pop(context)` é chamado. |
| RF-12 | 🟢 O sistema deve permitir anexar áudio. | Should | Dado usuário seleciona arquivo de áudio, quando upload conclui com URL, então `_audioUrl` recebe a URL e aparece "Áudio anexado". |
| RF-13 | 🟢 O sistema deve indicar upload em andamento. | Should | Dado upload de áudio em execução, quando tela renderiza, então aparece `CircularProgressIndicator`. |
| RF-14 | 🟢 O sistema deve atualizar letra automaticamente após upload em edição. | Should | Dado formulário editando letra, quando upload retorna URL, então uma nova versão da letra é salva com `audioUrl` atualizado. |
| RF-15 | 🟢 O sistema deve permitir remover áudio anexado. | Should | Dado `_audioUrl != null`, quando usuário remove áudio, então storage é chamado para excluir e `_audioUrl` vira `null`. |
| RF-16 | 🟢 O sistema deve atualizar letra automaticamente após remover áudio em edição. | Should | Dado formulário editando letra, quando áudio é removido, então uma nova versão da letra é salva com `audioUrl = null`. |
| RF-17 | 🟢 O sistema deve excluir letra existente com confirmação. | Must | Dado formulário em modo edição, quando usuário confirma exclusão, então `deleteLyric(id)` é chamado e a tela fecha retornando `true`. |
| RF-18 | 🟢 O sistema deve esconder ação de exclusão em modo criação. | Must | Dado `lyric == null`, quando AppBar renderiza, então não aparece botão excluir. |
| RF-19 | 🟢 O sistema deve serializar letra local/remota com campos de mídia e sequência. | Must | Dado uma letra salva, quando convertida por `Lyric.toMap` ou `toSupabaseMap`, então inclui `audio_url`, `youtube_link` e `sequence_number` conforme destino. |
| RF-20 | 🟢 O sistema deve marcar letras editadas como não sincronizadas. | Must | Dado edição, upload em edição ou remoção de áudio em edição, quando salva, então `isSynced` é falso no objeto enviado ao repository. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Operação offline | Texto e metadados devem salvar localmente antes de push remoto. | `SyncRepository.addLyric`, `DatabaseHelper.upsertLyric` | 🟢 |
| Integridade | Nova letra deve receber sequência única incremental por categoria. | `getNextSequenceNumber`, `getMaxSequenceNumber` | 🟢 |
| Consistência de mídia | Upload/remove áudio em edição deve persistir imediatamente a URL atual. | `_pickAndUploadAudio`, `_removeAudio` | 🟢 |
| Segurança | Acesso ao formulário deve respeitar gates externos de RBAC. | `permissions.md`, `AuthService` em telas chamadoras | 🟡 |
| Usabilidade | Upload deve mostrar progresso e feedback de sucesso/erro. | `_isUploadingAudio`, `SnackbarUtils` | 🟢 |
| Compatibilidade legado | Conteúdo JSON tipo editor rico deve virar texto plano. | `_initContent` | 🟢 |
| Resiliência | Falhas de picker/upload/remove são capturadas ou logadas. | `try/catch`, `debugPrint` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que o usuário abre o formulário para nova letra
Quando informa título, conteúdo e salva
Então o sistema deve criar uma letra com UUID
E deve atribuir o próximo sequenceNumber da categoria
E deve salvar via SyncRepository.addLyric

Dado que o usuário edita uma letra existente
Quando altera título ou conteúdo e salva
Então o sistema deve preservar o id e sequenceNumber originais
E deve atualizar updatedAt
E deve marcar a letra como não sincronizada

Dado que o campo YouTube contém um link inválido
Quando o usuário tenta salvar
Então o sistema deve exibir "Link do YouTube inválido."
E não deve salvar a letra

Dado que a letra existente possui conteúdo JSON com operações insert
Quando o formulário é aberto
Então o campo de conteúdo deve mostrar o texto concatenado das operações

Dado que o usuário anexa um áudio em modo edição
Quando o upload retorna URL pública
Então o formulário deve salvar automaticamente a letra com audioUrl atualizado

Dado que o usuário remove um áudio em modo edição
Quando a remoção termina
Então o formulário deve salvar automaticamente a letra com audioUrl nulo

Dado que o formulário está editando uma letra
Quando o usuário confirma exclusão
Então o sistema deve chamar deleteLyric com o id da letra
E retornar true para a tela anterior
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Criar letra com título/conteúdo/categoria | Must | 🟢 Núcleo de manutenção do acervo. |
| Editar letra preservando ID/sequência | Must | 🟢 Necessário para correção sem quebrar referências. |
| Validar YouTube | Must | 🟢 Evita salvar mídia externa inválida. |
| Persistência offline-first | Must | 🟢 Padrão arquitetural central do app. |
| Excluir letra com confirmação | Must | 🟢 Operação destrutiva controlada por admin. |
| Upload/remover áudio | Should | 🟢 Importante para mídia, mas a letra textual ainda funciona sem áudio. |
| Conversão JSON legado | Should | 🟢 Importante para compatibilidade com conteúdo antigo. |
| Mensagem para título vazio | Could | 🟡 O legado apenas retorna sem feedback. |
| Validar conteúdo vazio | Could | 🟡 Domínio sugere obrigatório, mas legado não bloqueia. |
| Editar/excluir sem permissão | Won't | 🟢 Bloqueado por fluxo externo/RBAC. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/screens/lyric_form_screen.dart` | `LyricFormScreen`, `_LyricFormScreenState` | 🟢 |
| `lib/screens/lyric_form_screen.dart` | `_initContent`, `_pickAndUploadAudio`, `_removeAudio`, `_save`, `_delete` | 🟢 |
| `lib/models/lyric.dart` | `Lyric`, `toMap`, `toSupabaseMap`, `fromMap` | 🟢 |
| `lib/services/sync_repository.dart` | `addLyric`, `deleteLyric`, `getNextSequenceNumber` | 🟢 |
| `lib/services/db_helper.dart` | `upsertLyric`, `softDeleteLyric`, `hardDeleteLyric`, `getMaxSequenceNumber` | 🟢 |
| `lib/services/supabase_service.dart` | `upsertLyric`, `deleteLyric`, `uploadAudio`, `deleteAudioByUrl` | 🟢 |
| `lib/services/auth_service.dart` | `canAddLyrics`, `canEditLyrics`, `canDeleteLyrics` usados por fluxos chamadores | 🟡 |
| `youtube_player_flutter` | `YoutubePlayer.convertUrlToId` | 🟢 |
| `file_picker` | `FilePicker.platform.pickFiles(type: FileType.audio)` | 🟢 |

