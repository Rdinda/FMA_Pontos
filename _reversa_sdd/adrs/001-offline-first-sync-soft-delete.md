# ADR 001 — Sincronização incremental offline-first com soft delete

Data inferida: 2026-01-14  
Fonte: commit `42c67f9 feat(sync): implement incremental sync with soft delete`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O app precisa funcionar offline e manter um acervo local em SQLite, sincronizando com Supabase quando há conexão.

🟢 **CONFIRMADO** — O commit substituiu hard deletes por soft deletes, adicionou sync incremental por timestamp e removeu lógica de apagar dados locais ausentes no servidor.

## Decisão

Usar `is_synced`, `is_deleted` e `last_sync_timestamp` para coordenar push/pull incremental:

- alterações locais ficam `is_synced = 0`;
- exclusões ficam `is_deleted = 1`;
- pull busca registros alterados após o último sync;
- hard delete local só ocorre depois que a exclusão é propagada ou recebida do remoto.

## Consequências

- 🟢 **CONFIRMADO** — Reduz risco de apagar localmente dados legítimos que não vieram em uma consulta incremental.
- 🟢 **CONFIRMADO** — Permite propagar exclusões entre dispositivos.
- 🟡 **INFERIDO** — Exige disciplina para que toda mutação remota atualize `updated_at`.
- 🔴 **LACUNA** — Estratégia de conflito simultâneo não está documentada.

