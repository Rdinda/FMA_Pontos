# Interface: RPC `increment_play_count`

> Tipo: PostgREST RPC / HTTP (Supabase)
> Feature: `002-sync-contract`
> Consumidor: `PlayStatsService.incrementAccessCount`, `PlayStatsService.flushPendingAccessEvents`
> Fases: A (deploy), C (flush offline)

## Propósito

Incremento **atômico** de `lyric_play_stats.play_count` por abertura de tela de letra. Substitui INSERT/UPDATE direto client como caminho preferencial.

## Endpoint

```
POST /rest/v1/rpc/increment_play_count
```

### Headers

```
apikey: {SUPABASE_ANON_KEY}
Authorization: Bearer {authenticated_non_anonymous_jwt}
Content-Type: application/json
```

### Request body

```json
{
  "p_lyric_id": "uuid-text-da-letra"
}
```

| Campo | Tipo | Obrigatório | Validação |
|-------|------|-------------|-----------|
| `p_lyric_id` | `text` | sim | FK lógica → `lyrics.id` existente |

## Response

### 204 / 200 empty

Sucesso — sem body. `play_count` incrementado em 1; `last_played_at` e `updated_at` atualizados.

### Semântica SQL (SECURITY DEFINER)

```sql
INSERT INTO lyric_play_stats (lyric_id, play_count, last_played_at, updated_at)
VALUES (p_lyric_id, 1, now(), now())
ON CONFLICT (lyric_id) DO UPDATE SET
  play_count = lyric_play_stats.play_count + 1,
  last_played_at = now(),
  updated_at = now();
```

## Erros

| Código | Condição | Client behavior |
|--------|----------|-----------------|
| 401 | Não autenticado | Não chamar; offline → fila (Fase C) |
| 403 | JWT anônimo ou RLS | Não incrementar; anônimo não enfileira (RN-05) |
| 404 | RPC ausente | **Gap G4** — deploy Fase A obrigatório |
| 409 / FK | `lyric_id` inexistente remoto | Log; descartar evento ou retry após PULL |

## Idempotência

**Não idempotente por design:** cada chamada = +1 intencional (RF-C05). Flush offline chama N vezes para N aberturas.

Retry seguro: duplicate RPC incrementa +1 extra — client marca `is_flushed=1` só após sucesso; falha parcial mantém eventos pendentes (RN confiabilidade).

## Timeouts

- Online: falha → **não** usar fallback INSERT direto se RPC deployada (restringir policies Fase A).
- Offline: enqueue local (Fase C).

## Segurança

- `SECURITY DEFINER` — executa com privilégios owner.
- `GRANT EXECUTE TO authenticated` — anônimo **não** executa.
- Revogar INSERT/UPDATE client direto em `lyric_play_stats` (RF-A07).

## Mapeamento Dart

```dart
await _client.rpc('increment_play_count', params: {'p_lyric_id': lyricId});
```

## Flush offline (Fase C)

Para cada linha `pending_access_events WHERE is_flushed=0 ORDER BY id`:

1. RPC `increment_play_count(lyric_id)`
2. `UPDATE pending_access_events SET is_flushed=1 WHERE id=?`

v1: **sem batch** (Q3 clarify).

## Rastreabilidade

- RF-A06, RF-C03, RF-C04
- `_reversa_sdd/supabase-extracted/increment_play_count-proposed.sql`
- `_reversa_sdd/openapi/supabase-consumed-surfaces.md#RPC`
