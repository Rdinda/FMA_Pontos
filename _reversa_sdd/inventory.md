# Inventário do Projeto — FMA_Pontos

Gerado pelo Reversa Scout em 2026-05-18T22:49:45-03:00.

## Resumo Executivo

- 🟢 **CONFIRMADO** — O projeto é um aplicativo Flutter/Dart chamado `pontos`, descrito como app para gerenciar pontos de Umbanda.
- 🟢 **CONFIRMADO** — O app tem targets Android e iOS, inicialização em `lib/main.dart` e publicação de APK via GitHub Actions.
- 🟢 **CONFIRMADO** — O backend remoto é Supabase, com autenticação, storage, migrations SQL e schema em `supabase/`.
- 🟢 **CONFIRMADO** — O app mantém dados locais com SQLite via `sqflite`, sincronizando com Supabase por `SyncRepository`.
- 🟡 **INFERIDO** — A organização principal do código é por camada técnica em `lib/`, não por domínio puro.

## Estrutura de Pastas

Árvore analisada excluindo `.git`, `.reversa`, `_reversa_sdd`, `node_modules`, `dist`, `build`, `coverage`, `__pycache__` e `.cache`.

```text
.
├── .github/
│   └── workflows/
│       └── release-app.yml
├── android/
│   ├── app/
│   │   ├── build.gradle.kts
│   │   ├── proguard-rules.pro
│   │   └── src/
│   │       ├── debug/AndroidManifest.xml
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── kotlin/com/fmapontos/app/MainActivity.kt
│   │       │   └── res/
│   │       └── profile/AndroidManifest.xml
│   ├── build.gradle.kts
│   ├── gradle.properties
│   ├── key.properties.example
│   ├── keystore/README.md
│   └── settings.gradle.kts
├── assets/
│   └── images/
│       ├── maria.png
│       └── splash.png
├── base/
│   └── seed_letras.json
├── docs/
│   └── supabase-migracoes.md
├── ios/
│   ├── Flutter/
│   ├── Runner/
│   ├── Runner.xcodeproj/
│   ├── Runner.xcworkspace/
│   └── RunnerTests/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── audit_log.dart
│   │   ├── category.dart
│   │   ├── lyric.dart
│   │   └── user_info.dart
│   ├── providers/
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── admin_screen.dart
│   │   ├── category_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── home_screen.dart
│   │   ├── lyric_form_screen.dart
│   │   ├── lyric_view_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── onboarding_widgets.dart
│   │   ├── privacy_policy_screen.dart
│   │   ├── search_screen.dart
│   │   ├── splash_screen.dart
│   │   └── top_played_screen.dart
│   ├── services/
│   │   ├── admin_service.dart
│   │   ├── audio_player_service.dart
│   │   ├── auth_service.dart
│   │   ├── db_helper.dart
│   │   ├── favorites_service.dart
│   │   ├── play_stats_service.dart
│   │   ├── supabase_service.dart
│   │   ├── sync_repository.dart
│   │   └── update_service.dart
│   ├── utils/
│   │   ├── snackbar_utils.dart
│   │   └── string_extensions.dart
│   └── widgets/
│       ├── app_info_bottom_sheet.dart
│       ├── category_player_widget.dart
│       └── skeleton_widget.dart
├── supabase/
│   ├── config.toml
│   ├── migrations/
│   │   ├── 20251226191350_placeholder.sql
│   │   ├── 20251226192339_remote_schema.sql
│   │   ├── 20260110000000_add_youtube_url.sql
│   │   ├── 20260110120000_add_youtube_link.sql
│   │   ├── 20260114000000_revert_seed_data.sql
│   │   └── 20260114120000_add_prefix_and_sequence.sql
│   ├── seed.sql
│   └── supabase_schema.sql
├── test/
│   └── unit/
│       └── lyric_test.dart
├── .env.example
├── analysis_options.yaml
├── devtools_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── run-dev.ps1
├── SECURITY.md
└── up-version.ps1
```

## Linguagens e Arquivos

Contagem principal do legado, desconsiderando pastas de agentes e do próprio Reversa:

| Extensão | Contagem | Observação |
|---|---:|---|
| `.dart` | 33 | Código Flutter principal e testes |
| `.png` | 31 | Assets e ícones Android/iOS |
| `.sql` | 8 | Schema, seed e migrations Supabase |
| `.md` | 8 | Documentação do projeto |
| `.xml` | 7 | Manifests e recursos Android |
| `.plist` | 4 | Configuração iOS |
| `.json` | 3 | Seeds/assets/configurações |
| `.kts` | 3 | Gradle Kotlin DSL |
| `.yaml` | 3 | Flutter, análise e workflow |
| `.ps1` | 2 | Scripts locais de automação |
| `.swift` | 2 | Código/testes iOS |
| `.kt` | 1 | MainActivity Android |

Linguagem principal: **Dart**.

## Tecnologias e Frameworks

- 🟢 **CONFIRMADO** — Flutter SDK com Material 3, localização pt-BR e entry point em `lib/main.dart`.
- 🟢 **CONFIRMADO** — Estado e injeção de dependências com `provider`.
- 🟢 **CONFIRMADO** — Supabase via `supabase_flutter`, usado em `main.dart`, `auth_service.dart`, `supabase_service.dart`, `admin_service.dart` e `play_stats_service.dart`.
- 🟢 **CONFIRMADO** — SQLite local via `sqflite` em `lib/services/db_helper.dart`.
- 🟢 **CONFIRMADO** — Áudio com `audioplayers` e `audio_service`, incluindo handler dedicado em `lib/services/audio_player_service.dart`.
- 🟢 **CONFIRMADO** — Login Google com `google_sign_in` em `lib/services/auth_service.dart`.
- 🟢 **CONFIRMADO** — Player de YouTube com `youtube_player_flutter` em telas de letra/formulário.
- 🟢 **CONFIRMADO** — CI/CD por GitHub Actions em `.github/workflows/release-app.yml`.

## Pontos de Entrada

| Caminho | Tipo | Evidência |
|---|---|---|
| `lib/main.dart` | app entry | Chama `WidgetsFlutterBinding.ensureInitialized()`, inicializa Supabase e executa `runApp(MyApp(...))`. |
| `android/app/src/main/kotlin/com/fmapontos/app/MainActivity.kt` | Android host | Entry nativo Android do app Flutter. |
| `ios/Runner/AppDelegate.swift` | iOS host | Entry nativo iOS do app Flutter. |
| `run-dev.ps1` | script local | Script PowerShell para execução/desenvolvimento. |
| `up-version.ps1` | script local | Script PowerShell para versionamento. |

## Configurações

- `.env.example` — exemplo de variáveis esperadas.
- `analysis_options.yaml` — regras de análise/lint Dart.
- `devtools_options.yaml` — opções de DevTools.
- `pubspec.yaml` — manifesto Flutter, dependências, assets e versão.
- `pubspec.lock` — lockfile de dependências Dart.
- `supabase/config.toml` — configuração local do Supabase.
- `android/*.gradle.kts`, `android/gradle.properties`, `android/key.properties.example` — build Android.
- `ios/Runner/Info.plist`, `ios/Flutter/*.xcconfig` — configuração iOS.

## CI/CD

- 🟢 **CONFIRMADO** — `.github/workflows/release-app.yml` executa em tags `v*`, instala Java 17 e Flutter `3.38.5`, roda `flutter pub get`, monta keystore via secrets, compila APK release com `SUPABASE_URL` e `SUPABASE_ANON_KEY` via `--dart-define`, renomeia o APK e publica release GitHub.

## Banco de Dados e Persistência

- 🟢 **CONFIRMADO** — `supabase/supabase_schema.sql` contém schema remoto, policies e storage.
- 🟢 **CONFIRMADO** — `supabase/migrations/` contém migrations SQL datadas.
- 🟢 **CONFIRMADO** — `supabase/seed.sql` e `base/seed_letras.json` indicam carga inicial de dados.
- 🟢 **CONFIRMADO** — `lib/services/db_helper.dart` usa SQLite local.
- 🟢 **CONFIRMADO** — `lib/services/sync_repository.dart` coordena sincronização entre banco local, Supabase e arquivos de áudio.

Arquivos de banco detectados:

- `supabase/supabase_schema.sql`
- `supabase/seed.sql`
- `supabase/migrations/20251226191350_placeholder.sql`
- `supabase/migrations/20251226192339_remote_schema.sql`
- `supabase/migrations/20260110000000_add_youtube_url.sql`
- `supabase/migrations/20260110120000_add_youtube_link.sql`
- `supabase/migrations/20260114000000_revert_seed_data.sql`
- `supabase/migrations/20260114120000_add_prefix_and_sequence.sql`
- `base/seed_letras.json`

## Cobertura de Testes

- 🟢 **CONFIRMADO** — Framework de teste: `flutter_test`.
- 🟢 **CONFIRMADO** — Arquivos de teste detectados: 1.
- 🟢 **CONFIRMADO** — `test/unit/lyric_test.dart` cobre serialização do modelo `Lyric`, incluindo `youtube_link`.
- 🟡 **INFERIDO** — A cobertura automatizada atual parece pequena frente ao tamanho do app, pois há apenas um arquivo de teste unitário detectado.

## Módulos Técnicos Identificados

- `app-bootstrap` — inicialização Flutter, tema, localização e providers em `lib/main.dart`.
- `screens` — telas de navegação e fluxos de usuário em `lib/screens/`.
- `services` — autenticação, sincronização, banco local, Supabase, áudio, favoritos, estatísticas e atualização em `lib/services/`.
- `models` — entidades locais e mapeamentos para Supabase/SQLite em `lib/models/`.
- `widgets` — componentes reutilizáveis em `lib/widgets/`.
- `providers` — estado global de tema em `lib/providers/`.
- `utils` — helpers de snackbar e strings em `lib/utils/`.
- `supabase-data` — schema, seed e migrations em `supabase/`.
- `platform-android` — host/configuração Android em `android/`.
- `platform-ios` — host/configuração iOS em `ios/`.
- `release-pipeline` — workflow de release em `.github/workflows/release-app.yml`.

## Features Observáveis

- Acervo de letras/pontos por categorias.
- Busca de letras.
- Favoritos.
- Visualização e edição de letras.
- Reprodução de áudio local/remoto.
- Reprodução de vídeo YouTube.
- Sincronização offline/online.
- Autenticação com Supabase e Google.
- Área administrativa.
- Estatísticas de mais tocados.
- Onboarding e política de privacidade.

## Sugestão de Organização das Specs

- 🟡 **INFERIDO** — Sugestão do Scout: `feature`.
- Racional: o código está organizado por camadas Flutter (`screens`, `services`, `models`) e não há roteamento centralizado ou pastas de domínio dominantes; por isso, organizar por features observáveis tende a gerar specs mais úteis.

