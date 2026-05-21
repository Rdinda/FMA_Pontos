# Estatísticas / Mais Tocados — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre o ranking global de letras mais reproduzidas: contador remoto em Supabase (`lyric_play_stats`), incremento ao iniciar playback de áudio e tela **Mais Tocados** com lista ranqueada.  
🟢 **CONFIRMADO** — `PlayStatsService` centraliza RPC/fallback de incremento, consulta do top N e contagem por letra.  
🟢 **CONFIRMADO** — Metadados da letra (título, categoria) vêm do **SQLite local**; contagens vêm do **Supabase**.  
🟡 **INFERIDO** — Reprodução YouTube **não** incrementa estatísticas (apenas `AudioPlayerService`).  
🟢 **CONFIRMADO** — Tabela `lyric_play_stats` existe em produção (backup 2026-01-21).  
🟡 **INFERIDO** — RPC `increment_play_count` **não existe** no backup de produção; caminho efetivo é **fallback client-side** (`_incrementPlayCountFallback`). App tenta RPC primeiro e cai no fallback.  
🟡 **INFERIDO** — Migration proposta em `_reversa_sdd/supabase-extracted/increment_play_count-proposed.sql` para alinhar servidor.

Referência: ADR 006 — `_reversa_sdd/adrs/006-favorites-play-stats.md`.

## Responsabilidades

- 🟢 **CONFIRMADO** — Incrementar `play_count` quando uma letra **nova** começa a tocar via áudio (`play` ou `_playCurrentTrack`).
- 🟡 **INFERIDO** — Tentar RPC `increment_play_count(p_lyric_id)` antes do fallback; RPC ausente em produção → fallback é o comportamento real hoje.
- 🟢 **CONFIRMADO** — Fallback: SELECT + UPDATE ou INSERT em `lyric_play_stats` com `last_played_at` e `updated_at`.
- 🟢 **CONFIRMADO** — Não interromper reprodução se incremento falhar (erro apenas logado).
- 🟢 **CONFIRMADO** — Listar top letras ordenadas por `play_count` descendente (limite configurável).
- 🟢 **CONFIRMADO** — Enriquecer ranking com `Lyric` local e nome da categoria via `DatabaseHelper`.
- 🟢 **CONFIRMADO** — Expor tela com ranking visual (top 3 destacado), play individual, play all e navegação para letra.
- 🟢 **CONFIRMADO** — Entrada na Home pela aba/botão "Mais Tocados" (índice 2 do bottom nav).
- 🟡 **INFERIDO** — `getPlayCount(lyricId)` disponível na API mas **sem consumidor** na UI atual.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Incremento ocorre ao **trocar** para outra letra, não ao pausar/retomar a mesma (`play()` ramo else).
- 🟢 **CONFIRMADO** — Em playlist, cada faixa incrementa ao entrar em `_playCurrentTrack` (inclui skip next/prev e repeat).
- 🟢 **CONFIRMADO** — Ranking ignora letras ausentes no SQLite local (sem erro, simplesmente omitidas da lista).
- 🟢 **CONFIRMADO** — `TopPlayedScreen` solicita `getTopPlayed(limit: 50)`; default do serviço é 20 se não informado.
- 🟢 **CONFIRMADO** — "Tocar todos" filtra apenas letras com `audioUrl` ou `localAudioPath` preenchido.
- 🟢 **CONFIRMADO** — Lista vazia de stats mostra empty state incentivando explorar categorias.
- 🟢 **CONFIRMADO** — Estatísticas são **globais/agregadas** (não por usuário/dispositivo).
- 🟢 **CONFIRMADO** — SELECT em `lyric_play_stats` é público (`USING (true)`); leitura não exige login Google.
- 🟢 **CONFIRMADO** — INSERT/UPDATE exigem role `authenticated` (inclui sessão anônima Supabase).
- 🟡 **INFERIDO** — Múltiplos dispositivos incrementam o mesmo contador global por `lyric_id`.
- 🔴 **LACUNA** — Race condition no fallback read-modify-write sem transação atômica.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve incrementar contador ao iniciar áudio de letra nova. | Must | Dado `play(lyricB)` com letra atual A, quando playback inicia, então `incrementPlayCount(B)` é chamado. |
| RF-02 | 🟢 O sistema não deve incrementar ao pausar/retomar mesma letra. | Must | Dado mesma letra atual, quando usuário pausa e resume, então contador não incrementa novamente. |
| RF-03 | 🟢 O sistema deve usar RPC quando disponível. | Should | Dado RPC `increment_play_count` no Supabase, quando incrementa, então `rpc` é chamado com `p_lyric_id`. |
| RF-04 | 🟢 O sistema deve ter fallback se RPC falhar. | Must | Dado RPC ausente ou erro, quando incrementa, então upsert manual em `lyric_play_stats` executa. |
| RF-05 | 🟢 Falha de stats não deve bloquear áudio. | Must | Dado erro no incremento, quando reproduz, então playback continua e erro é logado. |
| RF-06 | 🟢 O app deve exibir ranking Mais Tocados. | Must | Dado Home → Mais Tocados, quando tela abre, então lista ordenada por `play_count` é exibida. |
| RF-07 | 🟢 O ranking deve mostrar posição, título, categoria e contagem. | Must | Dado item no ranking, quando renderiza, então rank, título, `categoryName` e `playCount` aparecem. |
| RF-08 | 🟢 Top 3 deve ter destaque visual (medalhas/cores). | Should | Dado ranks 1-3, quando renderiza leading, então ícone troféu com cores ouro/prata/bronze. |
| RF-09 | 🟢 Usuário deve tocar letra individualmente da lista. | Must | Dado botão play no item, quando toca, então `AudioPlayerService.play(lyric)` inicia. |
| RF-10 | 🟢 Usuário deve tocar playlist dos mais tocados com áudio. | Should | Dado botão play all, quando há itens com áudio, então `playAll` inicia playlist filtrada. |
| RF-11 | 🟢 Usuário deve abrir letra ao tocar no item. | Must | Dado tap na linha, quando navega, então `LyricViewScreen` abre com a letra. |
| RF-12 | 🟢 Lista deve suportar refresh manual. | Should | Dado pull-to-refresh ou ícone refresh, quando aciona, então `getTopPlayed` reexecuta. |
| RF-13 | 🟡 API deve retornar contagem de uma letra. | Could | Dado `getPlayCount(id)`, quando consulta, então retorna `play_count` ou 0. |
| RF-14 | 🟢 Player compacto deve aparecer na tela Mais Tocados. | Should | Dado playlist ativa, quando renderiza, então `CategoryPlayerWidget` no rodapé. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Disponibilidade | Ranking funciona offline parcialmente se stats já lidos — nova carga precisa rede. | fetch Supabase | 🟢 |
| Performance | Índice `idx_lyric_play_stats_count` em `play_count DESC`. | `supabase_schema.sql` | 🟢 |
| Resiliência | Erros retornam lista vazia ou 0 sem crash. | catch em getTopPlayed/getPlayCount | 🟢 |
| Consistência eventual | Fallback não atômico sob concorrência. | read-then-write | 🟡 |
| Privacidade | Contagem global sem identificar ouvinte no registro. | schema sem user_id em stats | 🟢 |
| UX | Estados loading, erro, vazio na `TopPlayedScreen`. | `_buildContent` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado usuário inicia reprodução de letra X pela primeira vez na sessão
Quando AudioPlayerService.play inicia media item
Então incrementPlayCount(X) é disparado de forma assíncrona

Dado usuário pausa e retoma a mesma letra
Quando play é chamado novamente
Então incrementPlayCount não é chamado

Dado RPC increment_play_count indisponível
Quando incrementPlayCount executa
Então fallback atualiza ou insere linha em lyric_play_stats

Dado lyric_play_stats com registros
Quando TopPlayedScreen carrega
Então lista mostra até 50 itens ordenados por play_count decrescente

Dado letra no ranking sem cópia local no SQLite
Quando getTopPlayed monta resultado
Então letra é omitida da lista exibida

Dado usuário na tela Mais Tocados com itens com áudio
Quando toca Tocar todos
Então playlist inicia apenas com letras que têm audioUrl ou localAudioPath

Dado ranking vazio
Quando tela renderiza
Então mensagem Nenhum ponto tocado ainda é exibida
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Incremento no play de áudio | Must | 🟢 ADR 006; alimenta ranking. |
| Fallback sem RPC | Must | 🟢 App funciona sem migration RPC. |
| Tela Mais Tocados | Must | 🟢 Superfície principal da feature. |
| Play all / play item | Should | 🟢 UX de estudo em lote. |
| Destaque top 3 | Should | 🟢 Implementado visualmente. |
| `getPlayCount` na UI | Could | 🟡 API órfã. |
| RPC versionada no repo | Should | 🔴 Lacuna operacional. |
| Stats por usuário | Won't | 🟢 Modelo global deliberado. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/play_stats_service.dart` | `PlayStatsService`, modelos | 🟢 |
| `lib/services/audio_player_service.dart` | chamadas `incrementPlayCount` | 🟢 |
| `lib/screens/top_played_screen.dart` | UI ranking | 🟢 |
| `lib/screens/home_screen.dart` | navegação aba Mais Tocados | 🟢 |
| `lib/services/db_helper.dart` | `getLyricById`, `readAllCategories` | 🟢 |
| `lib/widgets/category_player_widget.dart` | player rodapé | 🟢 |
| `supabase/supabase_schema.sql` | tabela `lyric_play_stats`, RLS, índice | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `reproducao-audio` | Dispara incremento; fornece `play`/`playAll`. |
| `sincronizacao-offline` | Metadados locais para enriquecer ranking. |
| `favoritos` | Complementar (preferência local vs popularidade global). |
| `visualizacao-letra` | Destino ao tocar item do ranking. |
| `autenticacao` | Sessão anônima `authenticated` permite mutação de stats. |
