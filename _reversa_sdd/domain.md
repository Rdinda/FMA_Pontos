# Domínio e Regras de Negócio — FMA_Pontos

Gerado pelo Reversa Detective em 2026-05-19T02:03:06Z.

## Síntese do Domínio

- 🟢 **CONFIRMADO** — O sistema preserva e organiza um acervo digital de pontos/letras de Umbanda, com categorias, conteúdo textual, áudio, vídeo, favoritos e estatísticas.
- 🟢 **CONFIRMADO** — O aplicativo deve funcionar com experiência offline-first: lê e grava localmente, sincronizando com Supabase quando há conexão.
- 🟢 **CONFIRMADO** — Há separação explícita entre consulta pública/usuário comum e manutenção moderada/admin.
- 🟡 **INFERIDO** — O acervo usa códigos de categoria e números sequenciais para facilitar referência, estudo e localização de pontos.

## Glossário

| Termo | Definição | Confiança |
|---|---|---|
| Ponto / Letra | Registro textual de um ponto cantado, opcionalmente acompanhado de áudio MP3 e vídeo YouTube. | 🟢 CONFIRMADO |
| Categoria | Agrupamento de pontos por linha/orixá/entidade ou outra taxonomia do acervo. | 🟡 INFERIDO |
| Código da categoria | Prefixo curto da categoria usado para montar uma referência visual da letra. | 🟢 CONFIRMADO |
| Sequência da letra | Número dentro da categoria usado para ordenar e compor código como `OX01`. | 🟢 CONFIRMADO |
| Favorito / Gostei | Marcação local do usuário para acessar pontos preferidos. | 🟢 CONFIRMADO |
| Mais tocados | Ranking baseado em contador remoto de reproduções por letra. | 🟢 CONFIRMADO |
| Sincronização | Processo de enviar alterações locais, buscar alterações remotas e baixar áudios faltantes. | 🟢 CONFIRMADO |
| Soft delete | Marcação lógica de exclusão antes de remoção física, usada para propagar exclusões no sync. | 🟢 CONFIRMADO |
| Usuário anônimo | Sessão Supabase sem login Google, usada para acesso básico sem permissões de manutenção. | 🟢 CONFIRMADO |
| Moderador | Papel que pode criar/editar conteúdo e categorias, mas não excluir. | 🟢 CONFIRMADO |
| Admin | Papel com permissões máximas, incluindo exclusão e administração de usuários. | 🟢 CONFIRMADO |

## Regras de Negócio

### Acesso e identidade

- 🟢 **CONFIRMADO** — O app tenta garantir uma sessão Supabase ativa antes de ir para a home.
- 🟢 **CONFIRMADO** — Se não houver usuário, `AuthService.ensureAuthenticated()` cria sessão anônima.
- 🟢 **CONFIRMADO** — Usuário anônimo pode consultar, mas não pode adicionar/editar/excluir conteúdo.
- 🟢 **CONFIRMADO** — Login Google eleva a identidade para usuário autenticado e permite consultar/criar role em `user_roles`.
- 🟢 **CONFIRMADO** — Role ausente para usuário logado é criada como `user`.

### Permissões de conteúdo

- 🟢 **CONFIRMADO** — `user` pode adicionar letras.
- 🟢 **CONFIRMADO** — `moderator` herda `user` e pode adicionar/editar categorias e letras.
- 🟢 **CONFIRMADO** — `admin` herda `moderator` e pode excluir categorias/letras e gerir usuários.
- 🟢 **CONFIRMADO** — A interface oculta ou bloqueia ações sem permissão e exibe snackbar orientando login/role necessário.
- 🟢 **CONFIRMADO** — As policies SQL também bloqueiam mutações por role e impedem mutação por usuário anônimo.

### Categorias

- 🟢 **CONFIRMADO** — Categoria exige `name` e `code`.
- 🟢 **CONFIRMADO** — Ao criar categoria pela home, se o código estiver vazio, ele é sugerido pelos dois primeiros caracteres do nome em maiúsculas.
- 🟢 **CONFIRMADO** — Excluir categoria faz soft delete local da categoria e de todas as letras associadas.
- 🟢 **CONFIRMADO** — Categorias visíveis filtram `is_deleted = 0` e são ordenadas por nome.
- 🟢 **CONFIRMADO** — No Supabase, `code` tem constraint única na migration `20260114120000_add_prefix_and_sequence.sql`.

### Letras / Pontos

- 🟢 **CONFIRMADO** — Letra exige `categoryId`, `title`, `content` e `updatedAt`.
- 🟢 **CONFIRMADO** — Nova letra recebe `sequenceNumber` calculado por `MAX(sequence_number) + 1` dentro da categoria.
- 🟢 **CONFIRMADO** — Letras de uma categoria são ordenadas por `sequence_number ASC`.
- 🟢 **CONFIRMADO** — Busca local consulta título ou conteúdo com `LIKE`, filtrando excluídos.
- 🟢 **CONFIRMADO** — Conteúdo legado em JSON com operações `insert` é convertido para texto plano no formulário.
- 🟢 **CONFIRMADO** — Link YouTube não vazio precisa ser reconhecido por `YoutubePlayer.convertUrlToId`.

### Mídia

- 🟢 **CONFIRMADO** — Upload de áudio gera nome com UUID e sanitiza o nome antes de gravar em `audio/lyrics/`.
- 🟢 **CONFIRMADO** — O app aceita/restringe áudio MP3 no schema remoto e nas policies de storage.
- 🟢 **CONFIRMADO** — Playback prioriza arquivo local se existir; caso contrário, usa URL remota.
- 🟢 **CONFIRMADO** — Player de detalhe permite escolher áudio ou vídeo; ao escolher vídeo, pausa áudio; ao escolher áudio, pausa YouTube.
- 🟢 **CONFIRMADO** — Playlist inclui apenas letras com áudio local ou remoto.

### Sincronização

- 🟢 **CONFIRMADO** — Sync não roda se `_isSyncing` já estiver ativo ou se o estado for offline.
- 🟢 **CONFIRMADO** — Alterações locais não sincronizadas são identificadas por `is_synced = 0`.
- 🟢 **CONFIRMADO** — Deletados locais são identificados por `is_deleted = 1`.
- 🟢 **CONFIRMADO** — Pull incremental usa `last_sync_timestamp` em `SharedPreferences`.
- 🟢 **CONFIRMADO** — A lógica antiga de apagar localmente itens ausentes no servidor foi removida; o sistema passou a confiar em `isDeleted` remoto.
- 🟢 **CONFIRMADO** — O timestamp de sync só é gravado depois do pull e antes do download de áudios.
- 🟡 **INFERIDO** — Conflitos simultâneos são resolvidos por último `updated_at` remoto/local de forma implícita; não há política de merge explícita.

### Estatísticas e favoritos

- 🟢 **CONFIRMADO** — Favoritos são locais e não sincronizados.
- 🟢 **CONFIRMADO** — Top tocados é remoto e depende de `lyric_play_stats`.
- 🟢 **CONFIRMADO** — Se a RPC `increment_play_count` falha, o app tenta fallback manual.
- 🔴 **LACUNA** — Não foi encontrada definição SQL da função `increment_play_count` nos arquivos atuais; o fallback parece ser necessário para ambientes sem a RPC.

### Privacidade e onboarding

- 🟢 **CONFIRMADO** — Primeira experiência exige aceite da política de privacidade antes de usar o app.
- 🟢 **CONFIRMADO** — O aceite é armazenado localmente em `onboarding_completed`.
- 🟡 **INFERIDO** — A inclusão do onboarding com privacidade foi decisão de compliance/clareza para distribuição pública.

### Administração e auditoria

- 🟢 **CONFIRMADO** — Área administrativa lista usuários, altera role, ativa/desativa usuário e consulta logs.
- 🟢 **CONFIRMADO** — Logs podem ser filtrados por tabela (`categories`, `lyrics`) e período.
- 🟡 **INFERIDO** — `audit_logs` existe no banco remoto histórico, pois uma migration remota revoga permissões nessa tabela e o app consulta a tabela.
- 🔴 **LACUNA** — Os arquivos versionados atuais não mostram claramente o `CREATE TABLE audit_logs` nem triggers de auditoria.

## Evidências Git

- `42c67f9 feat(sync): implement incremental sync with soft delete` — troca de hard delete por soft delete, timestamp incremental e abandono de wipe local.
- `28dc60c feat: add category codes and lyric sequence numbers` — introduz códigos de categoria, ordem por número e seed consolidado.
- `e39b58e feat: add YouTube video support for lyrics` — adiciona mídia YouTube e teste unitário de serialização.
- `7a3ad4f feat: Implementa área administrativa com auditoria, gestão de roles e autenticação Google.` — introduz admin, RBAC e auditoria.
- `a5e51a2 feat(onboarding): add onboarding flow with privacy agreement` — torna privacidade parte do fluxo inicial.
- `e9796e8 feat: Gerenciamento de favoritos, estatísticas de reprodução e visualização de letras.` — adiciona favoritos, top tocados e estatísticas.

## Lacunas

- 🔴 **LACUNA** — Confirmar no banco real se `audit_logs` e triggers de auditoria existem, já que o app depende deles.
- 🔴 **LACUNA** — Confirmar se a RPC `increment_play_count` existe no Supabase remoto.
- 🔴 **LACUNA** — Definir política explícita de conflito quando o mesmo registro é editado localmente e remotamente entre sincronizações.
- 🔴 **LACUNA** — Confirmar se usuários desativados (`is_active = false`) são bloqueados em policies ou apenas sinalizados na tela admin.

