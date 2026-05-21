# Administração — Fluxos Operacionais

## Fluxo 1 — Acesso à área administrativa

```mermaid
flowchart TD
  A["Usuário abre bottom sheet"] --> B{"authService.isAdmin?"}
  B -- "não" --> C["Item Administração oculto"]
  B -- "sim" --> D["ListTile Administração visível"]
  D --> E["Tap Administração"]
  E --> F["Navigator.pop bottom sheet"]
  F --> G["Navigator.push AdminScreen"]
  G --> H["initState: loadUsers + loadLogs"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Único gate documentado é `isAdmin` no bottom sheet.
- 🟡 **INFERIDO** — `AdminScreen` não revalida admin ao montar.
- 🟢 **CONFIRMADO** — Usuário precisa estar logado com Google (não anônimo) e ter role `admin` em `user_roles`.

## Fluxo 2 — Listar e buscar usuários

```mermaid
flowchart TD
  A["Aba Usuários"] --> B["_loadUsers"]
  B --> C["AdminService.fetchAllUsers"]
  C --> D["Supabase select user_roles"]
  D --> E{"sucesso?"}
  E -- "sim" --> F["_users = lista"]
  E -- "não" --> G["snackbar erro"]
  F --> H["Render ListView"]
  H --> I["Usuário digita busca"]
  I --> J["filter email contains query"]
  J --> K["filteredUsers na lista"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Busca é **client-side**; não dispara nova query Supabase.
- 🟢 **CONFIRMADO** — Lista vazia após filtro mostra "Nenhum usuário encontrado".
- 🟢 **CONFIRMADO** — Pull-to-refresh reexecuta fetch completo.

## Fluxo 3 — Alterar role de usuário

```mermaid
flowchart TD
  A["PopupMenu em usuário"] --> B{"valor selecionado"}
  B -- "user/moderator/admin" --> C["_updateUserRole"]
  C --> D["AdminService.updateUserRole"]
  D --> E["UPDATE user_roles"]
  E --> F{"sucesso?"}
  F -- "sim" --> G["_loadUsers + snackbar Role atualizada"]
  F -- "não" --> H["snackbar erro"]
  B -- "toggle_active" --> I["Fluxo 4"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Não há confirmação extra para mudança de role (apenas para ativo/inativo).
- 🟢 **CONFIRMADO** — Usuário afetado com app aberto recebe nova role via Realtime (`AuthService`).
- 🟢 **CONFIRMADO** — `updated_at` é gravado em ISO8601 no update.

## Fluxo 4 — Ativar ou desativar usuário

```mermaid
flowchart TD
  A["PopupMenu Desativar/Ativar"] --> B["_toggleUserActive"]
  B --> C["AlertDialog confirmação"]
  C --> D{"usuário confirmou?"}
  D -- "não" --> E["cancelar"]
  D -- "sim" --> F["setUserActive id, !isActive"]
  F --> G["UPDATE is_active"]
  G --> H{"sucesso?"}
  H -- "sim" --> I["_loadUsers + snackbar ativado/desativado"]
  H -- "não" --> J["snackbar erro"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Texto do dialog usa email do usuário.
- 🟢 **CONFIRMADO** — Visual inativo: `lineThrough`, chip cinza, ícone `person_off`.
- 🟢 **CONFIRMADO** — Usuário desativado não deve conseguir login (`is_active=false` bloqueia autenticação).  
- 🟡 **INFERIDO** — Legado ainda permite uso até policy/`AuthService` implementarem bloqueio.

## Fluxo 5 — Listar logs com filtros

```mermaid
flowchart TD
  A["Aba Logs init"] --> B["_loadLogs"]
  B --> C["fetchAuditLogs table start end limit 50"]
  C --> D["Montar query PostgREST"]
  D --> E["order created_at desc"]
  E --> F{"sucesso?"}
  F -- "sim" --> G["_logs = AuditLog list"]
  F -- "não" --> H["snackbar erro"]
  I["Dropdown tabela"] --> J["set _selectedTable"]
  J --> B
  K["DateRangePicker"] --> L["set _startDate _endDate"]
  L --> B
  M["Limpar filtros"] --> N["null dates e table"]
  N --> B
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Filtro de data exibe faixa formatada `dd/MM/yyyy` abaixo dos filtros.
- 🟢 **CONFIRMADO** — Ícone calendário fica destacado (primary) quando há range ativo.
- 🟢 **CONFIRMADO** — Botão clear só aparece se há filtro ativo.
- 🟢 **CONFIRMADO** — Limite fixo 50 registros por página (sem paginação "carregar mais").

## Fluxo 6 — Detalhar log de auditoria

```mermaid
flowchart TD
  A["Tap item log"] --> B["_showLogDetails"]
  B --> C["AlertDialog título actionLabel - tableLabel"]
  C --> D["recordId recordName userEmail data"]
  D --> E{"oldData?"}
  E -- "sim" --> F["Container vermelho JSON"]
  E -- "não" --> G["pular"]
  D --> H{"newData?"}
  H -- "sim" --> I["Container verde JSON"]
  H -- "não" --> J["pular"]
  F --> K["Botão Fechar"]
  I --> K
  G --> K
  J --> K
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `_formatJson` exclui `is_synced` e `is_deleted` da exibição.
- 🟢 **CONFIRMADO** — `recordName` para DELETE usa `old_data`; para INSERT/UPDATE usa `new_data`.
- 🟢 **CONFIRMADO** — Email ausente exibe "Desconhecido" / "Anônimo" na lista.

## Fluxo 7 — Geração de log (servidor — lacuna)

```mermaid
flowchart TD
  A["Mutação remota categories/lyrics"] --> B["Trigger Postgres audit"]
  B --> C["INSERT audit_logs"]
  C --> D["Campos: table record action old new user"]
  D --> E["Admin fetchAuditLogs lê registro"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Triggers `audit_categories` e `audit_lyrics` existem em produção (backup 2026-01-21).
- 🟢 **CONFIRMADO** — App espera ações `INSERT`, `UPDATE`, `DELETE` e tabelas `categories`, `lyrics`.

## Fluxo 8 — Estatísticas de logs (API não usada)

```mermaid
flowchart TD
  A["getAuditStats chamado"] --> B["COUNT audit_logs table=categories"]
  A --> C["COUNT audit_logs table=lyrics"]
  B --> D["Map categories lyrics"]
  C --> D
```

### Contrato do fluxo

- 🟡 **INFERIDO** — Método implementado para dashboard futuro; `AdminScreen` não invoca.
- 🟢 **CONFIRMADO** — Em erro retorna `{'categories': 0, 'lyrics': 0}`.

## Matriz fluxo × requisito

| Fluxo | RF relacionados |
|-------|-----------------|
| Acesso admin | RF-01 |
| Listar/buscar usuários | RF-02, RF-05, RF-10 |
| Alterar role | RF-03 |
| Ativar/desativar | RF-04 |
| Listar/filtrar logs | RF-06, RF-07, RF-08, RF-10 |
| Detalhe log | RF-09 |
| Geração servidor | RF-13 |
| Stats API | RF-12 |
