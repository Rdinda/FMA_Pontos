# Re-extração Parcial — 2026-05-21

> Disparada pelo usuário (opção 6) após merges e correções pós-análise original.

## Escopo analisado

| Área | Mudança no legado | Specs atualizadas |
|------|-------------------|-------------------|
| Dependências | `google_sign_in` 7.x, `file_picker` 12.x, bumps diversos | `dependencies.md` |
| Autenticação | API v7: `GoogleSignIn.instance`, `initialize()`, `authenticate()` | `autenticacao/requirements.md`, `autenticacao/design.md` |
| Bootstrap / dev | `run-dev.ps1`, `dart_defines.json`, `.vscode/launch.json` | `flowcharts/app-bootstrap.md` |
| Edição de letra | `FilePicker.pickFiles()` (sem `.platform`) | `edicao-letra/requirements.md`, `edicao-letra/tasks.md` |
| Supabase | `initial_schema.sql` consolidado; `seed.sql` com `code` | `data-dictionary.md`, `acervo-categorias/requirements.md` |

## Delta confirmado no código (🟢)

1. **`google_sign_in` 7.2.0** — singleton `GoogleSignIn.instance`; `initialize(serverClientId)` no `_init`; login via `authenticate()`; `authentication` é getter síncrono; `signInWithIdToken` usa só `idToken` (sem `accessToken`).
2. **`file_picker` 12.x** — `FilePicker.pickFiles(type: FileType.audio)` substitui `FilePicker.platform.pickFiles`.
3. **`supabase/seed.sql`** — `INSERT INTO categories` inclui coluna `code` (ex.: Caboclos → `CA`); evita violação `NOT NULL`.
4. **`supabase/migrations/20251226191350_initial_schema.sql`** — schema consolidado com `categories.code NOT NULL UNIQUE`, `audit_logs`, `lyric_play_stats`, RLS e triggers.
5. **`run-dev.ps1`** — gera `dart_defines.json` a partir de `.env` e executa `flutter run --dart-define-from-file=dart_defines.json`.
6. **`AuthService`** — `_ensureUserIsActive()` e bloqueio por `is_active = false` implementados (gap anterior fechado).

## Lacunas remanescentes

- 🟡 Migrations incrementais antigas ainda coexistem com `initial_schema.sql` — ordem de aplicação em DB existente precisa validação humana.
- 🟡 `main.dart` ainda lança exceção se `--dart-define` ausente (não exibe `_MissingConfigApp` — alteração local não commitada ou revertida).
- 🔴 Telas Onboarding, Favoritos, Top, Admin não re-documentadas pelo Visor nesta rodada.

## Agentes re-executados (parcial)

| Agente | Módulos | Ação |
|--------|---------|------|
| Archaeologist | `services`, `supabase-data`, `app-bootstrap` | Delta em specs + flowchart |
| Writer | `autenticacao`, `edicao-letra`, `acervo-categorias` | Atualização de requirements/tasks |
| Scout | `dependencies` | Versões em `dependencies.md` |

## Confiança pós re-extração

Estimativa: **92%** (+2 pp) nas units tocadas; demais units permanecem na baseline de 2026-05-20.
