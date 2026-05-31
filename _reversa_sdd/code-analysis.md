# Análise Técnica Consolidada — FMA_Pontos

Gerado pelo Reversa Archaeologist em 2026-05-19T01:56:25Z.

## Visão Geral

- 🟢 **CONFIRMADO** — O sistema é um app Flutter/Dart para consulta, organização, reprodução e manutenção de pontos/letras.
- 🟢 **CONFIRMADO** — A arquitetura local usa `Provider`/`ChangeNotifier`, SQLite (`sqflite`) para operação offline e Supabase para dados remotos, autenticação, storage e estatísticas.
- 🟢 **CONFIRMADO** — A navegação é imperativa via `Navigator.push`/`MaterialPageRoute`; não há roteador centralizado.
- 🟢 **CONFIRMADO** — O fluxo de mídia suporta áudio local/remoto e YouTube, evitando tocar áudio e vídeo simultaneamente na tela de detalhe.
- 🟡 **INFERIDO** — O domínio principal é "acervo de pontos" composto por categorias, letras, mídia, favoritos, estatísticas e administração.

## Módulos Analisados

| Módulo | Arquivos principais | Complexidade | Propósito |
|---|---|---|---|
| `app-bootstrap` | `lib/main.dart` | Média | Inicializa Supabase, áudio, providers, tema e app shell. |
| `screens` | `lib/screens/*.dart` | Alta | Implementa fluxos de navegação, CRUD, mídia, onboarding, busca, favoritos, top tocados e admin. |
| `services` | `lib/services/*.dart` | Alta | Concentra persistência, sincronização, autenticação, áudio, storage, estatísticas e release check. |
| `models` | `lib/models/*.dart` | Média | Define entidades e serialização para SQLite/Supabase. |
| `widgets` | `lib/widgets/*.dart`, `lib/widgets/streaming/*.dart` | Média-Alta | Player, streaming scaffold/nav/cards, bottom sheet de conta. |
| `providers` | `lib/providers/theme_provider.dart` | Baixa | Estado de tema com persistência local. |
| `utils` | `lib/utils/*.dart` | Baixa-Média | Toasts (`toastification`), `category_artwork`, extensão de string. |
| `supabase-data` | `supabase/*.sql`, `supabase/migrations/*.sql` | Alta | Schema remoto, RLS, storage, seeds e migrations. |
| `platform-android` | `android/**` | Média | Configuração/build Android e host Flutter. |
| `platform-ios` | `ios/**` | Média | Configuração/host iOS. |
| `release-pipeline` | `.github/workflows/release-app.yml`, scripts PS1 | Média | Build assinado de APK em tags e publicação de release. |

## Fluxos de Controle Principais

### Bootstrap e Inicialização

🟢 **CONFIRMADO** — `lib/main.dart` exige `SUPABASE_URL` e `SUPABASE_ANON_KEY` via `--dart-define`; se qualquer valor estiver vazio, lança exceção antes de `runApp`.

Fluxo:

1. `WidgetsFlutterBinding.ensureInitialized()`.
2. Lê credenciais Supabase de `String.fromEnvironment`.
3. Inicializa `Supabase`.
4. Cria `AudioPlayerService` via `AudioService.init`.
5. Injeta `ThemeProvider`, `AuthService`, `SyncRepository`, `FavoritesService` e `AudioPlayerService`.
6. Envolve `MaterialApp` com `ToastificationWrapper` (toasts inferiores, margem 110dp).
7. Renderiza `MaterialApp` em pt-BR com `theme`/`darkTheme` de `AppTheme`, `themeMode` do `ThemeProvider` (default dark), `SplashScreen` inicial.

🟢 **CONFIRMADO** — Re-extração 2026-05-31: tema em `app_theme.dart` + `app_colors.dart`; `streaming_tokens.dart` para layout.
🟢 **CONFIRMADO** — Re-extração 2026-05-31 (rodada 2): feedback via `toastification`; Home com grid `CategoryCard` e `AllCategoriesScreen`.

### Splash, Autenticação e Onboarding

🟢 **CONFIRMADO** — `SplashScreen` espera 2 segundos, solicita permissões `storage` e `audio`, garante autenticação via `AuthService.ensureAuthenticated()`, consulta `onboarding_completed` em `SharedPreferences` e redireciona para `HomeScreen` ou `OnboardingScreen`.

🟢 **CONFIRMADO** — `OnboardingScreen` só finaliza se o usuário aceitar a política de privacidade; a decisão fica em `SharedPreferences`.

### Sincronização Offline/Online

🟢 **CONFIRMADO** — `SyncRepository.syncData()` aplica estratégia em três etapas:

1. **Push local:** busca categorias/letras `is_synced = 0`; se `is_deleted`, envia soft delete ao Supabase e remove localmente; caso contrário, faz upsert remoto e marca sincronizado.
2. **Pull incremental:** lê `last_sync_timestamp` e busca categorias/letras remotas alteradas após esse timestamp.
3. **Download de áudio:** baixa arquivos remotos ainda sem `localAudioPath`.

Regras relevantes:

- 🟢 **CONFIRMADO** — Exclusões locais são soft deletes até sincronizar.
- 🟢 **CONFIRMADO** — Ao puxar letras da nuvem, o app preserva `localAudioPath` quando o `audioUrl` remoto não mudou.
- 🟢 **CONFIRMADO** — Se o áudio remoto foi removido ou trocado, o arquivo local antigo é apagado e o path deixa de ser preservado.
- 🟢 **CONFIRMADO** — Downloads de áudio são sequenciais e atualizam progresso por `downloadProgress`/`downloadStatus`.
- 🟡 **INFERIDO** — A consulta `readAllLyrics()` para achar uma letra existente durante o pull pode ficar custosa com acervos grandes.

### Autenticação e Permissões

🟢 **CONFIRMADO** — `AuthService` escuta mudanças de autenticação Supabase, busca/cria role em `user_roles` e assina atualizações realtime de role.

Hierarquia de permissões:

- `user`: pode adicionar letras.
- `moderator`: herda `user`, pode editar letras e categorias, adicionar categorias.
- `admin`: herda `moderator`, pode excluir letras/categorias e acessar privilégios administrativos.
- Usuário anônimo não pode alterar conteúdo.

🟢 **CONFIRMADO** — Login Google usa `signInWithIdToken` com `OAuthProvider.google`. Falhas `ApiException: 10` recebem mensagem orientada a configuração OAuth.

### CRUD de Categorias e Letras

🟢 **CONFIRMADO** — Categorias têm `id`, `name`, `code`, `updated_at`, flags locais de sincronização e exclusão.

🟢 **CONFIRMADO** — Letras têm categoria, título, conteúdo, mídia (`audio_url`, `local_audio_path`, `youtube_link`) e `sequence_number`.

🟢 **CONFIRMADO** — Nova categoria gera `code` automaticamente a partir dos dois primeiros caracteres do nome, em maiúsculas, se o usuário não preencher manualmente.

🟢 **CONFIRMADO** — Nova letra recebe `sequence_number = max(sequence_number da categoria) + 1`.

🟢 **CONFIRMADO** — `LyricFormScreen` valida link do YouTube com `YoutubePlayer.convertUrlToId`; se inválido, bloqueia o save.

🟢 **CONFIRMADO** — Conteúdo legado em JSON é convertido para texto plano quando contém operações `insert`, preservando compatibilidade com formatos ricos anteriores.

### Mídia e Estatísticas

🟢 **CONFIRMADO** — `AudioPlayerService` transforma `Lyric` em `MediaItem`, priorizando arquivo local (`DeviceFileSource`) sobre URL remota (`UrlSource`).

🟢 **CONFIRMADO** — Playlists filtram apenas letras com `audioUrl` ou `localAudioPath`.

🟢 **CONFIRMADO** — `skipPrevious()` reinicia a faixa se a posição atual passar de 3 segundos; caso contrário, volta para a faixa anterior.

🟢 **CONFIRMADO** — Repeat alterna entre `none` e `all` e permite loop da playlist.

🟢 **CONFIRMADO** — Cada reprodução incrementa estatística em `PlayStatsService.incrementPlayCount`.

🟢 **CONFIRMADO** — `PlayStatsService` tenta RPC `increment_play_count` e, se falhar, usa fallback manual em `lyric_play_stats`.

### Favoritos

🟢 **CONFIRMADO** — Favoritos são locais, armazenados como lista de IDs em `SharedPreferences` na chave `favorite_lyrics`.

🟢 **CONFIRMADO** — A tela de favoritos resolve cada ID para `Lyric`, cruza com categorias para exibir código/nome e ordena por título.

### Administração e Auditoria

🟢 **CONFIRMADO** — `AdminService` consulta/atualiza usuários em `user_roles` e consulta logs em `audit_logs`.

🟢 **CONFIRMADO** — `AdminScreen` permite filtrar logs por tabela e período; o fim do período é tratado como exclusivo do dia seguinte para incluir o dia final completo.

🟢 **CONFIRMADO** — Renderização de log omite `is_synced` e `is_deleted` ao mostrar JSON, focando dados de negócio.

🔴 **LACUNA** — O schema lido inclui `user_roles` e `lyric_play_stats`, mas a existência de `audit_logs`/triggers de auditoria precisa ser validada pelo Data Master, pois o Scout não fez análise profunda de SQL.

### Atualização e Release

🟢 **CONFIRMADO** — `UpdateService` consulta `https://api.github.com/repos/Rdinda/FMA_Pontos/releases/latest`, compara versões semânticas simples e prefere asset `.apk` quando disponível.

🟢 **CONFIRMADO** — `.github/workflows/release-app.yml` publica APK ao receber tags `v*`, usando secrets de Supabase e keystore.

## Algoritmos e Regras Embutidas

| Regra/Algoritmo | Local | Confiança |
|---|---|---|
| Fallback de sessão anônima quando não há usuário Supabase | `lib/services/auth_service.dart` | 🟢 CONFIRMADO |
| Hierarquia RBAC `user < moderator < admin` | `lib/services/auth_service.dart` | 🟢 CONFIRMADO |
| Push/pull incremental por `last_sync_timestamp` | `lib/services/sync_repository.dart` | 🟢 CONFIRMADO |
| Soft delete local antes de hard delete pós-sync | `lib/services/db_helper.dart`, `lib/services/sync_repository.dart` | 🟢 CONFIRMADO |
| Preservação/invalidação de `localAudioPath` conforme `audioUrl` remoto | `lib/services/sync_repository.dart` | 🟢 CONFIRMADO |
| Sanitização de nome de arquivo de áudio para caracteres ASCII seguros | `lib/services/supabase_service.dart` | 🟢 CONFIRMADO |
| Extração de arquivo a partir de URL pública Supabase | `lib/services/supabase_service.dart` | 🟢 CONFIRMADO |
| Validação de YouTube por extração de video ID | `lib/screens/lyric_form_screen.dart` | 🟢 CONFIRMADO |
| Comparação de versão `major.minor.patch` | `lib/services/update_service.dart` | 🟢 CONFIRMADO |
| Geração de código de categoria pelos dois primeiros caracteres | `lib/screens/home_screen.dart` | 🟢 CONFIRMADO |
| Próximo número sequencial por `MAX(sequence_number)+1` | `lib/services/db_helper.dart`, `lib/services/sync_repository.dart` | 🟢 CONFIRMADO |

## Tratamento de Erros

- 🟢 **CONFIRMADO** — Serviços remotos geralmente fazem `try/catch` com `debugPrint`; alguns relançam (`AdminService`, upload de áudio) para UI tratar.
- 🟢 **CONFIRMADO** — Falha no incremento de estatísticas não interrompe reprodução.
- 🟢 **CONFIRMADO** — Falha de sync não propaga erro ao usuário; apenas loga e libera `_isSyncing`.
- 🟡 **INFERIDO** — Parte das falhas de sincronização pode ficar silenciosa para o usuário final.

## Artefatos Relacionados

- Dicionário de dados: `_reversa_sdd/data-dictionary.md`
- Dados estruturados de módulos: `.reversa/context/modules.json`
- Fluxogramas: `_reversa_sdd/flowcharts/*.md`

