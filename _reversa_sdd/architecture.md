# Arquitetura — FMA_Pontos

Gerado pelo Reversa Architect em 2026-05-19T02:08:00Z.

> **Contrato normativo (implementação e PRs):** [`architecture-contract.md`](architecture-contract.md) — regras de persistência, leitura/escrita, sync e exceções (Storage, admin, stats).

## Visão Geral

- 🟢 **CONFIRMADO** — O FMA_Pontos é um aplicativo Flutter mobile Android/iOS para organizar, consultar e reproduzir pontos/letras.
- 🟢 **CONFIRMADO** — O app é offline-first: SQLite local é a fonte operacional imediata e Supabase é o backend remoto de sincronização, autenticação, storage e estatísticas.
- 🟢 **CONFIRMADO** — O estado do app é coordenado por `Provider`/`ChangeNotifier`.
- 🟢 **CONFIRMADO** — O release Android é feito por GitHub Actions em tags `v*`.
- 🟡 **INFERIDO** — A arquitetura privilegia simplicidade de um cliente mobile rico, sem backend custom além do Supabase.

## Containers

| Container | Tecnologia | Responsabilidade | Confiança |
|---|---|---|---|
| App Flutter | Flutter/Dart, Provider, Material 3 | UI, navegação, regras client-side, sync orchestration, player | 🟢 CONFIRMADO |
| SQLite local | sqflite | Persistência offline de categorias/letras e flags de sync | 🟢 CONFIRMADO |
| Supabase Auth | Supabase | Sessões anônimas, login Google, usuários | 🟢 CONFIRMADO |
| Supabase Postgres | Supabase/Postgres/RLS | Dados remotos, roles, stats, policies | 🟢 CONFIRMADO |
| Supabase Storage | Supabase Storage | Arquivos MP3 públicos no bucket `audio` | 🟢 CONFIRMADO |
| GitHub Releases | GitHub REST API + Releases | Distribuição APK e checagem de update | 🟢 CONFIRMADO |
| GitHub Actions | workflow YAML | Build e publicação de APK release | 🟢 CONFIRMADO |
| YouTube | youtube_player_flutter | Reprodução de vídeos externos associados às letras | 🟢 CONFIRMADO |
| Google OAuth | google_sign_in + Supabase Auth | Login Google | 🟢 CONFIRMADO |

## Componentes Internos do App

| Componente | Arquivos | Responsabilidade |
|---|---|---|
| Bootstrap/App Shell | `lib/main.dart`, `SplashScreen` | Inicialização de Supabase, áudio, providers, tema e roteamento inicial |
| Screens | `lib/screens/*.dart` | Fluxos de usuário e navegação |
| Sync | `SyncRepository`, `DatabaseHelper`, `SupabaseService` | Persistência local/remota, push/pull, download de áudio |
| Auth/RBAC | `AuthService`, `AdminService`, `UserInfo` | Sessão, roles, admin, logs |
| Media | `AudioPlayerService`, `CategoryPlayerWidget`, `LyricViewScreen` | Áudio local/remoto, playlist, YouTube |
| Domain Models | `Category`, `Lyric`, `AuditLog`, `UserInfo` | Serialização e dados de domínio |
| Preferences | `FavoritesService`, `ThemeProvider`, onboarding prefs | Estado local persistido |
| Update | `UpdateService`, GitHub workflow | Checagem e distribuição de releases |

## Principais Fluxos Arquiteturais

### Inicialização

1. App lê `SUPABASE_URL` e `SUPABASE_ANON_KEY`.
2. Inicializa Supabase e AudioService.
3. Injeta providers.
4. Splash solicita permissões, garante autenticação e decide onboarding/home.

### Consulta offline

1. UI chama `SyncRepository`.
2. `SyncRepository` consulta `DatabaseHelper`.
3. SQLite retorna categorias/letras filtrando `is_deleted = 0`.

### Sync online

1. `SyncRepository.syncData()` detecta online e evita concorrência.
2. Envia `is_synced = 0`.
3. Aplica soft/hard delete conforme `is_deleted`.
4. Busca dados remotos por `last_sync_timestamp`.
5. Baixa áudios sem `localAudioPath`.

### Mídia

1. Letra pode ter `audioUrl`, `localAudioPath` e/ou `youtubeLink`.
2. Áudio prioriza arquivo local.
3. Vídeo YouTube é validado por ID.
4. Tela de detalhe alterna entre `audio`, `video` e `none`.

## Integrações

| Integração | Protocolo/API | Direção | Dados | Confiança |
|---|---|---|---|---|
| Supabase PostgREST | HTTPS via `supabase_flutter` | App ↔ Supabase | categorias, letras, roles, stats, logs | 🟢 CONFIRMADO |
| Supabase Auth | SDK Supabase | App ↔ Supabase | sessão anônima, Google token, usuário | 🟢 CONFIRMADO |
| Supabase Realtime | WebSocket/channel | Supabase → App | mudanças em `user_roles` | 🟢 CONFIRMADO |
| Supabase Storage | HTTPS/storage SDK | App ↔ Supabase | upload/delete/download URL de MP3 | 🟢 CONFIRMADO |
| Google Sign-In | OAuth/OIDC via plugin | App ↔ Google/Supabase | idToken/accessToken | 🟢 CONFIRMADO |
| YouTube | Player/plugin | App → YouTube | video ID/link | 🟢 CONFIRMADO |
| GitHub Releases API | HTTPS REST | App → GitHub | latest release, APK URL | 🟢 CONFIRMADO |
| GitHub Actions | CI workflow | GitHub → Release | APK build | 🟢 CONFIRMADO |

## Dívidas Técnicas e Riscos

- 🟢 **CONFIRMADO** (2026-05-19) — `audit_logs` + triggers versionados em `supabase/migrations/20260519000000_fix_reversa_gaps.sql` (ver contrato §4).
- 🟢 **CONFIRMADO** (2026-05-19) — RPC `increment_play_count` proposta na mesma migration; fallback client permanece válido.
- 🟢 **CONFIRMADO** (2026-05-19) — Conflito offline/remota: merge por campo (`SyncMerge`, regras **S-04** no contrato).
- 🟢 **CONFIRMADO** (2026-05-19) — `is_active=false` bloqueia login (`AuthService`, regra **W-05**).
- 🟡 **INFERIDO** — Apenas um teste unitário cobre modelo `Lyric`; serviços críticos e telas não têm cobertura proporcional.
- 🟡 **INFERIDO** — Parte dos erros de sync é apenas logada, sem feedback ao usuário.
- 🟡 **INFERIDO** — Colisão de nomes de áudio no download (basename da URL).

## Artefatos

- **Contrato arquitetural:** [`architecture-contract.md`](architecture-contract.md)
- C4 Contexto: `_reversa_sdd/c4-context.md`
- C4 Containers: `_reversa_sdd/c4-containers.md`
- C4 Componentes: `_reversa_sdd/c4-components.md`
- ERD completo: `_reversa_sdd/erd-complete.md`
- Matriz de impacto: `_reversa_sdd/traceability/spec-impact-matrix.md`

