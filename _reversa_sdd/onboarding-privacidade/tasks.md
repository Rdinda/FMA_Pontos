# Onboarding e Privacidade — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 `shared_preferences` configurado.
- [ ] 🟢 `permission_handler` para storage e audio.
- [ ] 🟢 Asset `assets/images/maria.png` declarado no `pubspec.yaml`.
- [ ] 🟢 `AuthService` e splash já integrados.
- [ ] 🟢 Texto legal revisado por responsável (LGPD).

## Tarefas — Splash e Gate

- [ ] T-01, Implementar delay e permissões na splash
  - Origem no legado: `splash_screen.dart`
  - Critério de pronto: após 2s, `Permission.storage` e `Permission.audio` requested; depois `ensureAuthenticated`.
  - Confiança: 🟢

- [ ] T-02, Implementar gate `onboarding_completed`
  - Origem no legado: `splash_screen.dart`
  - Critério de pronto: `getBool('onboarding_completed') ?? false` decide `OnboardingScreen` vs `HomeScreen` com `pushReplacement`.
  - Confiança: 🟢

## Tarefas — OnboardingScreen

- [ ] T-03, Implementar `PageView` com 3 páginas
  - Origem no legado: `onboarding_screen.dart`
  - Critério de pronto: `PageController`, `onPageChanged` atualiza `_currentPage`, indicadores dots.
  - Confiança: 🟢

- [ ] T-04, Implementar slides introdutórios
  - Origem no legado: `onboarding_widgets.dart` — `OnboardingSlide`
  - Critério de pronto: títulos/descrições páginas 0–1; animação opacity/scale/translate; `BreathingLogo`.
  - Confiança: 🟢

- [ ] T-05, Implementar slide de privacidade com checkbox
  - Origem no legado: `OnboardingPrivacySlide`
  - Critério de pronto: checkbox controla `_acceptedPrivacy`; link abre `PrivacyPolicyScreen`.
  - Confiança: 🟢

- [ ] T-06, Implementar botão Próximo / Começar a usar
  - Origem no legado: `onboarding_screen.dart`
  - Critério de pronto: páginas 0–1 avançam PageView; página 2 chama `_finishOnboarding`.
  - Confiança: 🟢

- [ ] T-07, Implementar validação de aceite no finish
  - Origem no legado: `_finishOnboarding`
  - Critério de pronto: sem aceite → snackbar erro; com aceite → prefs + `HomeScreen`.
  - Confiança: 🟢

- [ ] T-08, Implementar ação Pular
  - Origem no legado: `_skip`
  - Critério de pronto: visível só se `_currentPage < 2`; `animateToPage(2)` sem marcar checkbox.
  - Confiança: 🟢

## Tarefas — Política de Privacidade

- [ ] T-09, Implementar `PrivacyPolicyScreen` com texto embutido
  - Origem no legado: `privacy_policy_screen.dart`
  - Critério de pronto: `_policyText` const com seções LGPD; scroll; AppBar título.
  - Confiança: 🟢

- [ ] T-10, Expor política no bottom sheet
  - Origem no legado: `app_info_bottom_sheet.dart`
  - Critério de pronto: ListTile navega para `PrivacyPolicyScreen`.
  - Confiança: 🟢

## Tarefas — Melhorias (opcional)

- [ ] T-11, Persistir versão da política aceita
  - Origem no legado: lacuna
  - Critério de pronto: chave `privacy_policy_version_accepted`; re-onboarding se versão mudar.
  - Confiança: 🟡

- [ ] T-12, Alinhar texto da política com dados coletados
  - Origem no legado: lacuna jurídica
  - Critério de pronto: remover menções a CPF/localização se não coletados; citar Supabase/Google.
  - Confiança: 🟡

- [ ] T-13, Mover pedido de permissões para após aceite LGPD
  - Origem no legado: ordem atual na splash
  - Critério de pronto: permissões só após `_finishOnboarding` ou justificativa no slide.
  - Confiança: 🟡

## Ordem sugerida

1. T-09 (texto legal)
2. T-04 → T-05 (widgets)
3. T-03 → T-08 (OnboardingScreen)
4. T-01 → T-02 (splash gate)
5. T-10
6. T-11 → T-13 (compliance hardening)
