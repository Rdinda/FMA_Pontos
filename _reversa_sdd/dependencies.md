# Dependências — FMA_Pontos

Gerado pelo Reversa Scout em 2026-05-18T22:49:45-03:00.

## Manifesto

- Package: `pontos`
- Descrição: `Um aplicativo para gerenciar pontos de umbanda`
- Versão: `1.0.19`
- Publicação: `publish_to: none`
- SDK Dart: `^3.10.4`
- Gerenciador de pacotes: `pub`
- Lockfile: `pubspec.lock`

## Dependências de Produção

| Dependência | Versão declarada | Papel provável |
|---|---|---|
| `flutter` | SDK | Framework de UI e runtime do app. |
| `flutter_localizations` | SDK | Localização oficial Flutter. |
| `intl` | `any` | Internacionalização/formatação. |
| `supabase_flutter` | `^2.8.2` | Cliente Supabase e autenticação. |
| `sqflite` | `^2.4.1` | Banco SQLite local. |
| `path` | `^1.9.0` | Manipulação de caminhos. |
| `provider` | `^6.1.2` | Estado/injeção de dependências. |
| `connectivity_plus` | `^6.1.0` | Detecção de conectividade para sync. |
| `uuid` | `^4.5.1` | Geração de identificadores. |
| `google_fonts` | `^6.2.1` | Tipografia do app. |
| `audioplayers` | `^6.0.0` | Reprodução de áudio. |
| `file_picker` | `^8.1.4` | Seleção de arquivos de áudio. |
| `mime` | `^1.0.6` | Detecção de tipo MIME. |
| `permission_handler` | `^11.3.0` | Permissões nativas. |
| `path_provider` | `^2.1.2` | Diretórios locais do dispositivo. |
| `http` | `^1.2.0` | Requisições HTTP. |
| `package_info_plus` | `^9.0.0` | Metadados do app instalado. |
| `url_launcher` | `^6.3.2` | Abertura de URLs externas. |
| `logger` | `^2.6.2` | Logging estruturado. |
| `audio_service` | `^0.18.18` | Serviço/background audio e notificações. |
| `google_sign_in` | `6.2.1` | Login Google. |
| `shared_preferences` | `^2.5.4` | Preferências locais. |
| `youtube_player_flutter` | `^9.1.3` | Player de vídeos YouTube. |

## Dependências de Desenvolvimento

| Dependência | Versão declarada | Papel provável |
|---|---|---|
| `flutter_test` | SDK | Testes Flutter/Dart. |
| `flutter_lints` | `^6.0.0` | Regras de lint. |
| `flutter_launcher_icons` | `^0.13.1` | Geração de ícones Android/iOS. |

## Dependências Críticas por Área

### Aplicação Flutter

- 🟢 **CONFIRMADO** — `flutter`, `provider`, `google_fonts`, `flutter_localizations`.
- 🟢 **CONFIRMADO** — `MaterialApp` em `lib/main.dart` define tema claro/escuro, localidade `pt_BR` e `SplashScreen` como tela inicial.

### Dados e Sincronização

- 🟢 **CONFIRMADO** — `supabase_flutter` é inicializado em `lib/main.dart` com `SUPABASE_URL` e `SUPABASE_ANON_KEY` via `--dart-define`.
- 🟢 **CONFIRMADO** — `sqflite` é usado em `lib/services/db_helper.dart`.
- 🟢 **CONFIRMADO** — `connectivity_plus`, `http`, `path_provider` e `path` apoiam sincronização e arquivos locais.

### Autenticação

- 🟢 **CONFIRMADO** — `google_sign_in` e Supabase Auth aparecem em `lib/services/auth_service.dart`.

### Mídia

- 🟢 **CONFIRMADO** — `audio_service` e `audioplayers` aparecem em `lib/services/audio_player_service.dart`.
- 🟢 **CONFIRMADO** — `youtube_player_flutter` aparece em `lib/screens/lyric_view_screen.dart` e `lib/screens/lyric_form_screen.dart`.
- 🟢 **CONFIRMADO** — `file_picker`, `mime`, `permission_handler` e Supabase Storage apoiam upload/seleção de áudio.

### Release

- 🟢 **CONFIRMADO** — GitHub Actions usa Java `17`, Flutter `3.38.5`, Gradle cache, Pub cache, secrets de assinatura e secrets Supabase.

## Gerenciadores e Build

- Flutter/Dart: `pubspec.yaml` e `pubspec.lock`.
- Android: Gradle Kotlin DSL (`android/build.gradle.kts`, `android/app/build.gradle.kts`).
- iOS: Xcode project/workspace em `ios/Runner.xcodeproj` e `ios/Runner.xcworkspace`.
- Supabase: configuração local em `supabase/config.toml`.

## Observações de Risco Inicial

- 🟡 **INFERIDO** — `intl: any` reduz previsibilidade de resolução de dependências.
- 🟡 **INFERIDO** — O app depende de `--dart-define` para Supabase; builds sem secrets/configuração falham por exceção em `main.dart`.
- 🟡 **INFERIDO** — Há apenas um teste automatizado detectado, então mudanças em serviços, telas e sincronização podem exigir testes adicionais.

