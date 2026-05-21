# Autenticação — Fluxos Operacionais

## Fluxo 1 — Bootstrap de sessão na splash

```mermaid
flowchart TD
  A["SplashScreen init"] --> B["delay 2s + permissões storage/audio"]
  B --> C["AuthService.ensureAuthenticated"]
  C --> D{"_currentUser ou session?"}
  D -- "sim" --> E["return true"]
  D -- "não" --> F["signInAnonymously"]
  F --> G{"user criado?"}
  G -- "sim" --> H["_currentUser = user"]
  G -- "não" --> I["erro Falha ao criar sessão"]
  E --> J["SharedPreferences onboarding_completed?"]
  H --> J
  J --> K{"concluído?"}
  K -- "sim" --> L["Navigator → HomeScreen"]
  K -- "não" --> M["Navigator → OnboardingScreen"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Auth roda **antes** da decisão onboarding/home.
- 🟢 **CONFIRMADO** — Falha em `ensureAuthenticated` não bloqueia navegação explícita no código atual (retorno ignorado).
- 🟢 **CONFIRMADO** — Sessão anônima satisfaz requisitos Supabase para operações que aceitam `anon`/`authenticated`.

## Fluxo 2 — Login com Google (bottom sheet)

```mermaid
flowchart TD
  A["Usuário abre bottom sheet"] --> B{"isAnonymous?"}
  B -- "não" --> C["Exibir perfil + Sair"]
  B -- "sim" --> D["Exibir Visitante + botão Google"]
  D --> E["Tap Entrar com Google"]
  E --> F{"isLoading?"}
  F -- "sim" --> G["Botão desabilitado + spinner"]
  F -- "não" --> H["signInWithGoogle"]
  H --> I["GoogleSignIn.signIn"]
  I --> J{"googleUser?"}
  J -- "null" --> K["error=Login cancelado; snackbar erro"]
  J -- "ok" --> L["idToken + accessToken"]
  L --> M{"idToken?"}
  M -- "null" --> N["erro sem token"]
  M -- "ok" --> O["signInWithIdToken Supabase"]
  O --> P{"user?"}
  P -- "sim" --> Q["onAuthStateChange → fetchRole + Realtime"]
  Q --> R["snackbar Login realizado"]
  P -- "não" --> S["snackbar falha Supabase"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — UI usa `Consumer<AuthService>` para reagir a loading e perfil.
- 🟢 **CONFIRMADO** — Sucesso depende de `success == true` retornado por `signInWithGoogle`.
- 🟢 **CONFIRMADO** — `_error` é exibido via snackbar quando login falha.
- 🟢 **CONFIRMADO** — Após sucesso, bottom sheet re-renderiza seção autenticada (avatar, role badge).

## Fluxo 3 — Carregamento e criação de role

```mermaid
flowchart TD
  A["Usuário não anônimo autenticado"] --> B["_fetchUserRole"]
  B --> C["SELECT role FROM user_roles WHERE id = uid"]
  C --> D{"registro existe?"}
  D -- "sim" --> E["_userRole = role"]
  D -- "não" --> F["_userRole = user"]
  F --> G["_createUserRole INSERT"]
  G --> H["notifyListeners"]
  E --> H
  B --> I{"erro de rede?"}
  I -- "sim" --> J["_userRole = user fallback"]
  J --> H
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Fallback seguro para `user` em qualquer falha de fetch.
- 🟢 **CONFIRMADO** — Insert inclui `email`, `role`, `avatar_url` dos metadados Google.
- 🟡 **INFERIDO** — Trigger SQL no servidor pode criar linha em paralelo; insert app-side é idempotente apenas se não houver race.

## Fluxo 4 — Atualização de role em tempo real

```mermaid
flowchart TD
  A["Login não anônimo"] --> B["_subscribeToRoleChanges"]
  B --> C["channel user_roles:userId"]
  C --> D["postgres_changes UPDATE"]
  D --> E["payload.newRecord.role"]
  E --> F{"role != _userRole?"}
  F -- "sim" --> G["_userRole = newRole"]
  G --> H["notifyListeners"]
  F -- "não" --> I["ignorar"]
  J["signOut / signedOut"] --> K["_unsubscribeFromRoleChanges"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Apenas eventos `UPDATE` na linha do próprio usuário.
- 🟢 **CONFIRMADO** — Telas com `Consumer<AuthService>` atualizam botões editar/excluir sem restart.
- 🟢 **CONFIRMADO** — Admin que promove usuário reflete na sessão ativa do promotee.

## Fluxo 5 — Logout

```mermaid
flowchart TD
  A["Tap Sair no bottom sheet"] --> B["signOut"]
  B --> C["GoogleSignIn.signOut try/catch"]
  C --> D["Supabase.auth.signOut"]
  D --> E["_currentUser = null"]
  E --> F["onAuthStateChange signedOut"]
  F --> G["_userRole = user"]
  G --> H["_unsubscribeFromRoleChanges"]
  H --> I["notifyListeners → UI visitante"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Erro no Google signOut é ignorado (usuário pode nunca ter usado Google).
- 🟢 **CONFIRMADO** — Próximo `ensureAuthenticated` pode criar nova sessão anônima.
- 🟡 **INFERIDO** — Dados locais (SQLite, favoritos) permanecem no dispositivo após logout.

## Fluxo 6 — Bloqueio de permissão na UI (exemplo: adicionar letra)

```mermaid
flowchart TD
  A["CategoryScreen FAB adicionar"] --> B["canAddLyrics?"]
  B -- "sim" --> C["Navigator → LyricFormScreen"]
  B -- "não" --> D{"isAnonymous?"}
  D -- "sim" --> E["Snackbar: Faça login com Google"]
  D -- "não" --> F["Snackbar: permissão insuficiente"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Padrão repetido em Home (categorias) e LyricView (editar/excluir).
- 🟢 **CONFIRMADO** — Anônimo é tratado com CTA de login, não mensagem genérica de role.
- 🟡 **INFERIDO** — Enforcement final ainda depende de RLS no Supabase se usuário contornar UI.

## Fluxo 7 — Refresh de role na Home

```mermaid
sequenceDiagram
  participant U as Usuário
  participant H as HomeScreen
  participant S as SyncRepository
  participant A as AuthService
  U->>H: pull-to-refresh
  H->>S: syncData()
  H->>A: refreshUserRole()
  par paralelo
    S-->>H: acervo atualizado
    A-->>H: role atualizada
  end
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `Future.wait` aguarda ambos antes de encerrar refresh.
- 🟢 **CONFIRMADO** — Complementa Realtime quando subscription falhou ou app estava em background.

## Fluxo 8 — Tratamento de erro OAuth (ApiException 10)

```mermaid
flowchart TD
  A["signInWithGoogle catch"] --> B{"PlatformException sign_in_failed?"}
  B -- "não" --> C["error genérico"]
  B -- "sim" --> D{"message contém ApiException: 10?"}
  D -- "sim" --> E["Mensagem longa: package/SHA/serverClientId"]
  D -- "não" --> F["Falha no login Google: message"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Mensagem educativa para equipe de build Android.
- 🟢 **CONFIRMADO** — Erro exposto em `authService.error` para snackbar.

## Matriz fluxo × artefato

| Fluxo | Arquivo principal | Spec |
|-------|-------------------|------|
| Bootstrap splash | `splash_screen.dart` | RF-01, RF-02, RF-03 |
| Login Google | `auth_service.dart`, `app_info_bottom_sheet.dart` | RF-04, RF-14 |
| RBAC fetch/create | `auth_service.dart` | RF-05, RF-06 |
| Realtime role | `auth_service.dart` | RF-07 |
| Logout | `auth_service.dart`, bottom sheet | RF-10 |
| Bloqueio UI | `category_screen.dart`, etc. | RF-08 |
| Refresh Home | `home_screen.dart` | RF-11 |
