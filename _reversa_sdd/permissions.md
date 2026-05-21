# Permissões e RBAC — FMA_Pontos

Gerado pelo Reversa Detective em 2026-05-19T02:03:06Z.

## Papéis

| Papel | Descrição | Confiança |
|---|---|---|
| `anonymous` | Usuário com sessão anônima Supabase. Pode consultar, mas não alterar conteúdo. | 🟢 CONFIRMADO |
| `user` | Usuário autenticado comum. Pode adicionar letras e fazer upload de áudio. | 🟢 CONFIRMADO |
| `moderator` | Usuário com permissão editorial. Herda `user`, edita letras/categorias e gerencia upload/update de áudio. | 🟢 CONFIRMADO |
| `admin` | Administrador. Herda `moderator`, exclui conteúdo, gerencia roles/status e acessa admin. | 🟢 CONFIRMADO |

## Hierarquia

```mermaid
flowchart LR
  A["anonymous"] --> B["user"]
  B --> C["moderator"]
  C --> D["admin"]
```

## Matriz de Permissões de UI

| Funcionalidade | anonymous | user | moderator | admin | Evidência |
|---|---:|---:|---:|---:|---|
| Ver categorias/letras | Sim | Sim | Sim | Sim | `HomeScreen`, `CategoryScreen`, policies read |
| Buscar letras | Sim | Sim | Sim | Sim | `SearchScreen` |
| Reproduzir áudio/vídeo | Sim | Sim | Sim | Sim | `LyricViewScreen`, `AudioPlayerService` |
| Favoritar localmente | Sim | Sim | Sim | Sim | `FavoritesService` não depende de auth |
| Adicionar letra | Não | Sim | Sim | Sim | `AuthService.canAddLyrics` |
| Editar letra | Não | Não | Sim | Sim | `AuthService.canEditLyrics` |
| Excluir letra | Não | Não | Não | Sim | `AuthService.canDeleteLyrics` |
| Adicionar categoria | Não | Não | Sim | Sim | `AuthService.canAddCategories` |
| Editar categoria | Não | Não | Sim | Sim | `AuthService.canEditCategories` |
| Excluir categoria | Não | Não | Não | Sim | `AuthService.canDeleteCategories` |
| Acessar área admin | Não | Não | Não | Sim | `AuthService.isAdmin`, bottom sheet |
| Alterar role/status de usuários | Não | Não | Não | Sim | `AdminService`, `AdminScreen` |
| Consultar logs de auditoria | Não | Não | Não | Sim | UI admin; policy precisa validação |

## Matriz de Permissões Supabase

| Recurso | Operação | Papel mínimo | Bloqueia anônimo? | Confiança |
|---|---|---|---:|---|
| `categories` | SELECT | público/autenticado conforme policy | Não | 🟢 CONFIRMADO |
| `categories` | INSERT | `moderator` | Sim | 🟢 CONFIRMADO |
| `categories` | UPDATE | `moderator` | Sim | 🟢 CONFIRMADO |
| `categories` | DELETE | `admin` | Sim | 🟢 CONFIRMADO |
| `lyrics` | SELECT | público/autenticado conforme policy | Não | 🟢 CONFIRMADO |
| `lyrics` | INSERT | `user` | Sim | 🟢 CONFIRMADO |
| `lyrics` | UPDATE | `moderator` | Sim | 🟢 CONFIRMADO |
| `lyrics` | DELETE | `admin` | Sim | 🟢 CONFIRMADO |
| `user_roles` | SELECT própria role | próprio usuário | N/A | 🟢 CONFIRMADO |
| `user_roles` | ALL | `admin` | Sim | 🟢 CONFIRMADO |
| `storage.objects/audio` | SELECT | público | Não | 🟢 CONFIRMADO |
| `storage.objects/audio` | INSERT | `user` | Não explicitamente no policy | 🟢 CONFIRMADO |
| `storage.objects/audio` | UPDATE | `moderator` | Não explicitamente no policy | 🟢 CONFIRMADO |
| `storage.objects/audio` | DELETE | `admin` | Não explicitamente no policy | 🟢 CONFIRMADO |
| `lyric_play_stats` | SELECT/INSERT/UPDATE | usuário autenticado | 🟡 Ver policy final | 🟢 CONFIRMADO |

## Funções de Permissão

🟢 **CONFIRMADO** — O app e SQL implementam a mesma hierarquia:

- `hasRole('user')`: `user`, `moderator`, `admin`
- `hasRole('moderator')`: `moderator`, `admin`
- `hasRole('admin')`: apenas `admin`

## Riscos e Lacunas

- 🟢 **CONFIRMADO** — `is_active = false` deve **bloquear login** (Roberto, 2026-05-20). 🟡 Legado ainda não aplica em `AuthService`/RLS.
- 🔴 **LACUNA** — `audit_logs` é consultado pelo app, mas a criação da tabela/triggers não está clara nos arquivos atuais.
- 🟡 **INFERIDO** — Permissões de UI e banco podem divergir se policies remotas forem alteradas fora do repositório.
- 🟢 **CONFIRMADO** — Apenas usuários **logados (não anônimos)** podem realizar escritas em `categories`/`lyrics` (Roberto, 2026-05-20). Policies `allow anon insert` na migration `20251226192339` **devem ser removidas** — não são intencionais. 🟡 Legado remoto pode ainda tê-las ativas.

