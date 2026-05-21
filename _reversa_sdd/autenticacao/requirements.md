# Autenticação — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre identidade do usuário no app móvel Flutter: sessão Supabase (anônima ou Google), carregamento de papel RBAC em `user_roles`, verificadores de permissão consumidos pela UI e atualização em tempo real de role.  
🟢 **CONFIRMADO** — `AuthService` é um `ChangeNotifier` registrado em `main.dart` via `Provider`; telas consultam `isAnonymous`, `canAddLyrics`, `canEditLyrics`, etc.  
🟢 **CONFIRMADO** — Na abertura do app, `SplashScreen` chama `ensureAuthenticated()` para garantir sessão (anônima se necessário) antes de onboarding ou home.  
🟢 **CONFIRMADO** — Login Google é opcional, acionado pelo bottom sheet de informações (`showAppInfoBottomSheet`).  
🟡 **INFERIDO** — `upgradeToEmail` existe no serviço mas não é referenciado por nenhuma tela (funcionalidade latente).  
🟢 **CONFIRMADO** — Usuário com `is_active = false` **deve ter login bloqueado** (decisão stakeholder, Roberto 2026-05-20).  
🟡 **INFERIDO** — No legado, `AuthService` ainda não verifica `is_active` após fetch de role — gap de implementação.

Referência: ADR 002 — `_reversa_sdd/adrs/002-rbac-google-admin.md`.

## Responsabilidades

- 🟢 **CONFIRMADO** — Inicializar listener `onAuthStateChange` do Supabase e restaurar sessão existente.
- 🟢 **CONFIRMADO** — Criar sessão anônima via `signInAnonymously` quando não há usuário nem sessão persistida.
- 🟢 **CONFIRMADO** — Autenticar com Google (`google_sign_in` v6) e trocar por sessão Supabase via `signInWithIdToken`.
- 🟢 **CONFIRMADO** — Buscar role do usuário em `user_roles` após login não anônimo.
- 🟢 **CONFIRMADO** — Criar registro `user_roles` com role `user` quando ausente (fallback app-side).
- 🟢 **CONFIRMADO** — Assinar mudanças de role via Supabase Realtime (`postgres_changes` em `user_roles`).
- 🟢 **CONFIRMADO** — Expor hierarquia de permissões: `user` ⊂ `moderator` ⊂ `admin`.
- 🟢 **CONFIRMADO** — Bloquear ações de escrita na UI para usuários anônimos (`isAnonymous`).
- 🟢 **CONFIRMADO** — Permitir logout (`signOut`) com limpeza Google + Supabase.
- 🟢 **CONFIRMADO** — Expor metadados de perfil: `displayName`, `photoUrl`, `userEmail` a partir de `userMetadata`.
- 🟡 **INFERIDO** — Oferecer upgrade de conta anônima para email/senha (`upgradeToEmail`) sem UI exposta.

## Regras de Negócio

- 🟢 **CONFIRMADO** — `isAnonymous` é `true` quando `_currentUser == null` **ou** `user.isAnonymous == true`.
- 🟢 **CONFIRMADO** — Todos os `can*` de escrita exigem `!isAnonymous` **e** `hasRole` mínimo.
- 🟢 **CONFIRMADO** — `canAddLyrics` requer role `user` (ou superior).
- 🟢 **CONFIRMADO** — `canEditLyrics` e `canAddCategories` / `canEditCategories` requerem `moderator`.
- 🟢 **CONFIRMADO** — `canDeleteLyrics` e `canDeleteCategories` requerem `admin`.
- 🟢 **CONFIRMADO** — Após `signedOut`, `_userRole` volta para `'user'` e subscription Realtime é removida.
- 🟢 **CONFIRMADO** — Usuário anônimo mantém `_userRole = 'user'` sem consulta a `user_roles`.
- 🟢 **CONFIRMADO** — Cancelamento do fluxo Google (`googleUser == null`) define `_error = 'Login cancelado'` e retorna `false`.
- 🟢 **CONFIRMADO** — Ausência de `idToken` do Google bloqueia login com mensagem explícita.
- 🟢 **CONFIRMADO** — `ApiException: 10` no Google Sign-In gera mensagem orientando configuração OAuth (package/SHA/serverClientId).
- 🟢 **CONFIRMADO** — `ensureAuthenticated` é idempotente: retorna `true` se já há `_currentUser` ou sessão recuperável.
- 🟢 **CONFIRMADO** — Enquanto `_isLoading`, novas chamadas de login/ensure retornam `false` sem reentrância.
- 🟡 **INFERIDO** — Após login Google, trigger SQL em Supabase também pode criar `user_roles`; app insere se `maybeSingle` retornar nulo.
- 🟢 **CONFIRMADO** — Usuário inativo (`is_active = false`) não deve conseguir usar o app autenticado (bloqueio de login/sessão).  
- 🟡 **INFERIDO** — Legado não implementa esse bloqueio em `AuthService` nem em RLS.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O app deve garantir sessão Supabase na splash. | Must | Dado app iniciando, quando `SplashScreen` executa, então `ensureAuthenticated()` retorna sucesso com usuário anônimo ou existente. |
| RF-02 | 🟢 O sistema deve restaurar sessão persistida. | Must | Dado sessão válida em storage Supabase, quando `AuthService` inicializa, então `_currentUser` é preenchido sem novo `signInAnonymously`. |
| RF-03 | 🟢 O sistema deve criar sessão anônima sob demanda. | Must | Dado sem usuário e sem sessão, quando `ensureAuthenticated`, então `signInAnonymously` cria usuário anônimo. |
| RF-04 | 🟢 O usuário deve poder entrar com Google. | Must | Dado bottom sheet aberto, quando toca "Entrar com Google" e completa OAuth, então `signInWithIdToken` autentica no Supabase. |
| RF-05 | 🟢 O sistema deve carregar role após login real. | Must | Dado usuário não anônimo, quando auth state muda, então `_fetchUserRole` consulta `user_roles` e atualiza `_userRole`. |
| RF-06 | 🟢 O sistema deve criar role padrão para novo usuário. | Should | Dado login sem linha em `user_roles`, quando fetch retorna nulo, então insert com `role=user` e email do perfil. |
| RF-07 | 🟢 O sistema deve refletir mudança de role em tempo real. | Should | Dado admin altera role remota, quando Realtime dispara update, então `notifyListeners` atualiza permissões na UI. |
| RF-08 | 🟢 A UI deve bloquear escrita para anônimos. | Must | Dado `isAnonymous`, quando usuário tenta adicionar letra/categoria, então mensagem pede login Google. |
| RF-09 | 🟢 A UI deve exibir perfil autenticado no bottom sheet. | Should | Dado login Google, quando abre informações, então avatar, nome, email e badge de role aparecem. |
| RF-10 | 🟢 O usuário autenticado deve poder sair. | Must | Dado sessão Google/Supabase, quando "Sair", então `signOut` limpa sessão e UI volta ao estado visitante. |
| RF-11 | 🟢 Home deve atualizar role no pull-to-refresh. | Should | Dado refresh na Home, quando executa, então `refreshUserRole()` roda em paralelo ao sync. |
| RF-12 | 🟢 Leitura do acervo não exige login Google. | Must | Dado usuário anônimo, quando navega categorias/letras, então conteúdo é exibido normalmente. |
| RF-13 | 🟡 Upgrade anônimo → email/senha deve ser possível via API. | Could | Dado `upgradeToEmail` chamado com usuário anônimo, então `updateUser` com email e password retorna sucesso. |
| RF-14 | 🟢 Erros de login devem ser expostos à UI. | Should | Dado falha Google/Supabase, quando operação termina, então `error` contém mensagem e snackbar pode exibir. |
| RF-15 | 🟢 Usuário inativo não deve autenticar. | Must | Dado `user_roles.is_active = false`, quando tenta login Google ou sessão existente é validada, então acesso é negado e mensagem informa conta desativada. 🟡 Legado: não implementado. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Segurança | Autenticação delegada ao Supabase Auth + OAuth Google. | `supabase_flutter`, `signInWithIdToken` | 🟢 |
| Segurança | `serverClientId` (Web Client ID) fixo no código para obter `idToken`. | `auth_service.dart` L17-18 | 🟢 |
| Disponibilidade | Falha ao buscar role não impede app; fallback `user`. | catch em `_fetchUserRole` | 🟢 |
| UX | Estado de carregamento bloqueia botões durante login. | `_isLoading`, `isLoading` na UI | 🟢 |
| Observabilidade | Eventos auth logados via `debugPrint`. | `[AuthService]` prefix | 🟢 |
| Tempo real | Subscription por canal `public:user_roles:{userId}`. | `_subscribeToRoleChanges` | 🟢 |
| Consistência | Permissões UI espelham `has_role` SQL no servidor. | `permissions.md`, policies | 🟡 |
| Privacidade | Metadados Google (`full_name`, `avatar_url`) exibidos na UI. | getters `displayName`, `photoUrl` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado o app na primeira execução sem sessão
Quando a splash chama ensureAuthenticated
Então uma sessão anônima Supabase é criada

Dado usuário anônimo na tela de categoria
Quando tenta adicionar letra
Então aparece mensagem para fazer login com Google

Dado usuário visitante no bottom sheet
Quando completa login Google com sucesso
Então perfil, email e badge de role são exibidos

Dado usuário logado com role user
Quando tenta editar letra existente
Então ação é negada na UI (canEditLyrics=false)

Dado usuário logado como moderator
Quando abre formulário de letra
Então botão editar está disponível

Dado admin altera role do usuário no Supabase
Quando evento Realtime chega
Então AuthService atualiza permissões sem reiniciar app

Dado usuário autenticado
Quando toca Sair no bottom sheet
Então sessão Supabase é encerrada e estado volta a visitante

Dado usuário cancela seletor Google
Quando signInWithGoogle retorna
Então success=false e error contém Login cancelado
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Sessão anônima automática | Must | 🟢 Pré-requisito Supabase para app e sync. |
| Login Google | Must | 🟢 Identidade para contribuição ao acervo. |
| RBAC em `user_roles` | Must | 🟢 ADR 002; base de permissões. |
| Verificadores `can*` na UI | Must | 🟢 Proteção de escrita no cliente. |
| Realtime de role | Should | 🟢 Admin pode promover sem relogin. |
| Refresh de role no pull | Should | 🟢 Fallback se Realtime falhar. |
| `upgradeToEmail` | Could | 🟡 Implementado sem UI. |
| Bloqueio por `is_active` | Won't (legado) | 🔴 Lacuna documentada. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/auth_service.dart` | `AuthService`, login, RBAC, Realtime | 🟢 |
| `lib/main.dart` | `ChangeNotifierProvider<AuthService>` | 🟢 |
| `lib/screens/splash_screen.dart` | `ensureAuthenticated` | 🟢 |
| `lib/widgets/app_info_bottom_sheet.dart` | login/logout UI | 🟢 |
| `lib/screens/home_screen.dart` | avatar, refresh role, permissão categoria | 🟢 |
| `lib/screens/category_screen.dart` | permissão adicionar letra | 🟢 |
| `lib/screens/lyric_view_screen.dart` | editar/excluir letra | 🟢 |
| `lib/models/user_info.dart` | modelo admin (role, is_active) | 🟢 |
| `supabase/supabase_schema.sql` | `user_roles`, `has_role`, RLS, trigger signup | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `administracao` | Consome mesma tabela `user_roles`; altera roles que AuthService recebe via Realtime. |
| `sincronizacao-offline` | Opera em paralelo; sync de conteúdo não depende de Google login. |
| `edicao-letra` | Exige `canAddLyrics` / `canEditLyrics` / `canDeleteLyrics`. |
| `acervo-categorias` | Exige `canAddCategories` / `canEditCategories` / `canDeleteCategories`. |
| `onboarding-privacidade` | Splash encadeia auth antes de onboarding; política menciona login Google. |
