# Legacy Impact: 001-novo-visual-streaming

> Data: `2026-05-21`
> Feature: Modernização Visual — Identidade Streaming

## Arquivos afetados

| Arquivo afetado | Componente | Tipo | Severidade | Justificativa |
|-----------------|------------|------|------------|---------------|
| `lib/theme/app_colors.dart` | Bootstrap/App Shell | componente-novo | LOW | Tokens de cor centralizados |
| `lib/theme/app_theme.dart` | Bootstrap/App Shell | componente-novo | MEDIUM | ThemeData dark/light streaming |
| `lib/main.dart` | Bootstrap/App Shell | contrato-alterado | MEDIUM | Delegação a `AppTheme`; remove roxo legado |
| `lib/providers/theme_provider.dart` | Preferences | regra-alterada | LOW | Default `ThemeMode.dark` para novos usuários |
| `lib/widgets/streaming/*.dart` | Widgets | componente-novo | LOW | Componentes visuais reutilizáveis |
| `lib/widgets/category_player_widget.dart` | Media | contrato-alterado | LOW | Tipografia e cores do mini-player |
| `lib/widgets/app_info_bottom_sheet.dart` | Screens | contrato-alterado | LOW | Herda novo tema (sem mudança lógica) |
| `lib/utils/snackbar_utils.dart` | Screens | contrato-alterado | LOW | Success usa `primaryContainer` |
| `lib/screens/*.dart` (11 arquivos) | Screens | contrato-alterado | MEDIUM | Layout/cores/fontes; lógica intacta |
| `android/app/src/main/res/**` | platform-android | contrato-alterado | LOW | Splash nativa escura `#131313` |
| `_reversa_sdd/design-system/*.md` | — | delta-de-dados (docs) | LOW | RF-12 documentação atualizada |

## Diff conceitual por componente

**Bootstrap/App Shell:** Identidade visual migra de roxo Material (`#6200EE`) + Outfit para verde streaming + Plus Jakarta Sans. AppBar deixa de ser barra primária sólida; passa a transparente sobre surface escura.

**Preferences:** Novos usuários iniciam em dark mode; preferência salva em SharedPreferences permanece compatível.

**Screens / Widgets:** Apenas camada de apresentação (decorations, tipografia, componentes compartilhados). Navegação, handlers, RBAC gates e chamadas a serviços inalterados.

**Sync / Auth / Media / Models:** Não tocados (RN-01).

## Preservadas

- Offline-first sync incremental (`SyncRepository`, SQLite)
- RBAC user/moderator/admin e gate `isAdmin` no painel
- Favoritos locais (`FavoritesService`)
- Fluxos onboarding/privacidade (prefs e versão de policy)
- Reprodução áudio/YouTube e mini-player persistente
- Estatísticas remotas (`PlayStatsService`)
- Contratos Supabase inalterados

## Modificadas

| Regra / aspecto | Antes | Depois | Severidade |
|-----------------|-------|--------|------------|
| Identidade visual brand | Roxo `#6200EE` | Verde `#1DB954` / `#53E076` | MEDIUM (apresentação) |
| Tipografia global | Outfit + Montserrat/Open Sans | Plus Jakarta Sans única | MEDIUM (apresentação) |
| Default tema | `ThemeMode.system` | `ThemeMode.dark` (sem prefs) | LOW (apresentação) |
| Badges admin | admin=error (vermelho) | admin=verde (RN-04) | LOW (apresentação) |
| AppBar | Fundo primary | Transparente / onSurface | LOW (apresentação) |
