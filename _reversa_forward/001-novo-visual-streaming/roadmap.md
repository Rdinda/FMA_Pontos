# Roadmap: Modernização Visual — Identidade Streaming

> Identificador: `001-novo-visual-streaming`
> Data: `2026-05-21`
> Requirements: `_reversa_forward/001-novo-visual-streaming/requirements.md`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA

## 1. Resumo da abordagem

A feature é um **delta puramente de apresentação** sobre o app Flutter existente. O núcleo técnico consiste em extrair o tema de `lib/main.dart` para uma camada `lib/theme/`, substituir a identidade roxa/Outfit por **verde streaming + Plus Jakarta Sans** alinhados aos mocks em `_reversa_sdd/stitch_screens/`, e reestilizar as 11 telas e 3 widgets compartilhados sem alterar providers, serviços, sync ou RBAC.

O `ThemeProvider` permanece como ponto de alternância claro/escuro/sistema; o **modo escuro passa a ser o default para novos usuários** (sem mock de tema claro, a paleta light será espelhada a partir dos tokens dark — premissa 🟡). Componentes visuais repetidos (search pill, bottom nav, badges de role, cards de categoria) serão extraídos para `lib/widgets/streaming/` para evitar copy-paste de `BoxDecoration` entre telas.

A entrega segue **release única** (RN-07): uma branch, um PR, smoke manual completo antes de merge — mas a implementação interna segue ordem fundação → compartilhados → telas → documentação.

## 2. Princípios aplicados

> `.reversa/principles.md` **não existe** neste projeto. Avaliação feita contra restrições explícitas do requirements e do contrato arquitetural.

| Princípio / restrição | Como a feature se relaciona | Status |
|------------------------|------------------------------|--------|
| RN-01 — escopo visual-only | Nenhum arquivo em `services/`, `models/`, `database/` ou `supabase/` alterado por regra de negócio | respeita |
| Contrato arquitetural (`architecture-contract.md`) | Persistência, sync e RBAC intactos; apenas `Screens`, `Bootstrap` e `Preferences/ThemeProvider` (default) | respeita |
| Manutenibilidade (tokens centralizados) | Extração `lib/theme/` + widgets compartilhados | respeita |
| Release única (RN-07) | Um ciclo de PR; smoke de RF-02–RF-10 antes de merge | respeita |

## 3. Decisões técnicas

| ID | Decisão | Justificativa | Alternativas descartadas | Confidência |
|----|---------|----------------|--------------------------|-------------|
| D-01 | Criar `lib/theme/app_colors.dart` + `lib/theme/app_theme.dart`; `main.dart` só injeta `theme`/`darkTheme` | RF-01 exige ponto único; `main.dart` hoje concentra ~120 linhas de tema | Manter tema inline em `main.dart` | 🟢 |
| D-02 | `ColorScheme` **explícito** para dark (valores extraídos de `Home_Acervo.html`); light derivado por inversão de surfaces + seed verde | Mocks Stitch não usam `fromSeed` puro; `#6200EE` atual contradiz identidade | Apenas `ColorScheme.fromSeed(seed: #1DB954)` | 🟢 |
| D-03 | Primary accent `#1DB954`; primary UI highlight `#53e076`; background `#131313`; surfaces `#201f1f`–`#353534` | Consistência com HTML Stitch e PNGs golden | Manter `#6200EE` como accent | 🟢 |
| D-04 | `GoogleFonts.plusJakartaSansTextTheme()` global; **remover** Montserrat/Open Sans de `LyricViewScreen` | RN-06 + esclarecimento 2026-05-21 | Manter hierarquia tripla Outfit/Montserrat/Open Sans | 🟢 |
| D-05 | `ThemeProvider`: default `ThemeMode.dark` para instalações sem preferência salva | RN-03 dark como padrão; hoje default é `ThemeMode.system` | Manter system como default | 🟡 |
| D-06 | AppBar **surface/transparente** com título on-surface (não barra roxa/verde sólida) | Mocks Stitch usam header integrado ao fundo escuro | AppBar `primary` preenchida (legado) | 🟢 |
| D-07 | Widgets compartilhados em `lib/widgets/streaming/`: `StreamingBottomNav`, `StreamingSearchField`, `RoleBadge`, `StreamingCard` | RF-11; bottom nav duplicada em Home e Admin | Reestilizar inline em cada tela | 🟢 |
| D-08 | Badges admin: admin=verde, moderador=roxo (`#BB86FC` ou tertiary mock), user=cinza, inativo=desaturado | RN-04; hoje `_getRoleColor` usa `error` para admin | Manter esquema error/tertiary legado | 🟢 |
| D-09 | Splash: `Scaffold` dark + logo de `assets/images/` + `CircularProgressIndicator` primary verde; revisar `styles.xml` Android se flash branco persistir | RF-10; splash nativa Android ainda pode aparecer antes do Flutter | Splash nativa-only | 🟡 |
| D-10 | Tema claro: paleta espelhada (surface `#F5F5F5`, on-surface `#1C1B1B`, cards brancos, primary `#1DB954`) sem mock dedicado | Lacuna requirements §10; validação manual WCAG | Dark-only (rejeitado em clarify) | 🟡 |

### Paleta dark de referência (extraída de `Home_Acervo.html`)

| Token | Hex | Uso |
|-------|-----|-----|
| `background` / `surface` | `#131313` | Scaffold |
| `surface-container` | `#201f1f` | Cards, inputs |
| `surface-container-high` | `#2a2a2a` | Elevação média |
| `surface-container-highest` | `#353534` | Chips, pills |
| `on-surface` | `#e5e2e1` | Texto principal |
| `primary` | `#53e076` | Links, ícones ativos |
| `primary-container` / accent CTA | `#1DB954` | Botões, progress, tab selecionada |
| `on-primary` | `#003914` | Texto sobre verde sólido |
| `outline` | `#869585` | Bordas |

## 4. Premissas

| Premissa | Origem (`requirements.md` seção) | Risco se errada |
|----------|----------------------------------|-----------------|
| Tema claro derivado espelhando dark (sem mock Stitch) é aceitável com validação manual | §10 Lacunas | Retrabalho de contraste ou segunda rodada visual no light mode |
| Default `ThemeMode.dark` não quebra expectativa de usuários com preferência `system` já salva | D-05 | Usuários existentes mantêm prefs; só afeta first install |
| Assets `Logo_Splash` / `Main_Cover` dos mocks podem ser mapeados para `assets/images/splash.png` existente ou PNGs em `_reversa_sdd/stitch_screens/` | RF-10 | Splash visual diverge do mock até importar asset |

## 5. Delta arquitetural

| Componente | Arquivo de origem no legado | Tipo de mudança | Resumo |
|------------|------------------------------|-----------------|--------|
| Bootstrap/App Shell | `_reversa_sdd/architecture.md` → `lib/main.dart` | contrato-alterado (apresentação) | Delega tema para `AppTheme`; remove `primaryColor` roxo |
| Preferences | `ThemeProvider` | regra-alterada (default) | Default dark para novos usuários |
| Screens | `lib/screens/*.dart` (11 arquivos) | contrato-alterado (layout) | Layout streaming por tela conforme golden files |
| Widgets | `category_player_widget`, `app_info_bottom_sheet`, `onboarding_widgets` | contrato-alterado (layout) | Tokens + mini-player reestilizado |
| Utils | `snackbar_utils.dart` | contrato-alterado (layout) | Cores/snackbar alinhados ao novo scheme |
| Design system docs | `_reversa_sdd/design-system/` | componente-extinto (valores) | tokens.md, color-palette.md, typography.md atualizados (RF-12) |
| Sync / Auth / Media / Models | — | **sem mudança** | Fora de escopo RN-01 |

### Arquivos legado tocados (rascunho para `legacy-impact.md` no coding)

**Novos:**
- `lib/theme/app_colors.dart`
- `lib/theme/app_theme.dart`
- `lib/widgets/streaming/streaming_bottom_nav.dart`
- `lib/widgets/streaming/streaming_search_field.dart`
- `lib/widgets/streaming/role_badge.dart`
- `lib/widgets/streaming/streaming_card.dart`

**Modificados:**
- `lib/main.dart`
- `lib/providers/theme_provider.dart`
- `lib/screens/splash_screen.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/category_screen.dart`
- `lib/screens/search_screen.dart`
- `lib/screens/lyric_view_screen.dart`
- `lib/screens/lyric_form_screen.dart`
- `lib/screens/favorites_screen.dart`
- `lib/screens/top_played_screen.dart`
- `lib/screens/admin_screen.dart`
- `lib/screens/onboarding_screen.dart`
- `lib/screens/privacy_policy_screen.dart`
- `lib/screens/onboarding_widgets.dart`
- `lib/widgets/category_player_widget.dart`
- `lib/widgets/app_info_bottom_sheet.dart`
- `lib/utils/snackbar_utils.dart`
- `android/app/src/main/res/values/styles.xml` (se flash branco)
- `_reversa_sdd/design-system/tokens.md` (+ palette, typography) — RF-12

## 6. Delta no modelo de dados

- **Resumo:** nenhuma alteração em SQLite, Supabase, SharedPreferences (exceto leitura existente de `theme_mode`) ou modelos de domínio.
- Detalhe completo em: `_reversa_forward/001-novo-visual-streaming/data-delta.md`

## 7. Delta de contratos externos

Nenhum contrato HTTP, fila, gRPC ou GraphQL é afetado. Diretório `interfaces/` **omitido**.

## 8. Plano de migração

Ordem de implementação (release única, sequência interna):

1. **Fundação** — `app_colors.dart`, `app_theme.dart`, Plus Jakarta Sans, `ThemeProvider` default dark; `flutter analyze`.
2. **Componentes compartilhados** — widgets `streaming/*`, `CategoryPlayerWidget`, `SnackbarUtils`, `AppInfoBottomSheet`.
3. **Telas core** — Home → Category → Search → LyricView → Admin (Must visuais críticos).
4. **Telas complementares** — LyricForm, Favorites, TopPlayed, Onboarding, Privacy, Splash.
5. **Plataforma** — splash Android nativo se necessário; smoke em emulador/dispositivo.
6. **Documentação** — atualizar `_reversa_sdd/design-system/` (RF-12).
7. **Validação** — checklist onboarding.md; alternar tema claro/escuro; `flutter analyze` limpo.

**Rollback:** revert do PR único; nenhuma migration de banco.

## 9. Riscos e mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| Hardcoded colors espalhados além de `main.dart` | Médio | Médio | Grep por `0xFF6200`, `Colors.red` em badges; centralizar em `AppColors` |
| Tema claro com contraste insuficiente | Médio | Médio | Checklist manual light/dark; ajustar `onSurface`/`surface` antes de merge |
| Regressão de layout em listas longas (Category, Admin) | Médio | Baixo | Manter estrutura `ListView`/`Sliver`; só trocar decorations |
| Mini-player sobreposto à bottom nav | Alto | Baixo | Preservar padding bottom existente em `CategoryPlayerWidget` |
| `google_fonts` offline na primeira execução | Baixo | Baixo | Cache automático do pacote; testar cold start |
| Usuário confunde admin badge verde com "erro" | Baixo | Baixo | Seguir mock; verde = admin conforme RN-04 |

## 10. Critério de pronto

- [ ] RF-01 a RF-11 implementados; smoke de RF-02–RF-10 conforme `onboarding.md`
- [ ] Tema claro e escuro navegáveis sem texto ilegível (RF-13)
- [ ] `flutter analyze` sem issues novos
- [ ] RBAC admin inalterado (cenário Gherkin requirements §7)
- [ ] `_reversa_sdd/design-system/tokens.md` reflete paleta streaming (RF-12)
- [ ] Todas as ações do `actions.md` marcadas `[X]` (após `/reversa-coding`)
- [ ] `regression-watch.md` gerado (após coding)

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-21 | Versão inicial gerada por `/reversa-plan` | reversa |
