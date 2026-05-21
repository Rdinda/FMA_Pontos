# ERD Completo — FMA_Pontos

```mermaid
erDiagram
  CATEGORIES {
    text id PK
    text name
    text code UK
    timestamptz updated_at
    boolean is_deleted
  }

  LYRICS {
    text id PK
    text category_id FK
    text title
    text content
    timestamptz updated_at
    boolean is_deleted
    text audio_url
    text youtube_link
    int sequence_number
  }

  USER_ROLES {
    uuid id PK
    text email
    text role
    boolean is_active
    text avatar_url
    timestamptz created_at
    timestamptz updated_at
  }

  LYRIC_PLAY_STATS {
    text lyric_id PK,FK
    int play_count
    timestamptz last_played_at
    timestamptz updated_at
  }

  AUDIT_LOGS {
    text id PK
    text table_name
    text record_id
    text action
    jsonb old_data
    jsonb new_data
    uuid user_id
    text user_email
    timestamptz created_at
  }

  STORAGE_OBJECTS {
    uuid id PK
    text bucket_id
    text name
  }

  AUTH_USERS {
    uuid id PK
    text email
  }

  CATEGORIES ||--o{ LYRICS : "category_id"
  LYRICS ||--o| LYRIC_PLAY_STATS : "lyric_id"
  AUTH_USERS ||--|| USER_ROLES : "id"
  AUTH_USERS ||--o{ AUDIT_LOGS : "user_id"
  STORAGE_OBJECTS }o--|| LYRICS : "audio_url references public URL"
```

## Notas de Confiança

- 🟢 **CONFIRMADO** — `categories`, `lyrics`, `user_roles`, `lyric_play_stats` aparecem em `supabase/supabase_schema.sql`.
- 🟢 **CONFIRMADO** — `lyrics.category_id` referencia `categories.id`.
- 🟢 **CONFIRMADO** — `lyric_play_stats.lyric_id` referencia `lyrics.id`.
- 🟢 **CONFIRMADO** — `user_roles.id` referencia `auth.users.id`.
- 🟡 **INFERIDO** — `audit_logs` é modelado pelo app e aparece em migration remota com revokes, mas o `CREATE TABLE`/triggers não estão claros nos arquivos atuais.
- 🟡 **INFERIDO** — Relação entre `lyrics.audio_url` e `storage.objects` é por URL/path, não FK relacional.
- 🟡 **INFERIDO** — `is_deleted` existe no modelo e serviços; no schema principal atual, algumas colunas podem depender de schema remoto/migrations não totalmente refletidas no arquivo principal.

