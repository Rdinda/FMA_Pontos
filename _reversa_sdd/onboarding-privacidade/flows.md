# Onboarding e Privacidade — Fluxos Operacionais

## Fluxo 1 — Primeira abertura do app (splash → onboarding)

```mermaid
flowchart TD
  A["App start → SplashScreen"] --> B["delay 2 segundos"]
  B --> C["request storage + audio"]
  C --> D["ensureAuthenticated"]
  D --> E["prefs onboarding_completed?"]
  E -- "false/null" --> F["pushReplacement OnboardingScreen"]
  E -- "true" --> G["pushReplacement HomeScreen"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Permissões e auth ocorrem mesmo na primeira vez, antes do aceite LGPD.
- 🟢 **CONFIRMADO** — Não há rota para Home sem passar pelo onboarding na primeira instalação.

## Fluxo 2 — Percorrer onboarding (happy path)

```mermaid
flowchart TD
  A["OnboardingScreen page 0"] --> B["Próximo → page 1"]
  B --> C["Próximo → page 2 privacidade"]
  C --> D["Usuário marca checkbox"]
  D --> E["Começar a usar"]
  E --> F["_finishOnboarding"]
  F --> G["setBool onboarding_completed true"]
  G --> H["pushReplacement HomeScreen"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Três toques em Próximo/Começar no caminho mínimo (ou Pular + checkbox + Começar).

## Fluxo 3 — Tentativa de concluir sem aceite

```mermaid
flowchart TD
  A["Page 2 checkbox desmarcado"] --> B["Começar a usar"]
  B --> C["_finishOnboarding"]
  C --> D{"_acceptedPrivacy?"}
  D -- "não" --> E["Snackbar erro LGPD"]
  E --> F["permanece OnboardingScreen"]
  D -- "sim" --> G["Fluxo 2 finish"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Mensagem: "Para continuar, confirme que leu e concorda com a Política de Privacidade."

## Fluxo 4 — Pular slides introdutórios

```mermaid
flowchart TD
  A["Page 0 ou 1"] --> B["Tap Pular"]
  B --> C["animateToPage índice 2"]
  C --> D["_currentPage = 2"]
  D --> E["Botão Pular oculto"]
  E --> F["Usuário ainda deve marcar checkbox"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Pular **não** define `_acceptedPrivacy = true`.
- 🟢 **CONFIRMADO** — Indicadores atualizam para terceiro dot.

## Fluxo 5 — Ler política durante onboarding

```mermaid
sequenceDiagram
  participant U as Usuário
  participant O as OnboardingPrivacySlide
  participant P as PrivacyPolicyScreen
  U->>O: tap link Política de Privacidade
  O->>P: Navigator.push
  U->>P: scroll texto
  U->>P: back
  O->>O: checkbox permanece estado anterior
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Leitura não implica aceite automático.
- 🟢 **CONFIRMADO** — Política disponível offline (string local).

## Fluxo 6 — Reabrir política após onboarding

```mermaid
flowchart TD
  A["Home ou qualquer tela"] --> B["Bottom sheet informações"]
  B --> C["ListTile Política de Privacidade"]
  C --> D["Navigator.push PrivacyPolicyScreen"]
  D --> E["Usuário lê e volta"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Não altera `onboarding_completed`.
- 🟢 **CONFIRMADO** — Disponível para anônimos e autenticados.

## Fluxo 7 — Reabertura do app (usuário recorrente)

```mermaid
flowchart TD
  A["Splash"] --> B["permissões + auth"]
  B --> C["onboarding_completed == true"]
  C --> D["HomeScreen direto"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Onboarding não reaparece enquanto prefs persistirem.
- 🟡 **INFERIDO** — Clear data / reinstall reinicia fluxo 1.

## Fluxo 8 — Navegação entre páginas (indicadores)

```mermaid
flowchart LR
  P0["Page 0"] --> P1["Page 1"]
  P1 --> P2["Page 2"]
  P0 -.->|"Pular"| P2
  P1 -.->|"Pular"| P2
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Swipe horizontal também muda página (`PageView`).
- 🟢 **CONFIRMADO** — Dots animados: largura 20 ativo, 8 inativo.

## Matriz fluxo × RF

| Fluxo | RF |
|-------|-----|
| Splash gate | RF-01, RF-02, RF-09 |
| Happy path finish | RF-03, RF-06, RF-07 |
| Bloqueio sem aceite | RF-03 |
| Pular | RF-05 |
| Ler política | RF-04, RF-08 |
| Reabertura app | RF-02 |
| Bottom sheet política | RF-08 |
