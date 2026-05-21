# Acervo e Categorias — Fluxos Operacionais

## Fluxo 1 — Listar e navegar por categorias

```mermaid
flowchart TD
  A["HomeScreen.build"] --> B["Provider.of SyncRepository"]
  B --> C["syncRepo.getCategories"]
  C --> D["DatabaseHelper.readAllCategories"]
  D --> E["SQLite query categories"]
  E --> F{"Há categorias ativas?"}
  F -- "não" --> G["Mostrar estado vazio"]
  F -- "sim" --> H["Renderizar lista"]
  H --> I["Para cada categoria: getLyricsCount"]
  I --> J["Exibir nome + contagem"]
  J --> K{"Usuário toca categoria?"}
  K -- "sim" --> L["Navigator.push CategoryScreen"]
  K -- "não" --> H
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — A query deve filtrar `is_deleted = 0`.
- 🟢 **CONFIRMADO** — A query deve ordenar por `name ASC`.
- 🟢 **CONFIRMADO** — A contagem de pontos é derivada de letras locais da categoria.
- 🟢 **CONFIRMADO** — A navegação passa o objeto `Category` para `CategoryScreen`.

## Fluxo 2 — Criar categoria

```mermaid
flowchart TD
  A["Usuário toca aba Categoria"] --> B{"AuthService.canAddCategories?"}
  B -- "não" --> C["Snackbar: login/role necessário"]
  B -- "sim" --> D["Abrir AlertDialog"]
  D --> E["Usuário digita nome"]
  E --> F{"Código está vazio?"}
  F -- "sim" --> G["Sugerir 2 primeiros chars em maiúsculas"]
  F -- "não" --> H["Preservar código manual"]
  G --> I["Usuário salva"]
  H --> I
  I --> J{"Nome e código preenchidos?"}
  J -- "não" --> K["Snackbar: Preencha nome e código"]
  J -- "sim" --> L["Criar Category com UUID e updatedAt now"]
  L --> M["SyncRepository.addCategory"]
  M --> N["DatabaseHelper.upsertCategory"]
  N --> O["notifyListeners"]
  O --> P{"Online?"}
  P -- "não" --> Q["Fica pendente is_synced=0"]
  P -- "sim" --> R["SupabaseService.upsertCategory"]
  R --> S["DatabaseHelper.markCategorySynced"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Categoria não deve ser criada sem nome e código.
- 🟢 **CONFIRMADO** — O código salvo pela UI deve ser maiúsculo.
- 🟢 **CONFIRMADO** — O ID é gerado no cliente com UUID.
- 🟢 **CONFIRMADO** — A persistência local ocorre antes do push remoto.
- 🟡 **INFERIDO** — Falha remota por código duplicado deve manter a categoria pendente ou exigir correção posterior; o legado não trata com mensagem específica.

## Fluxo 3 — Editar categoria

```mermaid
flowchart TD
  A["CategoryScreen"] --> B{"AuthService.canEditCategories?"}
  B -- "não" --> C["Não exibe botão editar"]
  B -- "sim" --> D["Exibe botão editar"]
  D --> E["Usuário toca editar"]
  E --> F["Abrir dialog com nome/código atuais"]
  F --> G["Usuário altera campos"]
  G --> H["Criar Category com mesmo id e updatedAt now"]
  H --> I["SyncRepository.updateCategory"]
  I --> J["Delegar para addCategory"]
  J --> K["upsert local + push remoto se online"]
  K --> L["Fechar dialog e voltar tela"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Edição exige `moderator` ou `admin`.
- 🟢 **CONFIRMADO** — O ID da categoria deve ser preservado.
- 🟢 **CONFIRMADO** — `updatedAt` deve ser atualizado.
- 🟢 **CONFIRMADO** — A implementação legada volta uma tela após salvar para recarregar dados.

## Fluxo 4 — Excluir categoria

```mermaid
flowchart TD
  A["CategoryScreen"] --> B{"AuthService.canDeleteCategories?"}
  B -- "não" --> C["Não exibe botão excluir"]
  B -- "sim" --> D["Exibe botão excluir"]
  D --> E["Usuário toca excluir"]
  E --> F["Dialog de confirmação"]
  F --> G{"Confirmou?"}
  G -- "não" --> H["Cancelar"]
  G -- "sim" --> I["SyncRepository.deleteCategory"]
  I --> J["DatabaseHelper.softDeleteCategory"]
  J --> K["Marcar categoria is_deleted=1, is_synced=0"]
  K --> L["Marcar letras da categoria is_deleted=1, is_synced=0"]
  L --> M["notifyListeners"]
  M --> N{"Online?"}
  N -- "não" --> O["Aguardar sync futuro"]
  N -- "sim" --> P["SupabaseService.deleteCategory"]
  P --> Q{"Delete remoto ok?"}
  Q -- "não" --> R["Log erro, manter pendência local"]
  Q -- "sim" --> S["DatabaseHelper.hardDeleteCategory"]
  S --> T["Remover letras e categoria do SQLite"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Exclusão exige `admin`.
- 🟢 **CONFIRMADO** — Exclusão local é lógica antes de ser física.
- 🟢 **CONFIRMADO** — Letras associadas devem acompanhar o estado de exclusão.
- 🟢 **CONFIRMADO** — Exclusão remota atualiza `is_deleted = true` em Supabase.

## Fluxo 5 — Pull incremental de categorias

```mermaid
flowchart TD
  A["syncData"] --> B["Ler last_sync_timestamp"]
  B --> C["SupabaseService.fetchCategories since lastSync"]
  C --> D["Iterar categorias remotas"]
  D --> E{"cat.isDeleted?"}
  E -- "sim" --> F["DatabaseHelper.hardDeleteCategory"]
  E -- "não" --> G["Criar Category local isSynced=true"]
  G --> H["DatabaseHelper.upsertCategory"]
  F --> I["Próxima categoria"]
  H --> I
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Pull incremental depende de `updated_at > lastSync`.
- 🟢 **CONFIRMADO** — Categoria remota excluída remove fisicamente a categoria local.
- 🟢 **CONFIRMADO** — Categoria remota ativa é salva localmente como sincronizada.

## Estados relevantes

```mermaid
stateDiagram-v2
  [*] --> AtivaLocalPendente: criar/editar offline
  AtivaLocalPendente --> AtivaSincronizada: push remoto ok
  AtivaSincronizada --> AtivaLocalPendente: editar localmente
  AtivaSincronizada --> ExcluidaPendente: excluir localmente
  AtivaLocalPendente --> ExcluidaPendente: excluir antes de sync
  ExcluidaPendente --> Removida: delete remoto ok
  AtivaSincronizada --> Removida: pull remoto isDeleted=true
```

## Pontos de falha

| Falha | Comportamento legado | Confiança |
|---|---|---|
| Usuário sem permissão tenta criar categoria | Snackbar de erro/login | 🟢 |
| Nome/código vazio | Snackbar `Preencha nome e código` | 🟢 |
| Push remoto falha | `debugPrint`, categoria fica local | 🟢 |
| Delete remoto falha | `debugPrint`, categoria fica pendente local | 🟢 |
| Código duplicado no Supabase | Não há tratamento específico documentado | 🟡 |
| Conflito de edição offline/remota | Não há resolução explícita | 🔴 |

