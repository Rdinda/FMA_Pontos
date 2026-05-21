# ADR 006 — Favoritos locais e estatísticas remotas de reprodução

Data inferida: 2025-12-26  
Fonte: commit `e9796e8 feat: Gerenciamento de favoritos, estatísticas de reprodução e visualização de letras.`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O app precisava melhorar a experiência de estudo/uso recorrente com favoritos e ranking de pontos mais tocados.

## Decisão

Separar:

- favoritos como preferência local em `SharedPreferences`;
- estatísticas como contador remoto em `lyric_play_stats`;
- ranking em tela `TopPlayedScreen`;
- incremento de play ao iniciar reprodução.

## Consequências

- 🟢 **CONFIRMADO** — Favoritos funcionam offline e sem conta.
- 🟢 **CONFIRMADO** — Estatísticas agregadas podem refletir uso global/remoto.
- 🔴 **LACUNA** — A função RPC de incremento não está confirmada nos arquivos atuais, embora exista fallback.

