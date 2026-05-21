# Code / Spec Matrix — FMA_Pontos

Gerado pelo Reversa Writer em 2026-05-20T00:00:00Z.

Legenda de cobertura:

| Símbolo | Significado |
|---------|-------------|
| 🟢 | Spec SDD cobre o arquivo de forma direta e rastreável |
| 🟡 | Cobertura parcial ou indireta (infra/cross-cutting) |
| — | Sem spec de feature dedicada; candidato a análise futura |

## Matriz principal — `lib/`

| Arquivo legado | Spec / unit principal | Cobertura | Observação |
|----------------|----------------------|-----------|------------|
| `lib/main.dart` | `acervo-categorias`, `autenticacao`, `sincronizacao-offline` | 🟡 | Bootstrap, `MultiProvider`, tema |
| `lib/screens/splash_screen.dart` | `onboarding-privacidade`, `autenticacao` | 🟢 | Gate onboarding + permissões |
| `lib/screens/onboarding_screen.dart` | `onboarding-privacidade` | 🟢 | |
| `lib/screens/onboarding_widgets.dart` | `onboarding-privacidade` | 🟢 | |
| `lib/screens/privacy_policy_screen.dart` | `onboarding-privacidade` | 🟢 | |
| `lib/screens/home_screen.dart` | `acervo-categorias`, `release-update`, `autenticacao` | 🟢 | Lista categorias, update dialog |
| `lib/screens/category_screen.dart` | `acervo-categorias`, `autenticacao` | 🟢 | Lista letras, FAB add |
| `lib/screens/search_screen.dart` | `busca` | 🟢 | |
| `lib/screens/lyric_view_screen.dart` | `visualizacao-letra`, `favoritos`, `reproducao-audio`, `reproducao-youtube` | 🟢 | Tela mais transversal |
| `lib/screens/lyric_form_screen.dart` | `edicao-letra`, `reproducao-youtube` | 🟢 | |
| `lib/screens/favorites_screen.dart` | `favoritos` | 🟢 | |
| `lib/screens/top_played_screen.dart` | `estatisticas-mais-tocados` | 🟢 | |
| `lib/screens/admin_screen.dart` | `administracao` | 🟢 | |
| `lib/services/sync_repository.dart` | `sincronizacao-offline` | 🟢 | Núcleo offline-first |
| `lib/services/db_helper.dart` | `sincronizacao-offline` | 🟢 | |
| `lib/services/supabase_service.dart` | `sincronizacao-offline`, `edicao-letra` | 🟢 | |
| `lib/services/auth_service.dart` | `autenticacao` | 🟢 | |
| `lib/services/admin_service.dart` | `administracao` | 🟢 | |
| `lib/services/favorites_service.dart` | `favoritos` | 🟢 | |
| `lib/services/audio_player_service.dart` | `reproducao-audio` | 🟢 | |
| `lib/services/play_stats_service.dart` | `estatisticas-mais-tocados` | 🟢 | |
| `lib/services/update_service.dart` | `release-update` | 🟢 | |
| `lib/models/category.dart` | `acervo-categorias`, `sincronizacao-offline` | 🟢 | |
| `lib/models/lyric.dart` | `edicao-letra`, `visualizacao-letra`, `sincronizacao-offline` | 🟢 | |
| `lib/models/user_info.dart` | `autenticacao`, `administracao` | 🟢 | |
| `lib/models/audit_log.dart` | `administracao` | 🟢 | |
| `lib/widgets/category_player_widget.dart` | `reproducao-audio`, `favoritos` | 🟢 | |
| `lib/widgets/app_info_bottom_sheet.dart` | `autenticacao`, `administracao`, `onboarding-privacidade` | 🟢 | |
| `lib/widgets/skeleton_widget.dart` | — | — | Loading UI; não especificado em unit |
| `lib/providers/theme_provider.dart` | — | 🟡 | Cross-cutting UI |
| `lib/utils/snackbar_utils.dart` | — | 🟡 | Utilitário compartilhado |
| `lib/utils/string_extensions.dart` | — | 🟡 | `capitalize()` em listas |

## Matriz — plataforma e CI

| Arquivo / pasta | Spec / artefato | Cobertura | Observação |
|-----------------|-----------------|-----------|------------|
| `android/app/src/main/AndroidManifest.xml` | `flowcharts/platform-android.md` | 🟡 | Permissões, intent |
| `android/app/build.gradle.kts` | `flowcharts/platform-android.md`, `release-update` | 🟡 | applicationId, signing |
| `ios/**` | `flowcharts/platform-ios.md` | 🟡 | Scaffold Flutter iOS |
| `.github/workflows/release-app.yml` | `release-update` | 🟢 | |
| `supabase/supabase_schema.sql` | `sincronizacao-offline`, `autenticacao`, `estatisticas-mais-tocados` | 🟡 | DDL compartilhado |
| `pubspec.yaml` | `release-update`, `dependencies.md` | 🟡 | Versão app |

## Cobertura por unit SDD

| Unit | Arquivos 🟢 mapeados | Lacunas na spec |
|------|---------------------|-----------------|
| `acervo-categorias` | home, category, category/lyric models, sync | — |
| `busca` | search_screen | — |
| `favoritos` | favorites_service, favorites_screen, lyric_view, player | — |
| `visualizacao-letra` | lyric_view_screen | — |
| `edicao-letra` | lyric_form_screen, supabase storage paths | — |
| `reproducao-audio` | audio_player_service, category_player | Handler interno em mesmo arquivo |
| `reproducao-youtube` | lyric_view, lyric_form | — |
| `sincronizacao-offline` | sync_repository, db_helper, supabase_service | — |
| `autenticacao` | auth_service, splash, bottom sheet | — |
| `administracao` | admin_screen, admin_service, models | audit_logs DDL |
| `estatisticas-mais-tocados` | play_stats_service, top_played_screen | RPC SQL |
| `onboarding-privacidade` | onboarding*, privacy, splash gate | — |
| `release-update` | update_service, home dialog, workflow | — |

## Arquivos sem spec (candidatos)

| Arquivo | Motivo |
|---------|--------|
| `lib/widgets/skeleton_widget.dart` | UI genérica de loading |
| `lib/providers/theme_provider.dart` | Tema global — poderia virar unit `design-system` |
| `lib/utils/*` | Utilitários transversais |

## Artefatos de interpretação (não substituem SDD)

| Artefato | Relação |
|----------|---------|
| `_reversa_sdd/architecture.md` | Visão geral |
| `_reversa_sdd/code-analysis.md` | Escavação |
| `_reversa_sdd/domain.md` | Regras de negócio |
| `_reversa_sdd/traceability/spec-impact-matrix.md` | Impacto feature → componentes |
| `_reversa_sdd/adrs/*.md` | Decisões retroativas |

## Estimativa de cobertura

| Métrica | Valor |
|---------|-------|
| Arquivos Dart em `lib/` | 32 |
| Com cobertura 🟢 ou 🟡 explícita | 29 |
| Sem spec (`—`) | 3 |
| **Cobertura estimada** | **~91%** dos arquivos de aplicação |

🔴 **LACUNA** — Testes automatizados (`test/`) ausentes no repositório; coluna Tests na spec-impact permanece "Ausente".
