# Sincronização Offline — Fluxos Operacionais

## Fluxo 1 — Ciclo completo `syncData()`

```mermaid
sequenceDiagram
  participant UI as Telas / Connectivity
  participant Repo as SyncRepository
  participant DB as DatabaseHelper
  participant SB as SupabaseService
  participant Prefs as SharedPreferences
  participant FS as FileSystem/HTTP

  UI->>Repo: syncData()
  alt isSyncing ou isOffline
    Repo-->>UI: return
  end
  Repo->>Repo: isSyncing=true
  Note over Repo,DB: PUSH
  Repo->>DB: getUnsyncedCategories()
  loop cada categoria
    alt isDeleted
      Repo->>SB: deleteCategory(id)
      Repo->>DB: hardDeleteCategory(id)
    else
      Repo->>SB: upsertCategory(cat)
      Repo->>DB: markCategorySynced(id)
    end
  end
  Repo->>DB: getUnsyncedLyrics()
  loop cada letra
    alt isDeleted
      Repo->>SB: deleteLyric(id)
      Repo->>DB: hardDeleteLyric(id)
    else
      Repo->>SB: upsertLyric(lyric)
      Repo->>DB: markLyricSynced(id)
    end
  end
  Note over Repo,Prefs: PULL
  Repo->>Prefs: get last_sync_timestamp
  Repo->>SB: fetchCategories(since)
  loop cada categoria remota
    alt isDeleted
      Repo->>DB: hardDeleteCategory
    else
      Repo->>DB: upsertCategory(isSynced=true)
    end
  end
  Repo->>SB: fetchLyrics(since)
  loop cada letra remota
    alt isDeleted
      Repo->>FS: delete local MP3 se existir
      Repo->>DB: hardDeleteLyric
    else
      Repo->>DB: merge localAudioPath
      Repo->>DB: upsertLyric
    end
  end
  Repo->>Prefs: set last_sync_timestamp=now
  Note over Repo,FS: DOWNLOAD
  Repo->>Repo: _downloadMissingAudios()
  Repo->>Repo: isSyncing=false
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Erros no `try` são logados; `finally` sempre desliga `_isSyncing`.
- 🟡 **INFERIDO** — Timestamp atualizado mesmo se PUSH parcial falhar antes do `catch`.

## Fluxo 2 — Edição offline e sincronização posterior

```mermaid
flowchart TD
  A["Usuário edita letra offline"] --> B["addLyric(lyric isSynced=false)"]
  B --> C["upsertLyric SQLite"]
  C --> D["notifyListeners — UI atualiza"]
  D --> E{"Rede volta?"}
  E -- "não" --> F["Item permanece is_synced=0"]
  E -- "sim" --> G["connectivity listener → syncData"]
  G --> H["PUSH upsertLyric"]
  H --> I["markLyricSynced"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Edição offline não bloqueia o usuário.
- 🟢 **CONFIRMADO** — Push imediato em `addLyric` online é best-effort assíncrono; fila cobre falhas.

## Fluxo 3 — Soft delete de categoria com cascata

```mermaid
sequenceDiagram
  participant U as Usuário Admin
  participant Repo as SyncRepository
  participant DB as DatabaseHelper
  participant SB as SupabaseService

  U->>Repo: deleteCategory(id)
  Repo->>DB: softDeleteCategory(id)
  Note over DB: category is_deleted=1<br/>lyrics da categoria is_deleted=1
  Repo->>Repo: notifyListeners
  alt online
    Repo->>SB: deleteCategory(id)
    SB-->>Repo: ok
    Repo->>DB: hardDeleteCategory(id)
  else offline
    Note over Repo: Aguarda próximo syncData PUSH
  end
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Cascata local ocorre em uma transação de updates no SQLite.
- 🟡 **INFERIDO** — PUSH posterior enviará categoria e letras marcadas `is_synced=0`.

## Fluxo 4 — Pull com preservação de áudio local

```mermaid
flowchart TD
  A["Lyric remota no PULL"] --> B["existing = local por id"]
  B --> C{"existing.localAudioPath?"}
  C -- "não" --> D["preservedPath = null"]
  C -- "sim" --> E{"audioUrl removida ou diferente?"}
  E -- "sim" --> F["File.delete + preservedPath=null"]
  E -- "não" --> G["preservedPath = existing.localAudioPath"]
  D --> H["Lyric merged"]
  G --> H
  F --> H
  H --> I["upsertLyric SQLite"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Nuvem nunca envia `local_audio_path`; merge é obrigatório.
- 🟢 **CONFIRMADO** — Mudança de `audioUrl` invalida arquivo local antigo.

## Fluxo 5 — Download pós-sync de MP3

```mermaid
flowchart TD
  A["_downloadMissingAudios"] --> B["lyrics = readAllLyrics"]
  B --> C["filter audioUrl && !localAudioPath"]
  C --> D{"lista vazia?"}
  D -- "sim" --> Z["return"]
  D -- "não" --> E["isDownloading=true"]
  E --> F["para cada lyric"]
  F --> G{"arquivo já existe?"}
  G -- "sim" --> H["upsertLyric com path existente"]
  G -- "não" --> I["http.get audioUrl"]
  I --> J{"status 200?"}
  J -- "sim" --> K["write audios/filename + upsert path"]
  J -- "não" --> L["skip"]
  H --> M["atualizar progresso"]
  K --> M
  L --> M
  M --> F
  F --> N["isDownloading=false"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Download é sequencial, não paralelo.
- 🟡 **INFERIDO** — Falha em um arquivo não interrompe os demais.
- 🟢 **CONFIRMADO** — Splash exibe progresso via `Consumer<SyncRepository>`.

## Fluxo 6 — Conectividade e sync automático

```mermaid
stateDiagram-v2
  [*] --> Offline: app inicia (_isOffline=true)
  Offline --> Online: connectivity != none
  Online --> Syncing: syncData()
  Syncing --> Online: finally isSyncing=false
  Online --> Offline: connectivity none
  Offline --> Online: rede restaurada → syncData()
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Transição para online dispara sync sem ação do usuário.
- 🟢 **CONFIRMADO** — Home também chama `syncData` no primeiro frame (redundância aceitável).

## Fluxo 7 — Exclusão imediata de letra online (caminho alternativo)

```mermaid
sequenceDiagram
  participant U as Usuário
  participant Repo as SyncRepository
  participant DB as DatabaseHelper
  participant SB as SupabaseService

  U->>Repo: deleteLyric(id)
  Repo->>DB: softDeleteLyric(id)
  alt online
    Repo->>SB: SELECT audio_url
    alt audio_url presente
      Repo->>SB: deleteAudioByUrl(url)
    end
    Repo->>SB: DELETE FROM lyrics (hard)
    Repo->>DB: hardDeleteLyric(id)
  end
```

### Contrato do fluxo

- 🟡 **INFERIDO** — Diverge do PUSH que usa soft delete remoto (`deleteLyric` → `is_deleted=true`).
- 🔴 **LACUNA** — Dois semânticas de exclusão remota coexistem; reimplementação deve unificar.

## Matriz de disparo de sync

| Gatilho | Arquivo | Condição |
|---------|---------|----------|
| Rede restaurada | `sync_repository.dart` | `!_isOffline` no listener |
| Abertura Home | `home_screen.dart` | `addPostFrameCallback` |
| Pull refresh Home | `home_screen.dart` | usuário arrasta |
| Pull refresh Categoria | `category_screen.dart` | usuário arrasta |
| Pull refresh Busca | `search_screen.dart` | usuário arrasta |
| Pull refresh Letra | `lyric_view_screen.dart` | usuário arrasta |
