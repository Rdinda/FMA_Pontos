# Administração — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 `AuthService` com `isAdmin` e login Google funcional.
- [ ] 🟢 Tabela `user_roles` com RLS e policy "Admins can manage roles".
- [ ] 🟢 Função SQL `has_role('admin')` alinhada ao cliente.
- [ ] 🔴 Tabela `audit_logs` criada no Supabase com policies SELECT para admin.
- [ ] 🔴 Triggers em `categories` e `lyrics` gravando INSERT/UPDATE/DELETE em `audit_logs`.
- [ ] 🟡 Coluna `is_active` em `user_roles` (migration explícita).
- [ ] 🟢 Pacote `intl` para formatação de datas pt-BR.

## Tarefas — Models

- [ ] T-01, Implementar `UserInfo`
  - Origem no legado: `lib/models/user_info.dart`
  - Critério de pronto: `fromMap`/`toMap` com `id`, `email`, `role`, `is_active`, `avatar_url`, timestamps; getters `roleLabel`.
  - Confiança: 🟢

- [ ] T-02, Implementar `AuditLog`
  - Origem no legado: `lib/models/audit_log.dart`
  - Critério de pronto: `fromMap`; getters `actionLabel`, `tableLabel`, `recordName` para categorias e letras.
  - Confiança: 🟢

## Tarefas — AdminService

- [ ] T-03, Implementar `fetchAllUsers`
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: `select()` em `user_roles` ordenado por `created_at` desc; mapeia para `List<UserInfo>`.
  - Confiança: 🟢

- [ ] T-04, Implementar `updateUserRole`
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: `update({role, updated_at}).eq('id', userId)`; propaga exceção.
  - Confiança: 🟢

- [ ] T-05, Implementar `setUserActive`
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: `update({is_active, updated_at}).eq('id', userId)`.
  - Confiança: 🟢

- [ ] T-06, Implementar `fetchAuditLogs` com filtros
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: filtros opcionais `table_name`, `startDate`, `endDate` (+1 dia), `limit` default 50, order desc.
  - Confiança: 🟢

- [ ] T-07, Implementar `fetchAuditLogById` (opcional UI)
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: `maybeSingle` por id; retorna null em erro.
  - Confiança: 🟢

- [ ] T-08, Implementar `getAuditStats` (opcional UI)
  - Origem no legado: `admin_service.dart`
  - Critério de pronto: counts exatos para `categories` e `lyrics`; fallback zeros em erro.
  - Confiança: 🟡

## Tarefas — AdminScreen UI

- [ ] T-09, Implementar scaffold com TabBar Usuários/Logs
  - Origem no legado: `admin_screen.dart`
  - Critério de pronto: `TabController(length: 2)`; ícones people/history.
  - Confiança: 🟢

- [ ] T-10, Implementar aba Usuários com loading e refresh
  - Origem no legado: `_buildUsersTab`
  - Critério de pronto: `CircularProgressIndicator` durante load; `RefreshIndicator` chama `_loadUsers`.
  - Confiança: 🟢

- [ ] T-11, Implementar busca local por email
  - Origem no legado: `TextField` + `_userSearchQuery`
  - Critério de pronto: filtra `_users` em memória; botão clear no suffix.
  - Confiança: 🟢

- [ ] T-12, Implementar card de usuário com PopupMenu
  - Origem no legado: `ListTile` + menu roles + toggle active
  - Critério de pronto: três itens de role, divider, ativar/desativar; chips visuais por role e inativo.
  - Confiança: 🟢

- [ ] T-13, Implementar confirmação de ativar/desativar
  - Origem no legado: `_toggleUserActive`
  - Critério de pronto: `AlertDialog` antes de `setUserActive`; snackbar de sucesso/erro.
  - Confiança: 🟢

- [ ] T-14, Implementar aba Logs com filtros
  - Origem no legado: `_buildLogsTab`
  - Critério de pronto: dropdown tabela (todas/categories/lyrics); date range picker pt-BR; botão limpar filtros.
  - Confiança: 🟢

- [ ] T-15, Implementar lista de logs com ícones por ação
  - Origem no legado: `_buildActionIcon`, `ListView.builder`
  - Critério de pronto: título `actionLabel de tableLabel`; subtítulo recordName + email + data.
  - Confiança: 🟢

- [ ] T-16, Implementar dialog de detalhe do log
  - Origem no legado: `_showLogDetails`, `_formatJson`
  - Critério de pronto: exibe metadados e JSON old/new omitindo flags de sync local.
  - Confiança: 🟢

## Tarefas — Navegação e Segurança

- [ ] T-17, Expor entrada Administração no bottom sheet
  - Origem no legado: `app_info_bottom_sheet.dart`
  - Critério de pronto: `if (authService.isAdmin)` mostra ListTile que navega para `AdminScreen`.
  - Confiança: 🟢

- [ ] T-18, Adicionar route guard na AdminScreen (melhoria)
  - Origem no legado: lacuna — tela não verifica role no `initState`
  - Critério de pronto: se `!isAdmin`, pop ou tela de acesso negado.
  - Confiança: 🟡

## Tarefas — Backend Supabase

- [ ] T-19, Criar tabela `audit_logs` e RLS SELECT admin
  - Origem no legado: lacuna no repo
  - Critério de pronto: colunas compatíveis com `AuditLog.fromMap`; apenas admin lê.
  - Confiança: 🔴

- [ ] T-20, Criar triggers de auditoria em categories/lyrics
  - Origem no legado: lacuna
  - Critério de pronto: cada mutação remota grava log com user_id/email do `auth.uid()`.
  - Confiança: 🔴

- [ ] T-21, Adicionar migration `is_active` em user_roles
  - Origem no legado: app usa campo; schema base não
  - Critério de pronto: `BOOLEAN DEFAULT true`; compatível com `UserInfo.fromMap`.
  - Confiança: 🔴

- [ ] T-22, Bloquear usuário inativo em RLS ou Auth
  - Origem no legado: lacuna cross-unit com autenticacao
  - Critério de pronto: `is_active=false` impede mutações ou invalida sessão.
  - Confiança: 🔴

## Ordem sugerida

1. T-19 → T-21 (schema Supabase)
2. T-01 → T-02 (models)
3. T-03 → T-08 (AdminService)
4. T-09 → T-16 (AdminScreen)
5. T-17 → T-18 (navegação/guard)
6. T-20, T-22 (auditoria e enforcement)
