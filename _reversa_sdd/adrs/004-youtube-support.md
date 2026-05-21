# ADR 004 — Suporte a vídeo YouTube por letra

Data inferida: 2026-01-10  
Fonte: commit `e39b58e feat: add YouTube video support for lyrics`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O acervo já tinha texto e áudio; o commit adicionou `youtube_link`, player YouTube, validação e teste unitário.

## Decisão

Adicionar mídia de vídeo opcional por letra com:

- campo `youtube_link`;
- validação via `YoutubePlayer.convertUrlToId`;
- player dedicado na tela de visualização;
- seleção entre modo áudio e modo vídeo.

## Consequências

- 🟢 **CONFIRMADO** — Usuários podem aprender melodia/ritmo por referência audiovisual.
- 🟢 **CONFIRMADO** — Link inválido é bloqueado no formulário.
- 🟡 **INFERIDO** — Disponibilidade do conteúdo passa a depender de links externos.

