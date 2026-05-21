# Onboarding e Privacidade — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre o primeiro uso do app: fluxo de onboarding em 3 páginas, aceite obrigatório da política de privacidade, persistência local do consentimento e tela de leitura da política acessível depois.  
🟢 **CONFIRMADO** — Gate na `SplashScreen`: se `onboarding_completed` é falso, navega para `OnboardingScreen`; senão `HomeScreen`.  
🟢 **CONFIRMADO** — Texto legal completo embutido em `PrivacyPolicyScreen` (constante `_policyText`).  
🟢 **CONFIRMADO** — Política deve ser **enxugada** para refletir apenas dados realmente coletados (Google OAuth, uso do acervo, SQLite, Supabase) — Roberto, 2026-05-20.  
🟢 **CONFIRMADO** — Nova versão da política deve **forçar novo aceite** via `privacy_policy_version` (Roberto, 2026-05-20).  
🟡 **INFERIDO** — Legado: texto genérico (CPF, telefone, localização) e apenas `onboarding_completed` boolean — ambos pendentes de implementação.

Referência: ADR 005 — `_reversa_sdd/adrs/005-onboarding-privacy.md`.

## Responsabilidades

- 🟢 **CONFIRMADO** — Apresentar 3 slides introdutórios com animação (`PageView` + `OnboardingSlide`).
- 🟢 **CONFIRMADO** — Apresentar slide final com checkbox de aceite da política (`OnboardingPrivacySlide`).
- 🟢 **CONFIRMADO** — Bloquear conclusão sem checkbox marcado (snackbar de erro).
- 🟢 **CONFIRMADO** — Permitir abrir política completa em tela dedicada a partir do checkbox.
- 🟢 **CONFIRMADO** — Persistir `onboarding_completed = true` ao concluir com aceite.
- 🟢 **CONFIRMADO** — Navegar para `HomeScreen` com `pushReplacement` após conclusão.
- 🟢 **CONFIRMADO** — Oferecer botão "Pular" nas páginas 1–2 que leva direto ao slide de privacidade.
- 🟢 **CONFIRMADO** — Exibir política novamente pelo bottom sheet de informações (qualquer momento).
- 🟢 **CONFIRMADO** — Solicitar permissões `storage` e `audio` na splash **antes** do gate de onboarding.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Chave de preferência: `onboarding_completed` (bool, default `false`).
- 🟢 **CONFIRMADO** — `_finishOnboarding` só grava preferência se `_acceptedPrivacy == true`.
- 🟢 **CONFIRMADO** — Botão principal: "Próximo" nas páginas 0–1; "Começar a usar" na página 2.
- 🟢 **CONFIRMADO** — Na página 2, "Começar a usar" chama `_finishOnboarding` (não avança PageView).
- 🟢 **CONFIRMADO** — "Pular" anima para página índice 2 sem marcar checkbox automaticamente.
- 🟢 **CONFIRMADO** — Indicadores de página (dots) refletem `_currentPage`.
- 🟢 **CONFIRMADO** — `ensureAuthenticated()` roda na splash antes da decisão onboarding vs home.
- 🟢 **CONFIRMADO** — Política declara titular Roberto Dinda Santos Pereira, CPF, contato `rdinda51@gmail.com`, foro São Paulo/SP.
- 🟢 **CONFIRMADO** — Data da política no texto: 26/12/2025.
- 🟢 **CONFIRMADO** — Ao publicar nova versão da política, usuário deve passar pelo fluxo de aceite novamente (comparar `privacy_policy_version` aceita vs. atual).  
- 🟡 **INFERIDO** — Legado não versiona consentimento; `onboarding_completed` permanece true após primeira aceitação.
- 🟡 **INFERIDO** — Desinstalar app reseta aceite (SharedPreferences limpo).

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 Na primeira abertura, usuário deve ver onboarding. | Must | Dado `onboarding_completed` ausente/false, quando splash termina, então `OnboardingScreen` abre. |
| RF-02 | 🟢 Após aceite, usuário não deve rever onboarding. | Must | Dado `onboarding_completed=true`, quando splash termina, então `HomeScreen` abre. |
| RF-03 | 🟢 Usuário deve aceitar política explicitamente. | Must | Dado checkbox desmarcado, quando toca Começar a usar, então snackbar pede confirmação e não navega. |
| RF-04 | 🟢 Usuário deve poder ler política integral. | Must | Dado link no checkbox, quando toca, então `PrivacyPolicyScreen` abre com scroll. |
| RF-05 | 🟢 Usuário deve poder pular slides introdutórios. | Should | Dado páginas 0–1, quando Pular, então PageView vai ao slide privacidade. |
| RF-06 | 🟢 Onboarding deve ter 3 páginas temáticas. | Must | Dado fluxo completo, quando percorre, então vê organização, uso do app e privacidade. |
| RF-07 | 🟢 Conclusão deve persistir localmente. | Must | Dado aceite, quando `_finishOnboarding`, então `SharedPreferences` grava true. |
| RF-08 | 🟢 Política deve ser acessível após onboarding. | Should | Dado bottom sheet, quando Política de Privacidade, então mesma tela de texto. |
| RF-09 | 🟢 Splash deve pedir permissões de mídia. | Should | Dado primeira execução, quando splash roda, então `Permission.storage` e `Permission.audio` são solicitadas. |
| RF-10 | 🟢 Política deve refletir dados realmente coletados. | Must | Dado texto em `PrivacyPolicyScreen`, quando publicado, então lista apenas: login Google (nome, email, avatar), dados de uso do acervo, sincronização Supabase, armazenamento local. Sem CPF/telefone/localização salvo pelo app. |
| RF-11 | 🟢 Nova versão da política deve exigir novo aceite. | Must | Dado `privacy_policy_version` no app > versão aceita em SharedPreferences, quando splash/onboarding, então usuário vê slide de privacidade e deve aceitar novamente. 🟡 Legado: não implementado. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência | Confiança |
|------|--------------------|-----------|-----------|
| Legal | Texto LGPD com 19 seções embutido no app. | `_policyText` | 🟢 |
| UX | Animações de slide (opacity, scale, translate). | `OnboardingSlide` AnimatedBuilder | 🟢 |
| Performance | Política estática sem rede. | const string | 🟢 |
| Privacidade | Consentimento local sem prova remota. | SharedPreferences only | 🟡 |
| Acessibilidade | CheckboxListTile com link inline. | `OnboardingPrivacySlide` | 🟢 |
| Manutenibilidade | Atualizar política exige novo build. | string hardcoded | 🟢 |

## Critérios de Aceitação

```gherkin
Dado instalação nova do app
Quando splash conclui após 2s e permissões
Então OnboardingScreen é exibida

Dado usuário no slide de privacidade sem checkbox
Quando pressiona Começar a usar
Então snackbar solicita concordância e permanece no onboarding

Dado checkbox marcado
Quando pressiona Começar a usar
Então onboarding_completed=true e HomeScreen substitui stack

Dado onboarding já concluído
Quando app reinicia
Então HomeScreen abre direto após splash

Dado usuário no slide 1
Quando toca Pular
Então vai ao slide privacidade sem auto-aceitar

Dado bottom sheet de informações
Quando abre Política de Privacidade
Então texto completo é exibido com scroll
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Gate onboarding | Must | 🟢 ADR 005; compliance. |
| Aceite explícito | Must | 🟢 Bloqueio legal. |
| Tela política | Must | 🟢 Transparência. |
| Pular slides | Should | 🟢 UX implementada. |
| Re-onboarding em mudança de policy | Must | 🟢 Confirmado; 🟡 legado pendente. |
| Texto alinhado a dados reais | Must | 🟢 Enxugar política (P7). |
| Consentimento remoto auditável | Won't (legado) | 🟡 Só local. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/screens/splash_screen.dart` | gate `onboarding_completed` | 🟢 |
| `lib/screens/onboarding_screen.dart` | fluxo 3 páginas, finish | 🟢 |
| `lib/screens/onboarding_widgets.dart` | slides, checkbox, logo | 🟢 |
| `lib/screens/privacy_policy_screen.dart` | texto legal | 🟢 |
| `lib/widgets/app_info_bottom_sheet.dart` | link política | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `autenticacao` | Splash chama `ensureAuthenticated` antes do onboarding. |
| `sincronizacao-offline` | Permissões storage na splash precedem uso offline. |
| `reproducao-audio` | Permissão audio na splash. |
| `release-update` | Atualizações de app não re-disparam onboarding automaticamente. |
