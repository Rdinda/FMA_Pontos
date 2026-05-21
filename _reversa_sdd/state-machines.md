# Máquinas de Estado — FMA_Pontos

Gerado pelo Reversa Detective em 2026-05-19T02:03:06Z.

## Estado de Sincronização Local

Entidades: `Category`, `Lyric`

Campos: `is_synced`, `is_deleted`

```mermaid
stateDiagram-v2
  [*] --> LocalDirty: criar/editar localmente
  LocalDirty --> Synced: push Supabase ok + markSynced
  Synced --> LocalDirty: editar localmente
  Synced --> PendingDelete: excluir localmente
  LocalDirty --> PendingDelete: excluir antes de sincronizar
  PendingDelete --> Removed: delete/soft delete remoto ok + hard delete local
  Synced --> Removed: pull remoto com isDeleted=true
  LocalDirty --> Synced: pull/upsert remoto aplicado
```

Estados:

| Estado | Critério | Confiança |
|---|---|---|
| `LocalDirty` | `is_synced = 0`, `is_deleted = 0` | 🟢 CONFIRMADO |
| `Synced` | `is_synced = 1`, `is_deleted = 0` | 🟢 CONFIRMADO |
| `PendingDelete` | `is_synced = 0`, `is_deleted = 1` | 🟢 CONFIRMADO |
| `Removed` | Registro removido fisicamente do SQLite | 🟢 CONFIRMADO |

## Estado de Conectividade e Sync

Entidade: `SyncRepository`

```mermaid
stateDiagram-v2
  [*] --> Offline
  Offline --> OnlineIdle: connectivity != none
  OnlineIdle --> Syncing: syncData()
  Syncing --> OnlineIdle: sucesso ou erro tratado
  OnlineIdle --> Offline: connectivity none
  Syncing --> Offline: perda de conectividade detectada depois do ciclo
```

Campos:

- `_isOffline`
- `_isSyncing`
- `_isDownloading`
- `_downloadProgress`
- `_downloadStatus`

## Estado de Autenticação e Role

Entidade: `AuthService`

```mermaid
stateDiagram-v2
  [*] --> Uninitialized
  Uninitialized --> Anonymous: ensureAuthenticated cria sessão anônima
  Uninitialized --> AuthenticatedUser: sessão existente não anônima
  Anonymous --> AuthenticatedUser: signInWithGoogle
  AuthenticatedUser --> SignedOut: signOut
  SignedOut --> Anonymous: ensureAuthenticated
  AuthenticatedUser --> RoleUser: role=user
  AuthenticatedUser --> RoleModerator: role=moderator
  AuthenticatedUser --> RoleAdmin: role=admin
  RoleUser --> RoleModerator: realtime user_roles update
  RoleModerator --> RoleAdmin: realtime user_roles update
  RoleAdmin --> RoleUser: realtime user_roles update
```

## Estado de Playback

Entidade: `AudioPlayerService` / `MyAudioHandler`

```mermaid
stateDiagram-v2
  [*] --> Idle
  Idle --> Playing: play(lyric) ou playAll()
  Playing --> Paused: pause()
  Paused --> Playing: play()/togglePlayPause()
  Playing --> Playing: skipNext()/skipPrevious()
  Playing --> Completed: fim da faixa
  Completed --> Playing: playlist tem próxima ou repeat
  Completed --> Idle: playlist terminou sem repeat
  Playing --> Idle: clearPlaylist()/stop()
  Paused --> Idle: clearPlaylist()/stop()
```

Regras:

- 🟢 **CONFIRMADO** — `skipPrevious` reinicia a faixa se posição > 3 segundos.
- 🟢 **CONFIRMADO** — `repeat` faz a última faixa voltar para a primeira.
- 🟢 **CONFIRMADO** — Reproduzir uma letra registra estatística de play.

## Estado do Player da Tela de Letra

Entidade: `_PlayerMode`

```mermaid
stateDiagram-v2
  [*] --> none
  none --> audio: usuário escolhe Áudio
  none --> video: usuário escolhe Vídeo
  audio --> video: usuário escolhe Vídeo / pausa áudio
  video --> audio: usuário escolhe Áudio / pausa YouTube
  audio --> none: fechar player
  video --> none: fechar player
```

Valores:

- `none`
- `audio`
- `video`

## Estado do Onboarding

```mermaid
stateDiagram-v2
  [*] --> Splash
  Splash --> Onboarding: onboarding_completed=false
  Splash --> Home: onboarding_completed=true
  Onboarding --> PrivacyPending: slide final
  PrivacyPending --> Blocked: tentativa sem aceite
  PrivacyPending --> Home: aceite marcado + salvar SharedPreferences
```

## Lacunas

- 🔴 **LACUNA** — Não há estado explícito de conflito de sync.
- 🔴 **LACUNA** — `is_active=false` não aparece como estado bloqueante de autenticação no código analisado.

