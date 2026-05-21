# C4 Componentes — App Flutter

```mermaid
flowchart TD
  Main["main.dart\nBootstrap"] --> Providers["Provider tree"]
  Providers --> Theme["ThemeProvider"]
  Providers --> Auth["AuthService"]
  Providers --> Sync["SyncRepository"]
  Providers --> Fav["FavoritesService"]
  Providers --> Audio["AudioPlayerService"]

  Screens["Screens\nHome/Category/Lyric/Search/Admin"] --> Sync
  Screens --> Auth
  Screens --> Fav
  Screens --> Audio
  Screens --> Update["UpdateService"]
  Screens --> Snack["SnackbarUtils"]

  Sync --> DBH["DatabaseHelper\nSQLite DAO"]
  Sync --> Supa["SupabaseService\nPostgREST/Storage"]
  Sync --> Prefs["SharedPreferences\nlast_sync"]
  Sync --> Http["HTTP audio download"]

  Auth --> SupabaseAuth["Supabase Auth"]
  Auth --> Google["GoogleSignIn"]
  Auth --> Roles["user_roles Realtime"]

  Audio --> Handler["MyAudioHandler\nAudioService"]
  Handler --> Player["AudioPlayer"]
  Audio --> Stats["PlayStatsService"]
  Stats --> SupabaseStats["lyric_play_stats / RPC"]

  Models["Models\nCategory/Lyric/UserInfo/AuditLog"] --> DBH
  Models --> Supa
```

## Componentes críticos

- `SyncRepository`: maior concentração de regras offline/online.
- `AuthService`: fonte de permissões da UI e assinaturas realtime.
- `AudioPlayerService`: mídia, playlist, notification audio e estatísticas.
- `DatabaseHelper`: schema local e migrações SQLite.
- `SupabaseService`: contrato remoto para dados e storage.

