# Reconstruction Plan — FMA_Pontos

**Stack:** Flutter (Dart), SQLite, Supabase
**Gerado em:** 2026-05-21
**Status:** 18 tarefas | 18 concluídas | 0 pendentes
**Fonte:** original

---

## Alertas de pré-voo

> Revise estes pontos antes de iniciar. Gaps marcados com ⚠️ bloqueiam a tarefa associada.

- ~~G-08 (Sem re-consentimento da política)~~ (Resolvido na reconstrução da splash/onboarding)
- ~~G-09 (AdminScreen sem guard de role)~~ (Resolvido na Tarefa 14)
- ~~G-14 (SHA256 no update)~~ (Resolvido na Tarefa 15)

---

## Tarefas

### Tarefa 01 — Schema do Banco de Dados
**Status:** done
**Lê:** `_reversa_sdd/erd-complete.md`, `_reversa_sdd/data-dictionary.md`
**Constrói:** migrations, schema, modelos ORM (conforme stack detectada)
**Pronto quando:** Todas as tabelas do ERD existem com tipos, constraints e foreign keys corretos

---

### Tarefa 02 — Entidades de Domínio
**Status:** done
**Lê:** `_reversa_sdd/domain.md`, `_reversa_sdd/data-dictionary.md`
**Constrói:** entidades, value objects, validações de domínio
**Pronto quando:** Todas as entidades implementadas com as regras de negócio descritas

---

### Tarefa 03 — Máquinas de Estado
**Status:** done
**Lê:** `_reversa_sdd/state-machines.md`
**Constrói:** implementação dos fluxos de estado de cada entidade
**Pronto quando:** Todos os estados e transições documentados estão implementados
**Obs:** Pular esta tarefa se `_reversa_sdd/state-machines.md` não existir

---

### Tarefa 04 — Onboarding e Privacidade
**Status:** done
**Lê:** `_reversa_sdd/onboarding-privacidade/requirements.md`, `_reversa_sdd/onboarding-privacidade/design.md`, `_reversa_sdd/onboarding-privacidade/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Splash e fluxo de telas de onboarding, política de privacidade com gate de aceitação de termos local persistido.
**Pronto quando:** O fluxo inicial de splash bloqueia a navegação até que os termos de privacidade sejam aceitos, persistindo a versão do consentimento.
**Alerta:** G-08 resolvido (a verificação de versão da política garante re-consentimento)

---

### Tarefa 05 — Autenticação
**Status:** done
**Lê:** `_reversa_sdd/autenticacao/requirements.md`, `_reversa_sdd/autenticacao/design.md`, `_reversa_sdd/autenticacao/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Serviço de autenticação Supabase Auth, integração de login com Google OAuth, e sessão anônima persistente.
**Pronto quando:** É possível fazer login via conta Google ou autenticar de forma anônima, atribuindo papéis de usuário (roles) de forma segura.

---

### Tarefa 06 — Reprodução YouTube
**Status:** done
**Lê:** `_reversa_sdd/reproducao-youtube/requirements.md`, `_reversa_sdd/reproducao-youtube/design.md`, `_reversa_sdd/reproducao-youtube/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Integração de vídeos do YouTube com validação de link e player embutido na exibição e edição de letras.
**Pronto quando:** Links do YouTube são validados com sucesso e os vídeos são reproduzidos corretamente embutidos no aplicativo.

---

### Tarefa 07 — Sincronização Offline
**Status:** done
**Lê:** `_reversa_sdd/sincronizacao-offline/requirements.md`, `_reversa_sdd/sincronizacao-offline/design.md`, `_reversa_sdd/sincronizacao-offline/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Classe de repositório de sincronização (`SyncRepository`), gerenciamento local do SQLite, controle de push/pull com Supabase, e conciliação por campo (`SyncMerge`).
**Pronto quando:** Dados locais alterados offline são mesclados por campo com o servidor Supabase sem conflitos destrutivos, e novos conteúdos remotos são baixados automaticamente.

---

### Tarefa 08 — Acervo e Categorias
**Status:** done
**Lê:** `_reversa_sdd/acervo-categorias/requirements.md`, `_reversa_sdd/acervo-categorias/design.md`, `_reversa_sdd/acervo-categorias/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Modelos de Categoria e Letra, telas de home e categorias, listagem ordenada e filtros.
**Pronto quando:** Categorias e letras são listadas a partir do SQLite, respeitando soft delete, ordenação sequencial e contagem de itens por categoria.

---

### Tarefa 09 — Busca
**Status:** done
**Lê:** `_reversa_sdd/busca/requirements.md`, `_reversa_sdd/busca/design.md`, `_reversa_sdd/busca/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Tela de busca local, queries otimizadas por título e conteúdo sobre a base local.
**Pronto quando:** A busca retorna resultados precisos e instantâneos para termos buscados em títulos ou conteúdos de letras offline.

---

### Tarefa 10 — Reprodução de Áudio
**Status:** done
**Lê:** `_reversa_sdd/reproducao-audio/requirements.md`, `_reversa_sdd/reproducao-audio/design.md`, `_reversa_sdd/reproducao-audio/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Serviço de áudio (`AudioPlayerService`), reprodução em background, controle de playlist, e cache de download de áudio do Supabase Storage.
**Pronto quando:** Arquivos de áudio (priorizando locais se existirem) tocam continuamente, inclusive em segundo plano com controle de notificação nativa.

---

### Tarefa 11 — Favoritos
**Status:** done
**Lê:** `_reversa_sdd/favoritos/requirements.md`, `_reversa_sdd/favoritos/design.md`, `_reversa_sdd/favoritos/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Serviço de controle local de favoritos e tela correspondente.
**Pronto quando:** O usuário consegue favoritar letras e vê-las na tela de favoritos de forma offline, sem sincronização remota obrigatória.

---

### Tarefa 12 — Visualização de Letra
**Status:** done
**Lê:** `_reversa_sdd/visualizacao-letra/requirements.md`, `_reversa_sdd/visualizacao-letra/design.md`, `_reversa_sdd/visualizacao-letra/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Tela `LyricViewScreen`, integração de player de áudio, vídeo, opção de favoritar, e controle de permissões por perfil.
**Pronto quando:** Letras de pontos são apresentadas com seus respectivos players de áudio/YouTube, e ações de mutação (edição) são exibidas apenas aos perfis autorizados.

---

### Tarefa 13 — Edição e Criação de Letra
**Status:** done
**Lê:** `_reversa_sdd/edicao-letra/requirements.md`, `_reversa_sdd/edicao-letra/design.md`, `_reversa_sdd/edicao-letra/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Tela de formulário de letras (`LyricFormScreen`), upload de arquivos de áudio ao Supabase Storage, atribuição de sequencial.
**Pronto quando:** Usuários autorizados criam e editam letras, enviando arquivos de áudio novos ao Storage e atualizando o banco SQLite e Supabase.

---

### Tarefa 14 — Administração
**Status:** done
**Lê:** `_reversa_sdd/administracao/requirements.md`, `_reversa_sdd/administracao/design.md`, `_reversa_sdd/administracao/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Painel do administrador, auditoria de logs, gerência de status de usuários (`is_active`).
**Pronto quando:** Administradores conseguem ver logs de auditoria e gerenciar a ativação de usuários, e usuários desativados são impedidos de interagir.
**Alerta:** ~~⚠️ G-09 (AdminScreen sem guard de role)~~ (Resolvido)

---

### Tarefa 15 — Release e Update
**Status:** done
**Lê:** `_reversa_sdd/release-update/requirements.md`, `_reversa_sdd/release-update/design.md`, `_reversa_sdd/release-update/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Serviço de update via API do GitHub Releases, dialog de atualização na home do app.
**Pronto quando:** O app detecta versões novas lançadas no GitHub e redireciona o usuário para o download da APK oficial.
**Alerta:** ~~⚠️ G-14 (SHA256 no update)~~ (Resolvido)

---

### Tarefa 16 — Estatísticas de Mais Tocados
**Status:** done
**Lê:** `_reversa_sdd/estatisticas-mais-tocados/requirements.md`, `_reversa_sdd/estatisticas-mais-tocados/design.md`, `_reversa_sdd/estatisticas-mais-tocados/tasks.md`, `_reversa_sdd/dependencies.md`
**Constrói:** Incremento local e remoto de contagem de reproduções, tela de listagem de mais tocados, e fallback RPC.
**Pronto quando:** Reproduções completas de áudios são contabilizadas e ordenadas na tela de estatísticas, sincronizando as contagens com o servidor remoto.

---

### Tarefa 17 — Camada de API
**Status:** done
**Lê:** `_reversa_sdd/openapi/supabase-consumed-surfaces.md`
**Constrói:** endpoints, controllers, middlewares, autenticação, RLS policies
**Pronto quando:** Todos os endpoints e queries respondem conforme os contratos OpenAPI / Supabase consumidos

---

### Tarefa 18 — Fluxos de Usuário
**Status:** done
**Lê:** `_reversa_sdd/user-stories/jornadas-principais.md`
**Constrói:** integração end-to-end, fluxos completos de usuário
**Pronto quando:** Todos os critérios de aceitação das user stories e jornadas estão satisfeitos
