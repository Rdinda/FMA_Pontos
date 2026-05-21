# C4 Containers — FMA_Pontos

```mermaid
flowchart LR
  subgraph Device["Dispositivo Android/iOS"]
    App["App Flutter\nDart + Provider + Material"]
    DB["SQLite local\nsqflite"]
    Files["Arquivos locais de áudio\napp documents/audios"]
    Prefs["SharedPreferences\nfavoritos, tema, onboarding, last_sync"]
  end

  subgraph Supabase["Supabase"]
    Auth["Auth"]
    Pg["Postgres + RLS"]
    Storage["Storage bucket audio"]
    Realtime["Realtime user_roles"]
  end

  subgraph GitHub["GitHub"]
    Actions["Actions release-app.yml"]
    Releases["Releases + APK assets"]
  end

  Google["Google OAuth"]
  YouTube["YouTube"]

  App -->|"CRUD local"| DB
  App -->|"download/play local"| Files
  App -->|"prefs"| Prefs
  App -->|"auth/session"| Auth
  App -->|"select/upsert/delete/rpc"| Pg
  App -->|"upload/delete/public URL"| Storage
  App -->|"role updates"| Realtime
  App -->|"sign-in token"| Google
  App -->|"video playback"| YouTube
  App -->|"check update"| Releases
  Actions -->|"build/publish APK"| Releases
```

## Observações

- 🟢 **CONFIRMADO** — Não há backend próprio além do Supabase.
- 🟢 **CONFIRMADO** — SQLite e SharedPreferences vivem no dispositivo.
- 🟢 **CONFIRMADO** — Build release consome secrets Supabase via `--dart-define`.

