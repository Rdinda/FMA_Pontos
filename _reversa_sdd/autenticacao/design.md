# Autenticação — Design

> **Contrato arquitetural:** [`../architecture-contract.md`](../architecture-contract.md) — **W-05** (`is_active`), mapa §4 (Auth / `user_roles`).

## Decisão Arquitetural

🟢 **CONFIRMADO** — **Supabase Auth** como provedor de identidade; **Google Sign-In** apenas como origem de `idToken`/`accessToken`.  
🟢 **CONFIRMADO** — **Sessão anônima por padrão** na primeira abertura — permite uso do app e vínculo de dispositivo sem cadastro.  
🟢 **CONFIRMADO** — **RBAC híbrido**: regras no cliente (`AuthService.hasRole`) + enforcement no Postgres (`has_role()`, RLS).  
🟢 **CONFIRMADO** — **Realtime** para propagar mudanças de role sem reinício do app.  
🟡 **INFERIDO** — Segurança efetiva de escrita depende das policies Supabase; UI é camada de conveniência, não única barreira.

## Componentes

| Componente | Tipo | Responsabilidade | Dependências |
|------------|------|------------------|--------------|
| `AuthService` | `ChangeNotifier` | Sessão, login Google, RBAC, Realtime role | `supabase_flutter`, `google_sign_in` |
| `SupabaseClient` | SDK | Auth, PostgREST, Realtime | Inicializado em `main()` |
| `GoogleSignIn` | SDK | OAuth UI nativo, tokens | `serverClientId` Web Client |
| `showAppInfoBottomSheet` | Widget | Login/logout, perfil, atalho admin | `AuthService`, `ThemeProvider` |
| `SplashScreen` | Tela | `ensureAuthenticated` antes de onboarding/home | `AuthService` |
| Telas de acervo | Consumidores | Checagem `can*` / `isAnonymous` | `Provider` |

## Modelo de Dados — `user_roles`

| Coluna | Tipo | Uso | Confiança |
|--------|------|-----|-----------|
| `id` | UUID PK → `auth.users` | Identificador do usuário | 🟢 |
| `email` | TEXT NOT NULL | Email exibido/admin | 🟢 |
| `role` | TEXT CHECK (`user`,`moderator`,`admin`) | Papel RBAC | 🟢 |
| `created_at` | TIMESTAMPTZ | Auditoria | 🟢 |
| `updated_at` | TIMESTAMPTZ | Auditoria | 🟢 |
| `avatar_url` | TEXT nullable | 🟡 Inserido pelo app no `_createUserRole` | 🟡 |
| `is_active` | BOOLEAN | 🟡 Usado em `UserInfo`/admin; ausente no schema base `supabase_schema.sql` | 🔴 |

🟢 **CONFIRMADO** — Funções SQL `get_user_role()` e `has_role(required_role)` espelham a hierarquia do Dart.

## Hierarquia de Roles (cliente e servidor)

```mermaid
flowchart TB
  subgraph client ["AuthService.hasRole"]
    U["user"] --> M["moderator"]
    M --> A["admin"]
  end
  subgraph gates ["can* getters"]
    CAL["canAddLyrics → user+"]
    CEL["canEditLyrics → moderator+"]
    CDL["canDeleteLyrics → admin"]
    CAC["canAddCategories → moderator+"]
    CEC["canEditCategories → moderator+"]
    CDC["canDeleteCategories → admin"]
  end
```

| Getter | Expressão | Confiança |
|--------|-----------|-----------|
| `isAnonymous` | `user == null \|\| user.isAnonymous` | 🟢 |
| `canAddLyrics` | `!isAnonymous && hasRole('user')` | 🟢 |
| `canEditLyrics` | `!isAnonymous && hasRole('moderator')` | 🟢 |
| `canDeleteLyrics` | `!isAnonymous && hasRole('admin')` | 🟢 |
| `canAddCategories` | `!isAnonymous && hasRole('moderator')` | 🟢 |
| `canEditCategories` | `!isAnonymous && hasRole('moderator')` | 🟢 |
| `canDeleteCategories` | `!isAnonymous && hasRole('admin')` | 🟢 |
| `isAdmin` | `hasRole('admin')` | 🟢 |
| `isModerator` | `hasRole('moderator')` | 🟢 |

## Máquina de Estados — Sessão

```mermaid
stateDiagram-v2
  [*] --> Uninitialized: AuthService()
  Uninitialized --> Anonymous: ensureAuthenticated / signInAnonymously
  Uninitialized --> Authenticated: sessão persistida não anônima
  Anonymous --> Authenticated: signInWithGoogle ok
  Authenticated --> SignedOut: signOut
  SignedOut --> Anonymous: ensureAuthenticated sem sessão
  note right of Anonymous
    isAnonymous=true
    _userRole=user (default)
  end note
  note right of Authenticated
    isAnonymous=false
    _fetchUserRole + Realtime
  end note
```

## Máquina de Estados — Operação de Login

```mermaid
stateDiagram-v2
  [*] --> Idle
  Idle --> Loading: signInWithGoogle / ensureAuthenticated
  Loading --> Success: tokens + Supabase ok
  Loading --> Cancelled: googleUser null
  Loading --> Error: exception / sem idToken
  Success --> Idle: finally notifyListeners
  Cancelled --> Idle
  Error --> Idle
```

## Fluxo `ensureAuthenticated()`

```mermaid
flowchart TD
  A["ensureAuthenticated"] --> B{"_isLoading?"}
  B -- "sim" --> Z["return false"]
  B -- "não" --> C["_isLoading=true"]
  C --> D{"_currentUser != null?"}
  D -- "sim" --> E["return true"]
  D -- "não" --> F{"currentSession?"}
  F -- "sim" --> G["_currentUser=session.user; return true"]
  F -- "não" --> H["signInAnonymously"]
  H --> I{"response.user?"}
  I -- "sim" --> J["_currentUser=user; return true"]
  I -- "não" --> K["_error; return false"]
  C --> L["finally _isLoading=false"]
```

## Fluxo `signInWithGoogle()`

```mermaid
flowchart TD
  A["signInWithGoogle"] --> B["_isLoading=true"]
  B --> C["GoogleSignIn.signIn"]
  C --> D{"googleUser?"}
  D -- "null" --> E["error=Login cancelado"]
  D -- "ok" --> F["authentication → idToken"]
  F --> G{"idToken?"}
  G -- "null" --> H["error sem token"]
  G -- "ok" --> I["signInWithIdToken Google"]
  I --> J{"response.user?"}
  J -- "sim" --> K["_currentUser=user; success"]
  J -- "não" --> L["error falha Supabase"]
  B --> M["catch PlatformException ApiException 10"]
  M --> N["mensagem config OAuth"]
  B --> O["finally _isLoading=false"]
```

🟢 **CONFIRMADO** — `onAuthStateChange` dispara `_fetchUserRole` e `_subscribeToRoleChanges` após login não anônimo.

## Realtime — Subscription de Role

| Parâmetro | Valor |
|-----------|-------|
| Canal | `public:user_roles:{userId}` |
| Evento | `UPDATE` |
| Schema | `public` |
| Tabela | `user_roles` |
| Filtro | `id = eq.{userId}` |
| Callback | Atualiza `_userRole` se `role` mudou → `notifyListeners()` |

🟢 **CONFIRMADO** — `_unsubscribeFromRoleChanges` em `signedOut` via `removeChannel`.

## Integração UI

### Splash → Auth → Navegação

```mermaid
sequenceDiagram
  participant S as SplashScreen
  participant A as AuthService
  participant P as SharedPreferences
  participant N as Navigator
  S->>A: ensureAuthenticated()
  A-->>S: true/false
  S->>P: onboarding_completed?
  alt concluído
    S->>N: HomeScreen
  else
    S->>N: OnboardingScreen
  end
```

### Bottom sheet — estados

| Estado | UI principal | Ações |
|--------|--------------|-------|
| Anônimo | Ícone visitante, texto "Entre para contribuir" | Botão "Entrar com Google" |
| Autenticado | Avatar, nome, email, badge role | Tema, privacidade, admin (se `isAdmin`), Sair |
| Loading | Botão Google com `CircularProgressIndicator` | Desabilitado |

🟢 **CONFIRMADO** — Snackbar de sucesso/erro após login via `showAppSnackBar`.

### Home — avatar e refresh

🟢 **CONFIRMADO** — Se `!isAnonymous && photoUrl != null`, AppBar mostra `CircleAvatar` clicável que abre o mesmo bottom sheet.  
🟢 **CONFIRMADO** — `RefreshIndicator` chama `Future.wait([syncData(), refreshUserRole()])`.

## Configuração Google OAuth

| Parâmetro | Valor / local | Confiança |
|-----------|---------------|-----------|
| Instância | `GoogleSignIn.instance` (singleton v7) | 🟢 |
| Inicialização | `initialize(serverClientId: ...)` em `_init` | 🟢 |
| Login interativo | `authenticate()` | 🟢 |
| `serverClientId` | Web Client ID em `auth_service.dart` | 🟢 |
| Token Supabase | `idToken` via `googleUser.authentication` (getter) | 🟢 |

## RLS e Policies (`user_roles`)

| Policy | Operação | Regra | Confiança |
|--------|----------|-------|-----------|
| Users can view own role | SELECT | `id = auth.uid()` | 🟢 |
| Admins can manage roles | ALL | `has_role('admin')` | 🟢 |
| Users can create own user role | INSERT | 🟡 presente em migrações posteriores | 🟡 |

🟢 **CONFIRMADO** — Trigger `handle_new_user` insere linha em `user_roles` no signup (schema SQL).

## Lacunas e Débitos

| Item | Severidade | Notas |
|------|------------|-------|
| `upgradeToEmail` sem UI | 🟡 | API pronta, fluxo morto |
| `serverClientId` hardcoded | 🟡 | Deveria vir de `--dart-define` em builds |
| Divergência UI vs RLS | 🟡 | Policies remotas podem mudar fora do repo |

## Contratos de Interface (`AuthService`)

```dart
// Estado exposto (🟢 CONFIRMADO)
User? currentUser;
bool isAuthenticated;
bool isAnonymous;
bool isInitialized;
bool isLoading;
String? error;
String? userId, userEmail, displayName, photoUrl;
String userRole;

// Operações (🟢 CONFIRMADO)
Future<bool> ensureAuthenticated();
Future<bool> signInWithGoogle();
Future<void> signOut();
Future<void> refreshUserRole();
Future<bool> upgradeToEmail(String email, String password); // 🟡 sem UI

// Permissões (🟢 CONFIRMADO)
bool hasRole(String requiredRole);
bool canAddLyrics, canEditLyrics, canDeleteLyrics;
bool canAddCategories, canEditCategories, canDeleteCategories;
bool isAdmin, isModerator;
```
