# Funções e Procedures — FMA_Pontos (`public`)

> Data Master · 2026-05-31

## Funções de domínio (`public`)

### `get_user_role()` → `text`

| Atributo | Valor |
|----------|-------|
| Linguagem | `plpgsql` |
| Security | `SECURITY DEFINER` |
| Retorno | Role do `auth.uid()` em `user_roles`, default `'user'` |
| Confiança | 🟢 backup + migration |

```sql
-- Resumo: COALESCE((SELECT role FROM user_roles WHERE id = auth.uid()), 'user')
```

Usada implicitamente por `has_role()` e policies RLS.

---

### `has_role(required_role text)` → `boolean`

| Atributo | Valor |
|----------|-------|
| Security | `SECURITY DEFINER` |
| Parâmetro | `required_role`: `'user'`, `'moderator'`, `'admin'` |
| Lógica | Hierarquia inclusiva (admin satisfaz moderator e user) |
| Confiança | 🟢 |

Espelha `AuthService.hasRole()` no Flutter.

---

### `is_admin()` → `boolean`

| Atributo | Valor |
|----------|-------|
| Linguagem | `sql` |
| Security | `SECURITY DEFINER` |
| Retorno | `EXISTS (SELECT 1 FROM user_roles WHERE id = auth.uid() AND role = 'admin')` |
| Confiança | 🟢 |

---

### `is_admin(user_uuid uuid)` → `boolean`

| Atributo | Valor |
|----------|-------|
| Linguagem | `plpgsql` |
| Security | `SECURITY DEFINER` |
| Uso | Checagem por UUID explícito (admin panel / policies) |
| Confiança | 🟢 |

Policy `Admins can update user roles` usa `is_admin(auth.uid())`.

---

### `get_next_lyric_sequence(cat_id text)` → `integer`

| Atributo | Valor |
|----------|-------|
| Linguagem | `plpgsql` |
| Security | `SECURITY DEFINER` (migration repo) / owner postgres no backup |
| Lógica | `MAX(sequence_number)+1` para `category_id` |
| Confiança | 🟢 |

🟡 App pode calcular sequência localmente também — validar chamada RPC vs cliente.

---

### `handle_new_user()` → `trigger`

| Atributo | Valor |
|----------|-------|
| Evento | AFTER INSERT ON `auth.users` |
| Ação | `INSERT INTO user_roles (id, email, role) VALUES (new.id, new.email, 'user') ON CONFLICT DO NOTHING` |
| Confiança | 🟢 |

---

### `audit_trigger_func()` → `trigger`

| Atributo | Valor |
|----------|-------|
| Eventos | AFTER INSERT/UPDATE/DELETE em `categories`, `lyrics` |
| Ação | INSERT em `audit_logs` com snapshot JSON |
| Confiança | 🟢 |

Parâmetros implícitos: `TG_TABLE_NAME`, `TG_OP`, `NEW`/`OLD`.

---

## RPC — `increment_play_count` (lacuna em produção)

| Atributo | Valor |
|----------|-------|
| Parâmetro | `p_lyric_id text` |
| Retorno | `void` |
| Linguagem | `plpgsql` SECURITY DEFINER |
| Lógica | UPSERT em `lyric_play_stats`: incrementa `play_count`, atualiza timestamps |
| Grant | `EXECUTE TO authenticated` |
| **Produção (backup)** | 🔴 **NÃO EXISTE** |
| **Repositório** | 🟢 `supabase/migrations/20251226191350_initial_schema.sql` |

Proposta alinhada (já em `_reversa_sdd/supabase-extracted/increment_play_count-proposed.sql`):

```sql
INSERT INTO lyric_play_stats (lyric_id, play_count, last_played_at, updated_at)
VALUES (p_lyric_id, 1, now(), now())
ON CONFLICT (lyric_id) DO UPDATE SET
  play_count = lyric_play_stats.play_count + 1,
  last_played_at = now(),
  updated_at = now();
```

**Comportamento atual do app:** `PlayStatsService` chama RPC; em falha executa `_incrementPlayCountFallback` (select + update/insert direto na tabela).

---

## Funções Supabase (fora do domínio app)

Não documentadas em detalhe: centenas de funções em `auth.*`, `storage.*`, `realtime.*`, `extensions.*` (pg_graphql, pg_cron, etc.) — infraestrutura Supabase.

## Views / materialized views

🟢 **CONFIRMADO** — Nenhuma view `public` no backup.

## Stored procedures legadas

Nenhuma procedure além das funções PL/pgSQL listadas acima no schema `public`.
