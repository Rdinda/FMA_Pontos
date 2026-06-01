# Interface: Mutações de acervo + RLS escrita

> Tipo: PostgREST / HTTP (Supabase)
> Feature: `002-sync-contract`
> Consumidor: `SupabaseService.upsertCategory`, `upsertLyric`, `deleteCategory`, `deleteLyric`
> Fase: A (RLS), B (gate client)

## Propósito

Contrato de **escrita** remota para acervo editorial. Complementa gate client-side (`AuthService.can*`) com enforcement Postgres via RLS.

## Endpoints (tabelas base)

| Operação | Método | Path | Body resumido |
|----------|--------|------|---------------|
| Upsert category | POST/PATCH | `/rest/v1/categories` | `id`, `name`, `code`, `updated_at`, `is_deleted` |
| Upsert lyric | POST/PATCH | `/rest/v1/lyrics` | campos lyric + `is_deleted` |
| Soft delete category | PATCH | `/rest/v1/categories?id=eq.{id}` | `{ "is_deleted": true, "updated_at": "..." }` |
| Soft delete lyric | PATCH | `/rest/v1/lyrics?id=eq.{id}` | idem |

**Nota:** Client atual usa `.upsert()` e `.update()` — não DELETE físico.

## Request — upsert lyric (exemplo)

```json
{
  "id": "uuid",
  "category_id": "cat-id",
  "title": "Título",
  "content": "Corpo",
  "updated_at": "2026-05-31T20:00:00.000Z",
  "audio_url": "https://.../file.mp3",
  "youtube_link": null,
  "sequence_number": 3,
  "is_deleted": false
}
```

## Matriz operação → permissão (client + RLS)

| Operação | Entidade | `AuthService` | RLS mínimo (`has_role`) |
|----------|----------|---------------|-------------------------|
| CREATE | lyrics | `canAddLyrics` | `user` |
| UPDATE | lyrics | `canEditLyrics` | `moderator` |
| Soft DELETE | lyrics | `canDeleteLyrics` | `admin` |
| CREATE | categories | `canAddCategories` | `moderator` |
| UPDATE | categories | `canEditCategories` | `moderator` |
| Soft DELETE | categories | `canDeleteCategories` | `admin` |

### Pré-condições comuns (todas mutações)

1. `auth.role() = 'authenticated'`
2. `(auth.jwt() ->> 'is_anonymous')::boolean IS NOT TRUE`
3. `user_roles.is_active = true` (validado client; RLS pode incluir check adicional)
4. Getter `can*` correspondente (client)

## Quem é negado

| Sujeito | PUSH acervo |
|---------|-------------|
| Anônimo | ❌ 403 / client skip |
| `user` UPDATE/DELETE letra | ❌ |
| `moderator` DELETE letra/categoria | ❌ |
| `is_active = false` | ❌ |

## Response

| Código | Significado |
|--------|-------------|
| 201 / 204 | Sucesso |
| 401 | Sem sessão |
| 403 | RLS violation — role insuficiente ou anônimo |
| 409 | Unique violation (`categories.code`) |

## Idempotência

- Upsert por `id` (PK text): repetir mesmo payload é idempotente.
- Soft delete repetido: `is_deleted=true` idempotente; `updated_at` bump a cada UPDATE.

## Timeouts / retry

- Falha rede: manter `is_synced=0` local; retry no próximo `syncData`.
- Não avançar cursor se PUSH falhou (RN-06).

## Leitura vs escrita

| Ação | Anônimo | Autenticado sem role editorial |
|------|---------|--------------------------------|
| PULL / SELECT sync views | ✅ | ✅ |
| INSERT/UPDATE acervo | ❌ | Conforme matriz |

## Storage (fora de escopo mutação SQL)

Upload/delete MP3: policies `storage.objects` bucket `audio` — inalteradas nesta feature exceto RN-12 (v1 não delete Storage no soft delete letra).

## Migration baseline

Referência: `supabase/migrations/20251226191350_initial_schema.sql` policies Insert/Update/Delete.

Fase A migration adiciona:
- SELECT filtrado `is_deleted = false` nas tabelas base
- Confirmação/revogação INSERT anônimo legado se existir em prod

Auditoria condicional: `20260531120100_sync_contract_rls_prod_audit.sql` (RF-B11).

## Rastreabilidade

- RF-A07, RF-B05–RF-B09, RN-03, RN-04
- `_reversa_sdd/permissions.md`
- `_reversa_sdd/sync-contract.md#7`
