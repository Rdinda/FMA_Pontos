# Autenticação — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 `supabase_flutter` inicializado em `main()` com `SUPABASE_URL` e `SUPABASE_ANON_KEY`.
- [ ] 🟢 Auth anônimo habilitado no projeto Supabase.
- [ ] 🟢 Provider Google configurado no Supabase Dashboard (OAuth).
- [ ] 🟢 Tabela `user_roles` com RLS, funções `get_user_role` / `has_role` e trigger de signup.
- [ ] 🟢 `google_sign_in` ^6.x com Web Client ID (`serverClientId`) alinhado ao projeto Google Cloud.
- [ ] 🟢 `Provider` / `ChangeNotifierProvider` na árvore raiz do app.

## Tarefas — AuthService Core

- [ ] T-01, Implementar `AuthService` como `ChangeNotifier`
  - Origem no legado: `lib/services/auth_service.dart`
  - Critério de pronto: classe expõe estado de usuário, loading, error e notifica listeners em mudanças.
  - Confiança: 🟢

- [ ] T-02, Registrar listener `onAuthStateChange`
  - Origem no legado: `_init()` em `auth_service.dart`
  - Critério de pronto: atualiza `_currentUser`; em login não anônimo chama `_fetchUserRole` e `_subscribeToRoleChanges`; em `signedOut` reseta role e remove subscription.
  - Confiança: 🟢

- [ ] T-03, Restaurar sessão na inicialização
  - Origem no legado: `_init()` — `currentSession`
  - Critério de pronto: se sessão persistida existe, `_currentUser` é preenchido; `isInitialized=true` ao final.
  - Confiança: 🟢

- [ ] T-04, Implementar `ensureAuthenticated`
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: retorna true se já autenticado; recupera sessão; senão `signInAnonymously`; protege reentrância com `_isLoading`.
  - Confiança: 🟢

- [ ] T-05, Implementar hierarquia `hasRole` e getters `can*`
  - Origem no legado: `hasRole`, `canAddLyrics`, etc.
  - Critério de pronto: espelha SQL `has_role`; todos os `can*` exigem `!isAnonymous`.
  - Confiança: 🟢

## Tarefas — RBAC e Realtime

- [ ] T-06, Implementar `_fetchUserRole`
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: `select role from user_roles where id = currentUser.id`; fallback `user` em erro ou ausência.
  - Confiança: 🟢

- [ ] T-07, Implementar `_createUserRole`
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: insert `id`, `email`, `role=user`, `avatar_url` quando registro ausente.
  - Confiança: 🟢

- [ ] T-08, Implementar subscription Realtime de role
  - Origem no legado: `_subscribeToRoleChanges`, `_unsubscribeFromRoleChanges`
  - Critério de pronto: canal filtrado por `id`; callback atualiza `_userRole` e `notifyListeners`; cleanup em logout.
  - Confiança: 🟢

- [ ] T-09, Implementar `refreshUserRole`
  - Origem no legado: método público delegando a `_fetchUserRole`
  - Critério de pronto: pode ser chamado pela Home no pull-to-refresh.
  - Confiança: 🟢

## Tarefas — Google Sign-In

- [ ] T-10, Configurar `GoogleSignIn` com `serverClientId` e scope `email`
  - Origem no legado: construtor em `auth_service.dart`
  - Critério de pronto: instância única no serviço; Web Client ID do mesmo projeto GCP/Supabase.
  - Confiança: 🟢

- [ ] T-11, Implementar `signInWithGoogle`
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: fluxo signIn → idToken → `signInWithIdToken`; trata cancelamento, ausência de token e `ApiException: 10`.
  - Confiança: 🟢

- [ ] T-12, Implementar `signOut`
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: tenta `GoogleSignIn.signOut` (ignora erro); `Supabase.auth.signOut`; `_currentUser=null`.
  - Confiança: 🟢

- [ ] T-13, Implementar `upgradeToEmail` (opcional)
  - Origem no legado: `auth_service.dart`
  - Critério de pronto: só para usuário anônimo; `updateUser` com email/password; atualiza `_currentUser`.
  - Confiança: 🟡

## Tarefas — Integração UI

- [ ] T-14, Registrar `AuthService` no `MultiProvider`
  - Origem no legado: `lib/main.dart`
  - Critério de pronto: `ChangeNotifierProvider(create: (_) => AuthService())` antes das telas.
  - Confiança: 🟢

- [ ] T-15, Chamar `ensureAuthenticated` na splash
  - Origem no legado: `lib/screens/splash_screen.dart`
  - Critério de pronto: executado após delay/permissões e antes de decidir onboarding vs home.
  - Confiança: 🟢

- [ ] T-16, Implementar bottom sheet de perfil/login
  - Origem no legado: `lib/widgets/app_info_bottom_sheet.dart`
  - Critério de pronto: estados visitante vs autenticado; botão Google com loading; snackbar sucesso/erro; botão Sair; link admin se `isAdmin`.
  - Confiança: 🟢

- [ ] T-17, Exibir avatar na Home quando logado
  - Origem no legado: `lib/screens/home_screen.dart`
  - Critério de pronto: `CircleAvatar` com `photoUrl` abre bottom sheet; senão ícone info.
  - Confiança: 🟢

- [ ] T-18, Atualizar role no pull-to-refresh da Home
  - Origem no legado: `home_screen.dart` — `Future.wait` com `refreshUserRole`
  - Critério de pronto: refresh paralelo a `syncData`.
  - Confiança: 🟢

- [ ] T-19, Bloquear ações sem permissão nas telas de acervo
  - Origem no legado: `category_screen.dart`, `lyric_view_screen.dart`, `home_screen.dart`
  - Critério de pronto: checagem `can*` antes de navegar/editar; mensagem diferenciada para anônimo vs role insuficiente.
  - Confiança: 🟢

## Tarefas — Backend Supabase

- [ ] T-20, Criar tabela e RLS `user_roles`
  - Origem no legado: `supabase/supabase_schema.sql`
  - Critério de pronto: PK `id` → `auth.users`; CHECK em `role`; policies SELECT própria + ALL admin.
  - Confiança: 🟢

- [ ] T-21, Criar funções `get_user_role` e `has_role`
  - Origem no legado: `supabase_schema.sql`
  - Critério de pronto: hierarquia idêntica ao Dart; usadas nas policies de `categories`/`lyrics`.
  - Confiança: 🟢

- [ ] T-22, Habilitar Realtime em `user_roles`
  - Origem no legado: `ALTER PUBLICATION supabase_realtime ADD TABLE user_roles`
  - Critério de pronto: updates de role chegam ao cliente mobile.
  - Confiança: 🟢

- [ ] T-23, Trigger de criação automática no signup
  - Origem no legado: `handle_new_user` em schema SQL
  - Critério de pronto: novo usuário auth recebe linha `user_roles` com role default.
  - Confiança: 🟢

## Tarefas — Qualidade e Lacunas

- [ ] T-24, Validar bloqueio de `is_active` (lacuna)
  - Origem no legado: `UserInfo.isActive`, `AdminService`
  - Critério de pronto: definir se sessão/token deve ser invalidada quando admin desativa usuário; alinhar RLS e `AuthService`.
  - Confiança: 🔴

- [ ] T-25, Externalizar `serverClientId` para build config
  - Origem no legado: constante em `auth_service.dart`
  - Critério de pronto: `--dart-define=GOOGLE_SERVER_CLIENT_ID=...` por flavor/ambiente.
  - Confiança: 🟡

## Ordem sugerida de implementação

1. T-20 → T-23 (Supabase)
2. T-01 → T-05 (core + sessão anônima)
3. T-06 → T-09 (RBAC + Realtime)
4. T-10 → T-12 (Google)
5. T-14 → T-19 (UI)
6. T-24, T-25 (hardening)
