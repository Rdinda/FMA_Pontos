# ADR 002 — RBAC com Google Sign-In e administração no app

Data inferida: 2025-12-25  
Fonte: commit `7a3ad4f feat: Implementa área administrativa com auditoria, gestão de roles e autenticação Google.`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O app diferencia consulta pública de manutenção do acervo.

🟢 **CONFIRMADO** — Foram adicionados `AuthService`, `AdminService`, `user_roles`, tela administrativa e logs de auditoria.

## Decisão

Adotar papéis hierárquicos:

- `user`: adiciona letras;
- `moderator`: adiciona/edita categorias e letras;
- `admin`: exclui, gerencia usuários e consulta administração.

Login Google é usado para identificar usuários reais; sessões anônimas permanecem sem permissões de escrita.

## Consequências

- 🟢 **CONFIRMADO** — O app evita edição anônima do acervo.
- 🟢 **CONFIRMADO** — Administração pode ser feita pelo próprio app.
- 🟡 **INFERIDO** — A segurança depende de alinhamento entre UI e Supabase RLS.
- 🔴 **LACUNA** — `is_active` ainda precisa ser confirmado como bloqueio real em policy/serviço.

