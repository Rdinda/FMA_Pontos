# Administração — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a área administrativa do app: gestão de usuários (`user_roles`) e consulta de logs de auditoria (`audit_logs`), acessível apenas a usuários com role `admin`.  
🟢 **CONFIRMADO** — `AdminScreen` possui duas abas: **Usuários** e **Logs**, orquestradas por `AdminService` contra Supabase PostgREST.  
🟢 **CONFIRMADO** — Entrada na tela via bottom sheet de informações quando `AuthService.isAdmin` é verdadeiro.  
🟢 **CONFIRMADO** — `audit_logs`, `audit_trigger_func()` e triggers em `categories`/`lyrics` existem em produção (backup `db_cluster-21-01-2026@04-10-08.backup`). SQL extraído: `_reversa_sdd/supabase-extracted/audit_logs.sql`.  
🟡 **INFERIDO** — DDL ainda não versionada no repo legado (`supabase_schema.sql` incompleto).  
🟢 **CONFIRMADO** — Coluna `is_active` existe em produção em `user_roles` (backup); ausente apenas no schema versionado do repo.

Referência: ADR 002 — `_reversa_sdd/adrs/002-rbac-google-admin.md`.

## Responsabilidades

- 🟢 **CONFIRMADO** — Listar todos os registros de `user_roles` ordenados por `created_at` descendente.
- 🟢 **CONFIRMADO** — Permitir alterar role de usuário para `user`, `moderator` ou `admin`.
- 🟢 **CONFIRMADO** — Permitir ativar/desativar usuário via flag `is_active`.
- 🟢 **CONFIRMADO** — Filtrar usuários localmente por email (busca client-side).
- 🟢 **CONFIRMADO** — Listar logs de auditoria com limite padrão de 50 registros.
- 🟢 **CONFIRMADO** — Filtrar logs por tabela (`categories`, `lyrics`), intervalo de datas e exibir detalhe em dialog.
- 🟡 **INFERIDO** — `getAuditStats` agrega contagem por tabela mas **não é consumido** pela UI atual.
- 🟢 **CONFIRMADO** — Propagar mudança de role ao usuário afetado via Realtime do `AuthService` (unit `autenticacao`).

## Regras de Negócio

- 🟢 **CONFIRMADO** — Apenas `admin` acessa o menu "Administração" no bottom sheet (`authService.isAdmin`).
- 🟢 **CONFIRMADO** — `AdminScreen` **não** revalida role na rota; confia no gate da UI de entrada.
- 🟢 **CONFIRMADO** — Alteração de role atualiza `user_roles.role` e `updated_at` no Supabase.
- 🟢 **CONFIRMADO** — Ativar/desativar exige confirmação em `AlertDialog` antes de persistir.
- 🟢 **CONFIRMADO** — Usuário inativo exibe email riscado, chip "Inativo" e avatar acinzentado.
- 🟢 **CONFIRMADO** — PopupMenu oferece três roles + divider + toggle ativo/inativo.
- 🟢 **CONFIRMADO** — Logs filtrados por `table_name` quando dropdown selecionado; `null` = todas.
- 🟢 **CONFIRMADO** — Filtro de data usa `gte(created_at, start)` e `lt(created_at, end+1 dia)` para incluir dia final.
- 🟢 **CONFIRMADO** — Detalhe do log exibe `old_data` e `new_data` formatados, omitindo `is_synced` e `is_deleted` na visualização.
- 🟢 **CONFIRMADO** — `recordName` deriva de `name` (categorias) ou `title` (letras) nos JSONs do log.
- 🟢 **CONFIRMADO** — Policy Supabase "Admins can manage roles" exige `has_role('admin')` para mutações em `user_roles`.
- 🟢 **CONFIRMADO** — Desativar usuário (`is_active=false`) deve **bloquear login** do afetado (Roberto, 2026-05-20).  
- 🟡 **INFERIDO** — Legado não invalida sessão nem bloqueia `AuthService` após desativação.
- 🔴 **LACUNA** — Permissão SELECT em `audit_logs` para admin não está documentada no schema versionado (revokes amplos na migration).

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 Apenas admin deve ver entrada de administração. | Must | Dado role não admin, quando abre bottom sheet, então item Administração não aparece. |
| RF-02 | 🟢 Admin deve listar usuários com roles. | Must | Dado admin na aba Usuários, quando tela carrega, então lista `user_roles` com email, chip de role e status. |
| RF-03 | 🟢 Admin deve alterar role de usuário. | Must | Dado popup "Definir como Moderador", quando confirma, então `updateUserRole` persiste e lista recarrega. |
| RF-04 | 🟢 Admin deve ativar/desativar usuário com confirmação. | Must | Dado toggle desativar, quando confirma dialog, então `is_active=false` no registro. |
| RF-05 | 🟢 Admin deve buscar usuários por email. | Should | Dado texto no campo busca, quando digita, então lista filtra client-side por substring do email. |
| RF-06 | 🟢 Admin deve listar logs de auditoria. | Must | Dado aba Logs, quando carrega, então até 50 logs mais recentes são exibidos. |
| RF-07 | 🟢 Admin deve filtrar logs por tabela. | Should | Dado dropdown Categorias, quando seleciona, então query usa `eq('table_name','categories')`. |
| RF-08 | 🟢 Admin deve filtrar logs por período. | Should | Dado date range picker, quando confirma intervalo, então logs recarregam com filtro de datas. |
| RF-09 | 🟢 Admin deve ver detalhe de um log. | Must | Dado tap em item, quando abre dialog, então mostra ação, tabela, registro, usuário, old/new data. |
| RF-10 | 🟢 Listas devem suportar pull-to-refresh. | Should | Dado gesto refresh, quando solta, então `_loadUsers` ou `_loadLogs` reexecuta. |
| RF-11 | 🟢 Erros de API devem exibir snackbar. | Should | Dado falha Supabase, quando catch, então snackbar vermelho com mensagem de erro. |
| RF-12 | 🟡 Estatísticas agregadas de logs devem estar disponíveis via API. | Could | Dado `getAuditStats`, quando chamado, então retorna contagem por `categories` e `lyrics`. |
| RF-13 | 🔴 Logs devem ser gerados automaticamente em CRUD de acervo. | Must | Dado insert/update/delete remoto em categories/lyrics, então linha em `audit_logs` é criada (requer trigger remoto). |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Segurança | Mutações em `user_roles` restritas a admin via RLS. | `supabase_schema.sql` policy | 🟢 |
| Segurança | Tela admin sem guard de rota dedicado. | Navegação direta possível se URL/rota exposta | 🟡 |
| Performance | Busca de usuários é client-side (sem paginação). | `_userSearchQuery` filtra lista em memória | 🟢 |
| Performance | Logs limitados a 50 por consulta. | `limit: 50` default | 🟢 |
| UX | Locale pt-BR no seletor de datas. | `Locale('pt','BR')` | 🟢 |
| Observabilidade | Erros logados com `debugPrint('[AdminService]')`. | catch blocks | 🟢 |
| Consistência | Role alterada reflete em sessão ativa via Realtime. | `AuthService` subscription | 🟢 |

## Critérios de Aceitação

```gherkin
Dado usuário com role admin autenticado
Quando abre bottom sheet de informações
Então vê item Administração com subtítulo Gerenciar usuários e logs

Dado admin na aba Usuários
Quando seleciona Definir como Admin no menu de um usuário
Então role é atualizada no Supabase e snackbar confirma

Dado admin tenta desativar usuário
Quando confirma o AlertDialog
Então usuário aparece com chip Inativo e email riscado

Dado admin na aba Logs com filtro Letras
Quando aplica filtro
Então apenas logs com table_name=lyrics são listados

Dado admin seleciona intervalo de datas
Quando confirma DateRangePicker
Então logs do período são recarregados

Dado admin toca um log na lista
Quando dialog abre
Então exibe JSON de dados anteriores e novos formatados

Dado usuário não admin
Quando tenta acessar AdminScreen por deep link
Então tela pode abrir sem bloqueio explícito no código atual
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Gate UI admin | Must | 🟢 Controle de acesso principal no cliente. |
| CRUD de roles | Must | 🟢 Núcleo da feature administrativa. |
| Ativar/desativar usuário | Should | 🟢 Implementado; enforcement incompleto |
| Consulta de audit logs | Must | 🟢 Segunda aba da tela |
| Filtros de logs | Should | 🟢 Operacional para investigação |
| Busca local de usuários | Should | 🟢 UX em listas pequenas |
| `getAuditStats` na UI | Could | 🟡 API sem consumidor |
| Schema/triggers audit_logs no repo | Won't (legado) | 🔴 Lacuna documentada |
| Route guard server-side | Should | 🟡 Melhoria de segurança |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/admin_service.dart` | `AdminService` | 🟢 |
| `lib/screens/admin_screen.dart` | `AdminScreen`, abas, filtros | 🟢 |
| `lib/models/user_info.dart` | `UserInfo`, `isActive`, `roleLabel` | 🟢 |
| `lib/models/audit_log.dart` | `AuditLog`, labels, `recordName` | 🟢 |
| `lib/widgets/app_info_bottom_sheet.dart` | link Administração | 🟢 |
| `lib/services/auth_service.dart` | `isAdmin` gate | 🟢 |
| `supabase/supabase_schema.sql` | RLS `user_roles` admin | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `autenticacao` | Fornece `isAdmin`; recebe updates de role via Realtime. |
| `acervo-categorias` / `edicao-letra` | Operações CRUD geram entradas em `audit_logs` (remoto). |
| `sincronizacao-offline` | Independente; admin opera só no Supabase. |
