# ADR 003 — Códigos de categoria e números sequenciais para letras

Data inferida: 2026-01-14  
Fonte: commit `28dc60c feat: add category codes and lyric sequence numbers`

## Status

Aceito.

## Contexto

🟢 **CONFIRMADO** — O acervo passou a precisar de ordenação e identificação visual das letras por categoria.

## Decisão

Adicionar:

- `Category.code`;
- `Lyric.sequenceNumber`;
- migration remota para `categories.code` único e `lyrics.sequence_number`;
- UI mostrando referências como `CODE + sequenceNumber.padLeft(2, '0')`.

## Consequências

- 🟢 **CONFIRMADO** — Letras ficam ordenadas por sequência dentro da categoria.
- 🟢 **CONFIRMADO** — Referências visuais ficam estáveis e legíveis.
- 🟡 **INFERIDO** — Pode haver colisão se códigos forem gerados automaticamente sem revisão humana.

