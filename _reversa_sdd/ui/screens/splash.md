# Tela: Splash

| Campo | Valor |
|-------|-------|
| Arquivo | `lib/screens/splash_screen.dart` |
| Estado capturado | Carregando (logo estático) |
| Confiança | 🟢 CONFIRMADO |

## Propósito

Exibir identidade visual enquanto o app inicializa permissões, autenticação Supabase e verifica consentimento de privacidade/onboarding.

## Layout

```
┌─────────────────────────────┐
│         Status bar          │
├─────────────────────────────┤
│                             │
│                             │
│      [Logo circular]        │
│   Filhos de Maria das Almas │
│                             │
│      (spinner - código)     │
│      "Carregando..."        │
│                             │
│                    v1.0.19  │
└─────────────────────────────┘
```

## Elementos

| Elemento | Tipo | Detalhe |
|----------|------|---------|
| Logo | `Image.asset` | `assets/images/splash.png`, ~300×300 |
| Loader | `CupertinoActivityIndicator` | Cor primária (não visível no screenshot nativo) |
| Versão | `Text` | Canto inferior direito, fonte pequena |
| Progresso sync | `LinearProgressIndicator` | Condicional se `syncRepo.isDownloading` |

## Fluxo interno

1. Delay 2s (efeito splash)
2. Request `Permission.storage` + `Permission.audio`
3. `authService.ensureAuthenticated()`
4. Verifica `SharedPreferences`: onboarding + versão política
5. `pushReplacement` → `HomeScreen` ou `OnboardingScreen`

## Estados possíveis

| Estado | Visual |
|--------|--------|
| Carregando | Logo + spinner + “Carregando…” |
| Download sync | + texto status + barra progresso |
| Erro auth | Permanece até timeout/falha silenciosa — 🔴 LACUNA de UI de erro |

## Navegação

- **Entrada:** `MaterialApp.home`
- **Saída:** Home ou Onboarding (replace, sem back)
