# Edição de Letra — Fluxos Operacionais

## Fluxo 1 — Abrir formulário

```mermaid
flowchart TD
  A["Tela chamadora abre LyricFormScreen"] --> B["Receber categoryId e Lyric?"]
  B --> C{"lyric == null?"}
  C -- "sim" --> D["Modo criação"]
  C -- "não" --> E["Modo edição"]
  D --> F["AppBar Nova Letra"]
  D --> G["Campos vazios"]
  D --> H["Sem botão excluir"]
  E --> I["AppBar Editar Letra"]
  E --> J["Preencher title"]
  E --> K["Preencher youtubeLink ou vazio"]
  E --> L["_initContent lyric.content"]
  E --> M["_audioUrl = lyric.audioUrl"]
  E --> N["Mostrar botão excluir"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `categoryId` é obrigatório em criação e edição.
- 🟢 **CONFIRMADO** — `lyric == null` define criação.
- 🟢 **CONFIRMADO** — `lyric != null` define edição.
- 🟡 **INFERIDO** — O fluxo chamador deve aplicar RBAC antes de abrir o formulário.

## Fluxo 2 — Inicializar conteúdo textual legado

```mermaid
flowchart TD
  A["_initContent content"] --> B{"content trim começa com [ ou {?"}
  B -- "não" --> C["Usar content como texto plano"]
  B -- "sim" --> D["Tentar jsonDecode"]
  D --> E{"Decodificou sem erro?"}
  E -- "não" --> C
  E -- "sim" --> F{"JSON é List?"}
  F -- "não" --> C
  F -- "sim" --> G["Iterar ops"]
  G --> H{"op é Map com insert?"}
  H -- "sim" --> I["buffer.write op.insert"]
  H -- "não" --> J["Ignorar op"]
  I --> K{"Próximo op?"}
  J --> K
  K -- "sim" --> G
  K -- "não" --> L["Popular _contentController com buffer"]
  C --> M["Popular _contentController com content"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — JSON inválido não quebra o formulário.
- 🟢 **CONFIRMADO** — Apenas operações com chave `insert` contribuem para o texto.
- 🟢 **CONFIRMADO** — Conteúdo não JSON é preservado.

## Fluxo 3 — Salvar nova letra

```mermaid
flowchart TD
  A["Usuário toca check"] --> B["_save"]
  B --> C["Ler title, content, youtubeUrl"]
  C --> D{"title vazio?"}
  D -- "sim" --> E["Retornar sem feedback"]
  D -- "não" --> F{"youtubeUrl preenchido?"}
  F -- "não" --> G["youtubeLink = null"]
  F -- "sim" --> H{"convertUrlToId válido?"}
  H -- "não" --> I["Snackbar Link do YouTube inválido"]
  H -- "sim" --> J["youtubeLink = youtubeUrl"]
  G --> K{"lyric == null?"}
  J --> K
  K -- "sim" --> L["repo.getNextSequenceNumber categoryId"]
  L --> M["Criar Lyric UUID + sequenceNumber"]
  M --> N["repo.addLyric"]
  N --> O["Navigator.pop"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Título vazio bloqueia persistência silenciosamente.
- 🟢 **CONFIRMADO** — YouTube inválido bloqueia persistência com snackbar.
- 🟢 **CONFIRMADO** — Nova letra recebe UUID gerado no cliente.
- 🟢 **CONFIRMADO** — `sequenceNumber` é calculado antes de criar a letra.
- 🟢 **CONFIRMADO** — `audioUrl` atual do formulário é incluído na letra criada.

## Fluxo 4 — Salvar edição de letra

```mermaid
flowchart TD
  A["Usuário toca check em modo edição"] --> B["_save"]
  B --> C["Validar título e YouTube"]
  C --> D{"Validação ok?"}
  D -- "não" --> E["Não salvar"]
  D -- "sim" --> F["Criar Lyric atualizado"]
  F --> G["Preservar id original"]
  F --> H["Preservar sequenceNumber original"]
  F --> I["updatedAt = now"]
  F --> J["isSynced = false"]
  F --> K["audioUrl = _audioUrl"]
  F --> L["youtubeLink vazio vira null"]
  G --> M["repo.addLyric"]
  H --> M
  I --> M
  J --> M
  K --> M
  L --> M
  M --> N["Navigator.pop"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Edição usa `addLyric` como upsert.
- 🟢 **CONFIRMADO** — `id` e `sequenceNumber` não mudam.
- 🟢 **CONFIRMADO** — Letra editada fica pendente de sync.
- 🟢 **CONFIRMADO** — Conteúdo vazio pode ser salvo no legado.

## Fluxo 5 — Persistência offline-first

```mermaid
flowchart TD
  A["SyncRepository.addLyric"] --> B["DatabaseHelper.upsertLyric"]
  B --> C["SQLite insert replace em lyrics"]
  C --> D["Forçar is_deleted = 0"]
  D --> E["notifyListeners"]
  E --> F{"_isOffline?"}
  F -- "sim" --> G["Manter is_synced = 0"]
  F -- "não" --> H["SupabaseService.upsertLyric"]
  H --> I{"Push ok?"}
  I -- "sim" --> J["DatabaseHelper.markLyricSynced"]
  I -- "não" --> K["debugPrint Failed to push lyric"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Persistência local acontece antes de push remoto.
- 🟢 **CONFIRMADO** — Falha remota não desfaz a escrita local.
- 🟢 **CONFIRMADO** — A sincronização posterior usa `is_synced = 0`.

## Fluxo 6 — Anexar áudio

```mermaid
flowchart TD
  A["Usuário toca Anexar"] --> B["FilePicker pickFiles audio"]
  B --> C{"Selecionou arquivo com path?"}
  C -- "não" --> D["Não faz nada"]
  C -- "sim" --> E["_isUploadingAudio = true"]
  E --> F["Gerar nome UUID_nomeOriginal"]
  F --> G["SupabaseService.uploadAudio path name"]
  G --> H{"Retornou URL?"}
  H -- "não" --> I["_isUploadingAudio = false"]
  I --> J["Snackbar Erro ao enviar áudio"]
  H -- "sim" --> K["_audioUrl = url"]
  K --> L["_isUploadingAudio = false"]
  L --> M["Snackbar Áudio enviado com sucesso"]
  M --> N{"Modo edição?"}
  N -- "não" --> O["Aguardar save manual da nova letra"]
  N -- "sim" --> P["Criar Lyric atualizado com audioUrl"]
  P --> Q["repo.addLyric"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Upload depende de Supabase Storage.
- 🟢 **CONFIRMADO** — O arquivo é enviado para `audio/lyrics/`.
- 🟢 **CONFIRMADO** — Em edição, áudio anexado é salvo automaticamente na letra.
- 🟡 **INFERIDO** — Em criação, áudio enviado pode ficar órfão se a letra nunca for salva.

## Fluxo 7 — Erro ao selecionar/enviar áudio

```mermaid
flowchart TD
  A["_pickAndUploadAudio"] --> B{"Erro no picker/upload?"}
  B -- "sim" --> C["debugPrint Error picking audio"]
  C --> D["_isUploadingAudio = false"]
  D --> E["Snackbar Erro ao selecionar áudio: Verifique permissões"]
  B -- "não" --> F["Seguir fluxo normal"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Erro é capturado.
- 🟢 **CONFIRMADO** — O loading é desligado no catch.
- 🟢 **CONFIRMADO** — O usuário recebe feedback genérico de seleção/permissão.

## Fluxo 8 — Remover áudio

```mermaid
flowchart TD
  A["Usuário toca remover áudio"] --> B{"_audioUrl != null?"}
  B -- "não" --> C["Ação não disponível"]
  B -- "sim" --> D["SupabaseService.deleteAudioByUrl"]
  D --> E{"Delete remoto ok?"}
  E -- "sim" --> F["Snackbar Áudio removido do armazenamento"]
  E -- "não" --> G["debugPrint Error removing audio"]
  F --> H["_audioUrl = null"]
  G --> H
  H --> I{"Modo edição?"}
  I -- "não" --> J["Apenas atualizar formulário"]
  I -- "sim" --> K["Criar Lyric atualizado com audioUrl null"]
  K --> L["repo.addLyric"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Mesmo com falha ao remover do storage, `_audioUrl` é limpo.
- 🟢 **CONFIRMADO** — Em edição, remoção salva automaticamente a letra.
- 🟡 **INFERIDO** — Esse comportamento pode deixar arquivo remoto sem referência se o delete falhar.

## Fluxo 9 — Excluir letra pelo formulário

```mermaid
flowchart TD
  A["AppBar renderiza"] --> B{"widget.lyric != null?"}
  B -- "não" --> C["Não mostrar excluir"]
  B -- "sim" --> D["Mostrar botão excluir"]
  D --> E["Usuário toca excluir"]
  E --> F["Dialog de confirmação"]
  F --> G{"Confirmou?"}
  G -- "não" --> H["Fechar dialog"]
  G -- "sim" --> I["SyncRepository.deleteLyric id"]
  I --> J["Navigator.pop dialog"]
  J --> K["Navigator.pop form true"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Só há exclusão em modo edição.
- 🟢 **CONFIRMADO** — Exclusão pede confirmação.
- 🟢 **CONFIRMADO** — O retorno `true` sinaliza exclusão para a tela anterior.

## Fluxo 10 — Delete local/remoto de letra

```mermaid
flowchart TD
  A["SyncRepository.deleteLyric id"] --> B["DatabaseHelper.softDeleteLyric"]
  B --> C["lyrics.is_deleted = 1"]
  C --> D["lyrics.is_synced = 0"]
  D --> E["notifyListeners"]
  E --> F{"_isOffline?"}
  F -- "sim" --> G["Aguardar sync futuro"]
  F -- "não" --> H["Buscar audio_url remoto"]
  H --> I{"audio_url existe?"}
  I -- "sim" --> J["SupabaseService.deleteAudioByUrl"]
  I -- "não" --> K["Pular delete de storage"]
  J --> L["Excluir registro remoto lyrics"]
  K --> L
  L --> M{"Operação ok?"}
  M -- "sim" --> N["DatabaseHelper.hardDeleteLyric"]
  M -- "não" --> O["debugPrint Failed to delete lyric cloud"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Delete local começa como soft delete.
- 🟢 **CONFIRMADO** — Offline mantém pendência local.
- 🟡 **INFERIDO** — O caminho online atual usa delete físico remoto via client, divergindo do soft delete de `SupabaseService.deleteLyric`.
- 🟡 **INFERIDO** — Uma reconstrução deve decidir entre hard delete remoto e soft delete consistente.

## Estados relevantes

```mermaid
stateDiagram-v2
  [*] --> FormCriacao: lyric == null
  [*] --> FormEdicao: lyric != null
  FormCriacao --> UploadingAudio: anexar audio
  FormEdicao --> UploadingAudio: anexar audio
  UploadingAudio --> FormCriacao: url salva no estado
  UploadingAudio --> FormEdicao: url salva + autosave
  FormCriacao --> LocalDirty: salvar nova letra
  FormEdicao --> LocalDirty: salvar edicao
  FormEdicao --> PendingDelete: confirmar exclusao
  LocalDirty --> Synced: push remoto ok
  PendingDelete --> Removed: delete remoto ok + hard delete local
  PendingDelete --> PendingDelete: offline ou falha remota
```

## Pontos de falha

| Falha | Comportamento legado | Confiança |
|---|---|---|
| Título vazio | Retorna sem salvar e sem snackbar | 🟢 |
| Conteúdo vazio | Pode salvar | 🟡 |
| YouTube inválido | Snackbar e bloqueia save | 🟢 |
| Erro no picker/upload | Desliga loading e mostra erro genérico | 🟢 |
| Upload retorna null | Mostra erro ao enviar áudio | 🟢 |
| Remoção do storage falha | Loga erro e limpa `_audioUrl` local | 🟢 |
| Push remoto de letra falha | Loga erro e mantém pendência local | 🟢 |
| Delete remoto falha | Loga erro e mantém registro soft-deleted local | 🟢 |
| Criação concorrente na mesma categoria | Sem lock explícito de sequência | 🟡 |
| Acesso direto ao formulário sem RBAC | Formulário não bloqueia internamente | 🟡 |

## Lacunas

- 🟡 **INFERIDO** — Decidir se título vazio deve exibir feedback.
- 🟡 **INFERIDO** — Decidir se conteúdo vazio deve ser bloqueado para alinhar com a regra de domínio.
- 🟡 **INFERIDO** — Decidir limpeza de áudio órfão em criação quando usuário abandona o formulário.
- 🟡 **INFERIDO** — Harmonizar delete remoto físico versus soft delete.
- 🟡 **INFERIDO** — Considerar proteção RBAC interna no formulário para defesa em profundidade.

