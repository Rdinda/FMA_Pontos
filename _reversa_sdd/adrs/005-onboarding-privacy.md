# ADR 005 — Onboarding com aceite de política de privacidade

Data inferida: 2025-12-26  
Fonte: commit `a5e51a2 feat(onboarding): add onboarding flow with privacy agreement`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O app coleta/usa autenticação, permissões de dispositivo, dados locais e serviços externos.

## Decisão

Introduzir onboarding inicial com três etapas e bloqueio de conclusão até aceite da política de privacidade. Persistir o aceite localmente com `onboarding_completed`.

## Consequências

- 🟢 **CONFIRMADO** — O usuário vê a política antes de usar o app pela primeira vez.
- 🟢 **CONFIRMADO** — O app evita reapresentar onboarding depois do aceite.
- 🟡 **INFERIDO** — O aceite é local por dispositivo, não uma prova remota vinculada à conta.

