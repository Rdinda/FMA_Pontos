# Favoritos — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a marcação local de letras/pontos como favoritos e a tela "Gostei".  
🟢 **CONFIRMADO** — Favoritos são armazenados apenas no dispositivo, em `SharedPreferences`, na chave `favorite_lyrics`.  
🟢 **CONFIRMADO** — A feature não exige autenticação e não sincroniza favoritos com Supabase.

## Responsabilidades

- 🟢 **CONFIRMADO** — Carregar a lista local de IDs favoritos ao inicializar `FavoritesService`.
- 🟢 **CONFIRMADO** — Permitir favoritar e desfavoritar uma letra a partir da visualização da letra.
- 🟢 **CONFIRMADO** — Permitir favoritar e desfavoritar a letra atual a partir do player compacto de categoria.
- 🟢 **CONFIRMADO** — Exibir tela dedicada com todas as letras favoritas encontradas no acervo local.
- 🟢 **CONFIRMADO** — Enriquecer favoritos com nome e código da categoria para exibição.
- 🟢 **CONFIRMADO** — Permitir remover favoritos pela própria lista "Gostei".
- 🟢 **CONFIRMADO** — Permitir tocar todas as favoritas com áudio em uma playlist ordenada por título.
- 🟢 **CONFIRMADO** — Navegar da lista de favoritos para a tela de visualização da letra.

## Regras de Negócio

- 🟢 **CONFIRMADO** — O identificador persistido de cada favorito é o `Lyric.id`.
- 🟢 **CONFIRMADO** — Favoritos são um conjunto lógico; o mesmo ID não deve aparecer duplicado no estado em memória.
- 🟢 **CONFIRMADO** — `toggleFavorite(lyricId)` remove o ID se ele já existe e adiciona se ainda não existe.
- 🟢 **CONFIRMADO** — Alterações em favoritos notificam listeners antes de salvar a lista em `SharedPreferences`.
- 🟢 **CONFIRMADO** — Falha ao carregar favoritos não bloqueia a tela: `isLoaded` é marcado como verdadeiro e o conjunto fica vazio.
- 🟢 **CONFIRMADO** — A tela de favoritos aguarda `FavoritesService.isLoaded` antes de renderizar lista ou estado vazio.
- 🟢 **CONFIRMADO** — IDs favoritos que não correspondem mais a uma letra local são ignorados na montagem da lista.
- 🟢 **CONFIRMADO** — A lista de favoritos exibida é ordenada por `lyric.title`.
- 🟢 **CONFIRMADO** — A ação "Tocar Todas" coleta letras favoritas existentes, ordena por título e chama `AudioPlayerService.playAll`.
- 🟢 **CONFIRMADO** — A feature de favoritos não usa RBAC; usuários anônimos, `user`, `moderator` e `admin` podem favoritar localmente.
- 🟡 **INFERIDO** — Como não há limpeza automática de IDs órfãos, favoritos de letras removidas podem permanecer em `SharedPreferences`, mas não aparecem na tela.

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O sistema deve carregar favoritos locais na inicialização do serviço. | Must | Dado `SharedPreferences.favorite_lyrics`, quando `FavoritesService` é criado, então os IDs são carregados para `_favorites` e `isLoaded` fica verdadeiro. |
| RF-02 | 🟢 O sistema deve informar se uma letra está favoritada. | Must | Dado um `lyricId`, quando `isFavorite(lyricId)` é chamado, então retorna verdadeiro se o ID está no conjunto local. |
| RF-03 | 🟢 O sistema deve alternar favorito por ID de letra. | Must | Dado uma letra não favoritada, quando `toggleFavorite(id)` executa, então o ID é adicionado; dado uma letra favoritada, então o ID é removido. |
| RF-04 | 🟢 O sistema deve persistir alterações de favoritos localmente. | Must | Dado alteração no conjunto de favoritos, quando a operação termina, então `favorite_lyrics` é salvo em `SharedPreferences`. |
| RF-05 | 🟢 O sistema deve atualizar a UI ao alterar favoritos. | Must | Dado uma tela consumindo `FavoritesService`, quando favorito muda, então `notifyListeners()` dispara reconstrução do estado visual. |
| RF-06 | 🟢 O sistema deve exibir botão de favorito na tela de visualização da letra. | Must | Dado `LyricViewScreen`, quando a letra renderiza, então o botão mostra coração preenchido ou contornado conforme `isFavorite`. |
| RF-07 | 🟢 O sistema deve exibir feedback textual ao favoritar ou remover favorito na visualização. | Should | Dado o botão de favorito da visualização, quando pressionado, então aparece snackbar "Adicionado aos favoritos" ou "Removido dos favoritos". |
| RF-08 | 🟢 O sistema deve exibir botão de favorito no player compacto quando há letra atual. | Should | Dado `CategoryPlayerWidget` com `currentLyric`, quando renderizado, então aparece botão de coração sincronizado com `FavoritesService`. |
| RF-09 | 🟢 O sistema deve listar letras favoritas na tela "Gostei". | Must | Dado IDs favoritos que existem no SQLite, quando a tela abre, então cada letra correspondente aparece na lista. |
| RF-10 | 🟢 O sistema deve exibir estado vazio quando não há favoritos. | Must | Dado conjunto local vazio, quando a tela "Gostei" renderiza, então mostra mensagem orientando tocar no coração para adicionar favoritas. |
| RF-11 | 🟢 O sistema deve exibir estado de favoritos não encontrados quando os IDs não correspondem a letras locais. | Should | Dado favoritos órfãos, quando a lista resolve vazia, então mostra "Músicas favoritas não encontradas". |
| RF-12 | 🟢 O sistema deve ordenar favoritos por título. | Should | Dado múltiplas letras favoritas, quando exibidas ou tocadas em lote, então a ordem é `title ASC`. |
| RF-13 | 🟢 O sistema deve remover favorito pela tela "Gostei". | Must | Dado uma letra favorita listada, quando o usuário toca no coração preenchido, então o ID é removido e aparece snackbar de remoção. |
| RF-14 | 🟢 O sistema deve navegar para a visualização da letra ao tocar em um favorito. | Must | Dado item favorito na lista, quando o usuário toca no item, então navega para `LyricViewScreen(lyric)`. |
| RF-15 | 🟢 O sistema deve tocar todas as favoritas existentes quando houver favoritos. | Should | Dado favoritos válidos, quando o usuário toca em "Tocar Todas", então `AudioPlayerService.playAll(favoriteLyrics)` é chamado. |

## Requisitos Não Funcionais

| Tipo | Requisito inferido | Evidência no código | Confiança |
|------|--------------------|---------------------|-----------|
| Operação offline | Favoritos devem funcionar sem rede, pois dependem apenas de armazenamento local e SQLite. | `lib/services/favorites_service.dart`, `lib/screens/favorites_screen.dart` | 🟢 |
| Privacidade | Favoritos não devem ser enviados ao Supabase no comportamento legado. | Ausência de integração remota em `FavoritesService`; domínio indica favoritos locais | 🟢 |
| Resiliência | Falha de leitura/escrita em `SharedPreferences` não deve derrubar a UI. | `try/catch` em `_loadFavorites` e `_saveFavorites` | 🟢 |
| Consistência visual | Ícones de coração devem refletir imediatamente o estado em memória. | `ChangeNotifier`, `Consumer<FavoritesService>` | 🟢 |
| Integridade local | IDs órfãos não devem aparecer como letras válidas na lista. | `_getFavoriteLyricsWithCategory` ignora `repo.getLyric(id) == null` | 🟢 |

## Critérios de Aceitação

```gherkin
Dado que uma letra não está nos favoritos locais
Quando o usuário toca no coração da tela de visualização
Então o ID da letra deve ser adicionado em favorite_lyrics
E o ícone deve mudar para coração preenchido

Dado que uma letra já está nos favoritos locais
Quando o usuário toca no coração da tela de visualização
Então o ID da letra deve ser removido de favorite_lyrics
E o sistema deve exibir feedback de remoção

Dado que existem letras favoritas no acervo local
Quando o usuário abre a tela Gostei
Então o sistema deve listar as letras favoritas ordenadas por título
E deve mostrar código e nome da categoria quando disponíveis

Dado que não existem favoritos locais
Quando o usuário abre a tela Gostei
Então o sistema deve exibir o estado vazio de favoritos

Dado que há IDs favoritos salvos mas suas letras não existem mais localmente
Quando a tela Gostei monta a lista
Então esses IDs devem ser ignorados
E a tela deve informar que músicas favoritas não foram encontradas se nenhuma letra restar

Dado que há letras favoritas válidas
Quando o usuário aciona Tocar Todas
Então o sistema deve montar uma playlist com as letras favoritas ordenadas por título
E iniciar a reprodução via AudioPlayerService
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Persistir favoritos locais | Must | 🟢 Núcleo da feature "Gostei". |
| Alternar favorito na visualização | Must | 🟢 Principal ponto de entrada da ação. |
| Listar favoritos | Must | 🟢 Valor central da tela dedicada. |
| Remover favorito pela lista | Must | 🟢 Necessário para gestão básica da coleção local. |
| Navegar para detalhe | Must | 🟢 Favorito precisa levar ao consumo completo da letra. |
| Tocar todas favoritas | Should | 🟢 Recurso importante de mídia, mas a lista continua útil sem ele. |
| Favoritar pelo player compacto | Should | 🟢 Atalho contextual útil durante reprodução. |
| Sincronizar favoritos entre dispositivos | Won't | 🟢 O legado mantém favoritos apenas locais. |
| Exigir login para favoritar | Won't | 🟢 Favoritar é permitido localmente sem autenticação. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/favorites_service.dart` | `FavoritesService`, `_loadFavorites`, `_saveFavorites`, `isFavorite`, `toggleFavorite`, `addFavorite`, `removeFavorite`, `clearAll` | 🟢 |
| `lib/screens/favorites_screen.dart` | `FavoritesScreen`, `_playAllFavorites`, `_getFavoriteLyricsWithCategory` | 🟢 |
| `lib/screens/lyric_view_screen.dart` | botão de favorito em `LyricViewScreen` | 🟢 |
| `lib/widgets/category_player_widget.dart` | botão de favorito do player compacto | 🟢 |
| `lib/services/sync_repository.dart` | `getLyric`, `getCategories` usados para resolver favoritos | 🟢 |
| `lib/services/audio_player_service.dart` | `play`, `playAll`, estado de reprodução na lista | 🟢 |
| `lib/screens/home_screen.dart` | navegação para `FavoritesScreen` | 🟢 |
| `_reversa_sdd/data-dictionary.md` | chave `favorite_lyrics` em `SharedPreferences` | 🟢 |
| `_reversa_sdd/permissions.md` | favoritar localmente permitido para todos os perfis | 🟢 |

