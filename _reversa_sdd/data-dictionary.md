# Dicionário de Dados — FMA_Pontos

Gerado pelo Reversa Archaeologist em 2026-05-19T01:56:25Z.

## Entidades Dart

### Category

Fonte: `lib/models/category.dart`

| Campo | Tipo | Obrigatório | Origem/uso | Confiança |
|---|---|---:|---|---|
| `id` | `String` | Sim | PK local/remota | 🟢 CONFIRMADO |
| `name` | `String` | Sim | Nome da categoria | 🟢 CONFIRMADO |
| `code` | `String` | Sim | Prefixo usado em códigos visuais, ex. `OX01` | 🟢 CONFIRMADO |
| `updatedAt` | `DateTime` | Sim | Controle incremental de sync | 🟢 CONFIRMADO |
| `isSynced` | `bool` | Não, padrão `false` | Flag local SQLite | 🟢 CONFIRMADO |
| `isDeleted` | `bool` | Não, padrão `false` | Soft delete local/remoto | 🟢 CONFIRMADO |

Mapeamentos:

- SQLite: `id`, `name`, `code`, `updated_at`, `is_synced`, `is_deleted`
- Supabase: `id`, `name`, `code`, `updated_at`

### Lyric

Fonte: `lib/models/lyric.dart`

| Campo | Tipo | Obrigatório | Origem/uso | Confiança |
|---|---|---:|---|---|
| `id` | `String` | Sim | PK local/remota | 🟢 CONFIRMADO |
| `categoryId` | `String` | Sim | FK para categoria | 🟢 CONFIRMADO |
| `title` | `String` | Sim | Título da letra/ponto | 🟢 CONFIRMADO |
| `content` | `String` | Sim | Texto da letra | 🟢 CONFIRMADO |
| `updatedAt` | `DateTime` | Sim | Controle incremental de sync | 🟢 CONFIRMADO |
| `isSynced` | `bool` | Não, padrão `false` | Flag local SQLite | 🟢 CONFIRMADO |
| `isDeleted` | `bool` | Não, padrão `false` | Soft delete local/remoto | 🟢 CONFIRMADO |
| `audioUrl` | `String?` | Não | URL pública Supabase Storage | 🟢 CONFIRMADO |
| `localAudioPath` | `String?` | Não | Arquivo baixado no dispositivo | 🟢 CONFIRMADO |
| `youtubeLink` | `String?` | Não | Link de vídeo YouTube | 🟢 CONFIRMADO |
| `sequenceNumber` | `int` | Não, padrão `0` | Ordem/código dentro da categoria | 🟢 CONFIRMADO |

Compatibilidade:

- 🟢 **CONFIRMADO** — `fromMap` aceita `youtube_link` e fallback `youtube_url`.
- 🟢 **CONFIRMADO** — `sequence_number` aceita inteiro ou string parseável.

### UserInfo

Fonte: `lib/models/user_info.dart`

| Campo | Tipo | Obrigatório | Origem/uso | Confiança |
|---|---|---:|---|---|
| `id` | `String` | Sim | ID do usuário Supabase | 🟢 CONFIRMADO |
| `email` | `String` | Sim | Identificação/admin | 🟢 CONFIRMADO |
| `role` | `String` | Sim, padrão `user` | RBAC | 🟢 CONFIRMADO |
| `isActive` | `bool` | Não, padrão `true` | Status administrativo | 🟢 CONFIRMADO |
| `avatarUrl` | `String?` | Não | Foto do usuário | 🟢 CONFIRMADO |
| `createdAt` | `DateTime?` | Não | Auditoria/listagem | 🟢 CONFIRMADO |
| `updatedAt` | `DateTime?` | Não | Auditoria/listagem | 🟢 CONFIRMADO |

Valores de `role` observados:

- `user`
- `moderator`
- `admin`

### AuditLog

Fonte: `lib/models/audit_log.dart`

| Campo | Tipo | Obrigatório | Origem/uso | Confiança |
|---|---|---:|---|---|
| `id` | `String` | Sim | ID do log | 🟢 CONFIRMADO |
| `tableName` | `String` | Sim | Tabela afetada | 🟢 CONFIRMADO |
| `recordId` | `String` | Sim | Registro afetado | 🟢 CONFIRMADO |
| `action` | `String` | Sim | `INSERT`, `UPDATE`, `DELETE` | 🟢 CONFIRMADO |
| `oldData` | `Map<String,dynamic>?` | Não | Estado anterior | 🟢 CONFIRMADO |
| `newData` | `Map<String,dynamic>?` | Não | Estado novo | 🟢 CONFIRMADO |
| `userId` | `String?` | Não | Usuário executor | 🟢 CONFIRMADO |
| `userEmail` | `String?` | Não | Email executor | 🟢 CONFIRMADO |
| `createdAt` | `DateTime` | Sim | Momento do evento | 🟢 CONFIRMADO |

### LyricPlayStats / LyricWithStats / LyricWithCategory

Fontes: `lib/services/play_stats_service.dart`, `lib/screens/favorites_screen.dart`

| Entidade | Campos | Uso | Confiança |
|---|---|---|---|
| `LyricPlayStats` | `lyricId`, `playCount`, `lastPlayedAt` | Estatística remota por letra | 🟢 CONFIRMADO |
| `LyricWithStats` | `lyric`, `playCount`, `categoryName` | Tela de mais tocados | 🟢 CONFIRMADO |
| `LyricWithCategory` | `lyric`, `categoryName`, `categoryCode` | Tela de favoritos | 🟢 CONFIRMADO |

## SQLite Local

Fonte: `lib/services/db_helper.dart`

### categories

| Coluna | Tipo | Constraint/default | Confiança |
|---|---|---|---|
| `id` | `TEXT` | `PRIMARY KEY` | 🟢 CONFIRMADO |
| `name` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `code` | `TEXT` | `NOT NULL` na criação v5 | 🟢 CONFIRMADO |
| `updated_at` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `is_synced` | `INTEGER` | `NOT NULL DEFAULT 0` | 🟢 CONFIRMADO |
| `is_deleted` | `INTEGER` | `NOT NULL DEFAULT 0` | 🟢 CONFIRMADO |

### lyrics

| Coluna | Tipo | Constraint/default | Confiança |
|---|---|---|---|
| `id` | `TEXT` | `PRIMARY KEY` | 🟢 CONFIRMADO |
| `category_id` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `title` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `content` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `updated_at` | `TEXT` | `NOT NULL` | 🟢 CONFIRMADO |
| `is_synced` | `INTEGER` | `NOT NULL DEFAULT 0` | 🟢 CONFIRMADO |
| `is_deleted` | `INTEGER` | `NOT NULL DEFAULT 0` | 🟢 CONFIRMADO |
| `audio_url` | `TEXT` | Nullable | 🟢 CONFIRMADO |
| `local_audio_path` | `TEXT` | Nullable | 🟢 CONFIRMADO |
| `youtube_link` | `TEXT` | Nullable | 🟢 CONFIRMADO |
| `sequence_number` | `INTEGER` | `NOT NULL DEFAULT 0` | 🟢 CONFIRMADO |

Migrations locais:

- v2: adiciona `audio_url`.
- v3: adiciona `local_audio_path`.
- v4: adiciona `youtube_link`.
- v5: adiciona `categories.code`, popula com `SUBSTR(name,1,2)` e adiciona `lyrics.sequence_number`.

## Supabase Remoto

Fonte: `supabase/migrations/20251226191350_initial_schema.sql` (consolidado), `supabase/migrations/*.sql` (incrementais legados), `supabase/seed.sql`

🟢 **CONFIRMADO (re-extração 2026-05-21)** — `initial_schema.sql` consolida tabelas, RLS, triggers, storage e funções; `categories.code` nasce `NOT NULL UNIQUE`.

🟡 **INFERIDO** — Migrations incrementais anteriores ainda presentes na pasta; fresh install deve preferir apenas o schema consolidado ou validar ordem de execução.

🟢 **CONFIRMADO** — `seed.sql` inclui coluna `code` em todos os INSERT de categorias.

### Tabelas detectadas

| Tabela | Finalidade | Confiança |
|---|---|---|
| `public.categories` | Categorias do acervo | 🟢 CONFIRMADO |
| `public.lyrics` | Letras/pontos | 🟢 CONFIRMADO |
| `public.user_roles` | Roles e status de usuários | 🟢 CONFIRMADO |
| `public.lyric_play_stats` | Contadores de reprodução | 🟢 CONFIRMADO |
| `public.audit_logs` | Logs administrativos lidos pelo app | 🟢 CONFIRMADO |

### Storage

- 🟢 **CONFIRMADO** — Bucket `audio` é criado como público.
- 🟢 **CONFIRMADO** — Objetos ficam no prefixo `lyrics/`.
- 🟢 **CONFIRMADO** — Upload exige arquivo `.mp3` e role `user`.
- 🟢 **CONFIRMADO** — Update exige `moderator`; delete exige `admin`.

### Políticas/Permissões

- 🟢 **CONFIRMADO** — RLS habilitado para `categories`, `lyrics`, `user_roles`, `lyric_play_stats`.
- 🟢 **CONFIRMADO** — Leituras de categorias/letras são permitidas a usuários autenticados/anônimos conforme políticas SQL.
- 🟢 **CONFIRMADO** — Mutação de categorias/letras é protegida por função/role SQL `public.has_role(...)`.

## Chaves de Preferência Local

| Chave | Tipo | Local | Confiança |
|---|---|---|---|
| `last_sync_timestamp` | `String ISO 8601` | `SyncRepository` | 🟢 CONFIRMADO |
| `favorite_lyrics` | `List<String>` | `FavoritesService` | 🟢 CONFIRMADO |
| `theme_mode` | `int` | `ThemeProvider` | 🟢 CONFIRMADO |
| `onboarding_completed` | `bool` | `SplashScreen`, `OnboardingScreen` | 🟢 CONFIRMADO |

