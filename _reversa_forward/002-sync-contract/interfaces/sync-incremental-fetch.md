# Interface: Fetch incremental sync (views `sync_*`)

> Tipo: PostgREST / HTTP (Supabase)
> Feature: `002-sync-contract`
> Consumidor: `SupabaseService.fetchCategories`, `SupabaseService.fetchLyrics`
> Fase: A

## Propósito

Canal de leitura para **sincronização incremental** incluindo tombstones (`is_deleted = true`). Complementa SELECT público nas tabelas base, que filtra deletados para UI/PostgREST anônimo direto.

## Endpoints

| Operação | Método | Path PostgREST | View |
|----------|--------|----------------|------|
| List categories since cursor | GET | `/rest/v1/sync_categories` | `public.sync_categories` |
| List lyrics since cursor | GET | `/rest/v1/sync_lyrics` | `public.sync_lyrics` |

### Query parameters

| Parâmetro | Valor | Obrigatório |
|-----------|-------|-------------|
| `select` | `*` (default client) | não |
| `updated_at` | `gt.{iso8601}` | sim quando incremental |
| `order` | `updated_at.asc` (opcional) | não |

**Exemplo:**

```
GET /rest/v1/sync_lyrics?updated_at=gt.2026-05-30T12:00:00.000Z
Headers:
  apikey: {SUPABASE_ANON_KEY}
  Authorization: Bearer {session_jwt_or_anon}
```

## Response

### `sync_categories` — 200 OK

```json
[
  {
    "id": "uuid-text",
    "name": "Ogum",
    "code": "OGM",
    "updated_at": "2026-05-31T18:00:00.000Z",
    "is_deleted": false
  },
  {
    "id": "uuid-deleted",
    "name": "Removed",
    "code": "RMV",
    "updated_at": "2026-05-31T19:00:00.000Z",
    "is_deleted": true
  }
]
```

### `sync_lyrics` — 200 OK

```json
[
  {
    "id": "uuid-text",
    "category_id": "cat-id",
    "title": "Ponto",
    "content": "...",
    "audio_url": "https://.../audio/lyrics/file.mp3",
    "youtube_link": null,
    "sequence_number": 1,
    "updated_at": "2026-05-31T18:00:00.000Z",
    "is_deleted": false
  }
]
```

**Nota:** `local_audio_path` nunca aparece — somente SQLite.

## Erros

| Código | Condição | Client behavior |
|--------|----------|-----------------|
| 401 | JWT inválido | Renovar sessão via `AuthService` |
| 404 | View não deployada | Bloquear sync; exibir erro deploy Fase A |
| 500 | Erro Postgres | Retry; não avançar cursor (RN-06) |

## Idempotência

Leitura idempotente. Mesmo `since` pode retornar mesmos registros se `updated_at` unchanged — client usa upsert/hardDelete por id.

## Timeouts

- Client Supabase default (~60s). Sync batch deve tratar timeout como falha PULL parcial.

## Segurança

- View `SECURITY DEFINER` owned by role com `search_path = public`.
- `GRANT SELECT` a `anon` e `authenticated` — tombstones legíveis via anon key **somente** nesta view, não na tabela base filtrada.
- Escritas **não** usam views; continuam em `categories`/`lyrics` com RLS.

## Mapeamento Dart

```dart
// SupabaseService — alvo
client.from('sync_categories').select().gt('updated_at', sinceIso);
client.from('sync_lyrics').select().gt('updated_at', sinceIso);
// Category.fromMap / Lyric.fromMap — is_deleted já suportado
```

## Rastreabilidade

- RF-A03, RN-11
- `_reversa_sdd/sync-contract.md#5.2`, `#12 Q1`
