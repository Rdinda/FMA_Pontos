# Rastreabilidade de Jornadas — FMA_Pontos

Este documento apresenta a matriz de rastreabilidade mapeando cada uma das 8 jornadas principais do usuário (User Stories) aos arquivos de código implementados no módulo de reconstrução.

---

## Matriz de Rastreabilidade

| ID | Jornada (User Story) | Telas (Screens) | Serviços e Regras (Services) |
|---|---|---|---|
| **US-01** | Primeiro acesso e privacidade | [splash_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/splash_screen.dart)<br>[onboarding_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/onboarding_screen.dart)<br>[privacy_policy_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/privacy_policy_screen.dart) | Persistência local do consentimento via `SharedPreferences`. Validação de versão da política na inicialização. |
| **US-02** | Explorar categorias e letras | [home_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/home_screen.dart)<br>[category_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/category_screen.dart)<br>[lyric_view_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/lyric_view_screen.dart) | [db_helper.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/database/db_helper.dart) (leitura e filtragem de categorias/letras no SQLite). [sync_repository.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/sync_repository.dart) (garantia de dados offline). |
| **US-03** | Buscar e favoritar | [search_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/search_screen.dart)<br>[favorites_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/favorites_screen.dart) | [favorites_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/favorites_service.dart) (persistência local de favoritos independente de autenticação). Query com filtro `LIKE` no SQLite. |
| **US-04** | Ouvir áudio e ver ranking | [top_played_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/top_played_screen.dart) | [audio_player_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/audio_player_service.dart) (player em background e playlist). [play_stats_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/play_stats_service.dart) (incremento via RPC Supabase com fallback local, e leitura de ranking). |
| **US-05** | Contribuir com letras (login Google) | [lyric_form_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/lyric_form_screen.dart) | [auth_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/auth_service.dart) (login com Google OAuth via ID Token, tratamento de login anônimo). `SupabaseService.uploadAudio()` para salvar áudios MP3 no Storage. |
| **US-06** | Moderar acervo | [lyric_form_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/lyric_form_screen.dart) | [auth_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/auth_service.dart) (propriedade reativa `canEditLyrics`, baseando os botões na UI na role de `moderator` ou `admin`). |
| **US-07** | Administrar usuários e auditoria | [admin_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/admin_screen.dart) | [admin_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/admin_service.dart) (queries PostgREST para listagem de logs e controle de status de usuários). `AuthService._subscribeToRoleChanges()` (escuta em tempo real via canal PostgreSQL do Supabase). |
| **US-08** | Atualizar o app | [home_screen.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/screens/home_screen.dart) | [update_service.dart](file:///C:/Users/rdinda/.gemini/antigravity/worktrees/FMA_Pontos/reverse-logic-analysis-task/_reversa_sdd/reconstruction/services/update_service.dart) (conexão à API do GitHub Releases para validação de versão e redirecionamento de download). |

---

## Verificação dos Critérios de Aceitação

### US-01 — Primeiro acesso e privacidade
- **Critério 1**: Splash abre onboarding no primeiro acesso -> **Verificado**: `splash_screen.dart` lê `onboarding_completed` do `SharedPreferences`. Se falso, redireciona para `OnboardingScreen`.
- **Critério 2**: Termos marcados e botão pressionado entra na Home -> **Verificado**: `privacy_policy_screen.dart` só ativa o botão "Aceitar e Continuar" com o checkbox selecionado, gravando `privacy_policy_version` e redirecionando para a Home.
- **Critério 3**: Bloqueio se não marcar -> **Verificado**: O botão fica desativado na UI e exibe mensagem informativa.

### US-02 — Explorar categorias e letras
- **Critério 1**: Toque na categoria abre letras ordenadas -> **Verificado**: `CategoryScreen` carrega as letras ordenadas por `category_id` e exibe como listagem.
- **Critério 2**: Funcionamento offline -> **Verificado**: `db_helper.dart` serve todo o acervo a partir do SQLite local sincronizado anteriormente.

### US-03 — Buscar e favoritar
- **Critério 1**: Pesquisa local SQLite -> **Verificado**: `search_screen.dart` consulta localmente usando cláusulas `LIKE` no SQLite do dispositivo.
- **Critério 2**: Favoritos persistentes -> **Verificado**: `favorites_service.dart` persiste IDs de letras no cache local, acessível mesmo após reabrir o app.

### US-04 — Ouvir áudio e ver ranking
- **Critério 1**: Play de música e incremento global -> **Verificado**: `AudioPlayerService` executa áudios e, ao iniciar, dispara o incremento remoto no Supabase via `PlayStatsService.incrementPlayCount()`.
- **Critério 2**: Aba Mais Tocados exibe ranking -> **Verificado**: `TopPlayedScreen` consome a ordenação de plays remotos mesclando com as categorias do SQLite para renderização.

### US-05 — Contribuir com letras (login Google)
- **Critério 1**: Anônimo orientado a fazer login -> **Verificado**: `home_screen.dart` e `lyric_view_screen.dart` exibem SnackBar e navegam para modal de login Google se o usuário for anônimo e tentar adicionar/editar.
- **Critério 2**: Sincronização de nova letra -> **Verificado**: A gravação de letras novas com áudio no formulário envia o arquivo ao storage Supabase e registra a tupla no banco, acionando a sincronização local de retorno.

### US-06 — Moderar acervo
- **Critério 1**: Moderadores veem botão editar -> **Verificado**: `lyric_view_screen.dart` renderiza a barra de edição reativamente verificando `AuthService.canEditLyrics`.
- **Critério 2**: Apenas moderador/admin editam -> **Verificado**: O backend remoto bloqueia escritas via RLS policies em `lyrics` e `categories` se o usuário logado não tiver as roles correspondentes.

### US-07 — Administrar usuários e auditoria
- **Critério 1**: Admins acessam painel -> **Verificado**: `home_screen.dart` habilita o botão/menu de administração no bottom bar de navegação exclusivamente para a role `admin`.
- **Critério 2**: Atualização em tempo real das permissões -> **Verificado**: `AuthService` escuta alterações na tabela `user_roles` via Supabase Realtime, deslogando instantaneamente usuários banidos ou atualizando permissões sem relogin.

### US-08 — Atualizar o app
- **Critério 1**: Dialog de atualização com changelog -> **Verificado**: `home_screen.dart` e `UpdateService` consultam a versão remota e mostram um dialog pop-up com as notas da release.
- **Critério 2**: Botão baixar abre navegador -> **Verificado**: O botão "Atualizar" usa `url_launcher` para direcionar o usuário à URL de download do APK.
