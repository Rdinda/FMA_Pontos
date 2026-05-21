# Spec Impact Matrix — FMA_Pontos

Gerado pelo Reversa Architect em 2026-05-19T02:08:00Z.

> Contrato normativo: [`../architecture-contract.md`](../architecture-contract.md)

| Feature / Spec futura | Screens | Services | Models | SQLite | Supabase | Storage | Auth/RBAC | Tests | Observações |
|---|---|---|---|---|---|---|---|---|---|
| Acervo e categorias | `home_screen`, `category_screen` | `SyncRepository`, `DatabaseHelper`, `SupabaseService` | `Category`, `Lyric` | `categories`, `lyrics` | `categories`, `lyrics` | Não | Moderator/admin para manutenção | Baixa | Impacta listagem, ordem e contagem. |
| Busca | `search_screen` | `SyncRepository`, `DatabaseHelper` | `Lyric` | `lyrics` | Indireto via sync | Não | Não | Ausente | Busca é local por título/conteúdo. |
| Favoritos | `favorites_screen`, `lyric_view_screen` | `FavoritesService`, `SyncRepository` | `Lyric` | Leitura de lyrics | Não | Não | Não | Ausente | Estado local não sincronizado. |
| Visualização de letra | `lyric_view_screen` | `SyncRepository`, `AudioPlayerService`, `FavoritesService` | `Lyric`, `Category` | `lyrics`, `categories` | Indireto via sync/stats | Sim | Edit/delete por role | Parcial | Concentra áudio, vídeo, favoritos e permissões. |
| Edição/criação de letra | `lyric_form_screen` | `SyncRepository`, `SupabaseService`, `DatabaseHelper` | `Lyric` | `lyrics` | `lyrics` | Upload/delete áudio | user/moderator/admin | Parcial em model | Valida YouTube e gera sequência. |
| Reprodução de áudio | `lyric_view_screen`, `category_player_widget`, listas | `AudioPlayerService`, `PlayStatsService`, `SyncRepository` | `Lyric`, `LyricPlayStats` | `lyrics` | `lyric_play_stats` | `audio` | Não para tocar; user para upload | Ausente | Prioriza local path. |
| Reprodução YouTube | `lyric_view_screen`, `lyric_form_screen` | Não central | `Lyric` | `youtube_link` | `youtube_link` | Não | Edição por role | Parcial | Link externo. |
| Sincronização offline | Splash/Home refresh/listas | `SyncRepository`, `DatabaseHelper`, `SupabaseService` | `Category`, `Lyric` | flags sync/delete | updated_at/is_deleted | download áudio | Mutação por role | Ausente | Área de maior risco. |
| Autenticação | Splash, bottom sheet | `AuthService` | `UserInfo` | Não | `user_roles` | Não | Central | Ausente | Inclui Google e sessão anônima. |
| Administração | `admin_screen`, bottom sheet | `AdminService`, `AuthService` | `UserInfo`, `AuditLog` | Não | `user_roles`, `audit_logs` | Não | admin | Ausente | Sem cache local (contrato R-03). |
| Estatísticas de mais tocados | `top_played_screen` | `PlayStatsService`, `AudioPlayerService`, `DatabaseHelper` | `LyricPlayStats`, `LyricWithStats` | Leitura de lyrics/categories | `lyric_play_stats`, RPC | Não | Não | Ausente | RPC em migration 20260519; fallback client válido. |
| Onboarding e privacidade | `onboarding_screen`, `privacy_policy_screen`, `splash_screen` | SharedPreferences direto | Não | Não | Não | Não | Não | Ausente | Gate local por aceite. |
| Release/update | Home update dialog | `UpdateService` | `UpdateInfo` | Não | Não | Não | Não | Ausente | Depende de GitHub API e Actions. |

## Componentes de maior impacto

- `SyncRepository`: impacta acervo, edição, sync, áudio offline e conflitos.
- `AuthService`: impacta qualquer ação protegida.
- `DatabaseHelper`: impacta schema local, consultas, ordenação e migrações.
- `SupabaseService`: impacta contrato remoto e storage.
- `Lyric`: impacta praticamente todas as features.

## Lacunas para priorizar em specs

- 🔴 Confirmar schema/trigger de `audit_logs`.
- 🔴 Confirmar RPC `increment_play_count`.
- 🔴 Especificar conflito de sync.
- 🔴 Definir comportamento de usuário desativado.

