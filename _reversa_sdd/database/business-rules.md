# Regras de Negócio no Banco — FMA_Pontos

> Data Master · 2026-05-31 · Backup + migrations do repositório

## RBAC (`has_role` / policies)

🟢 Hierarquia espelhada em SQL e Dart:

| Papel requerido | Papéis aceitos |
|-----------------|----------------|
| `user` | user, moderator, admin |
| `moderator` | moderator, admin |
| `admin` | admin |

### Matriz RLS — `categories`

| Operação | Quem (policy) | Condição |
|----------|---------------|----------|
| SELECT | Todos | `Read Categories` — `true` |
| INSERT | authenticated não-anônimo | `has_role('moderator')` |
| UPDATE | authenticated não-anônimo | `has_role('moderator')` |
| DELETE | authenticated não-anônimo | `has_role('admin')` |
| INSERT | `anon` | `allow anon insert` — `true` 🟡 legado/permissivo |

### Matriz RLS — `lyrics`

| Operação | Quem | Condição |
|----------|------|----------|
| SELECT | Todos | `Read Lyrics` |
| INSERT | authenticated não-anônimo | `has_role('user')` |
| UPDATE | authenticated não-anônimo | `has_role('moderator')` |
| DELETE | authenticated não-anônimo | `has_role('admin')` |
| INSERT | `anon` | `allow anon insert` 🟡 |

### Matriz RLS — `user_roles`

| Operação | Policy | Regra |
|----------|--------|-------|
| SELECT próprio | `Users can read own role` / `select_own_role` | `id = auth.uid()` |
| SELECT todos (auth) | `Authenticated can read all user roles` | `true` — admin UI |
| UPDATE | `Admins can update user roles` | `is_admin(auth.uid())` |
| INSERT próprio | `Users can insert own role` / `insert_own_role` | `id = auth.uid()` |

🟢 **CONFIRMADO** — `is_active` existe no backup; app bloqueia login se `false` (`AuthService._fetchUserRole`).

### Matriz RLS — `lyric_play_stats`

| Operação | Regra |
|----------|-------|
| SELECT | Público (`true`) |
| INSERT/UPDATE | `authenticated` com `true` 🟡 permissivo — qualquer autenticado pode incrementar |

🟡 Risco: incremento via fallback client sem RPC atômica.

---

## Constraints de domínio

| Regra | Implementação | Confiança |
|-------|---------------|-----------|
| Código de categoria único | `UNIQUE (code)` | 🟢 |
| Áudio remoto só MP3 | `CHECK (audio_url IS NULL OR audio_url ILIKE '%.mp3')` | 🟢 |
| Role válida | `CHECK (role IN ('user','moderator','admin'))` | 🟢 |
| Ação de auditoria | `CHECK (action IN ('INSERT','UPDATE','DELETE'))` | 🟢 |
| Ordem de letras por categoria | `sequence_number` + função `get_next_lyric_sequence` | 🟢 |

---

## Triggers

| Trigger | Tabela | Evento | Função | Efeito |
|---------|--------|--------|--------|--------|
| `on_auth_user_created` | `auth.users` | AFTER INSERT | `handle_new_user()` | Cria `user_roles` com role `user` |
| `audit_categories` | `categories` | AFTER I/U/D | `audit_trigger_func()` | Grava `audit_logs` |
| `audit_lyrics` | `lyrics` | AFTER I/U/D | `audit_trigger_func()` | Grava `audit_logs` |

🟢 `audit_trigger_func` — SECURITY DEFINER; captura `old_data`/`new_data` JSON, `auth.uid()` e email.

---

## Storage

| Regra | Policy |
|-------|--------|
| Leitura pública de MP3 | `Public Select Audio` — `bucket_id = 'audio'` |
| Upload | authenticated + nome `%.mp3` + `has_role('user')` |
| Atualizar objeto | `moderator+` |
| Excluir objeto | `admin` |

---

## Realtime

🟢 **CONFIRMADO** — `ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.user_roles;`

App assina mudanças de role em `AuthService` para atualizar UI sem reinício.

---

## Lacunas prod vs repositório

| Item | Produção (backup 2026-01-21) | Repositório |
|------|------------------------------|-------------|
| `increment_play_count` | 🔴 Ausente | 🟢 Em `initial_schema.sql` |
| `lyric_play_stats` dados | Vazio | — |
| `is_deleted` remoto | Ausente | Só SQLite |
| Policies `anon insert` | Presentes | 🟡 Revisar hardening |

## Recomendações (🟡 inferido)

1. Aplicar migration com `increment_play_count` em produção ou documentar fallback como oficial.
2. Avaliar remover `allow anon insert` se não for mais necessário.
3. Restringir INSERT/UPDATE em `lyric_play_stats` à RPC quando existir.
4. Consolidar `youtube_url` → `youtube_link` em migration futura.
