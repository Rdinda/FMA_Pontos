# C4 Contexto — FMA_Pontos

```mermaid
flowchart TD
  U1["Usuário leitor/estudante"] -->|"consulta, busca, reproduz"| S["FMA_Pontos App"]
  U2["Usuário autenticado"] -->|"adiciona letras"| S
  U3["Moderador"] -->|"edita acervo"| S
  U4["Administrador"] -->|"gerencia roles, exclusões e logs"| S

  S -->|"Auth SDK / HTTPS"| A["Supabase Auth"]
  S -->|"PostgREST / HTTPS"| P["Supabase Postgres"]
  S -->|"Storage SDK / HTTPS"| ST["Supabase Storage"]
  S -->|"Realtime channel"| RT["Supabase Realtime"]
  S -->|"OAuth token"| G["Google Sign-In"]
  S -->|"embed/player"| Y["YouTube"]
  S -->|"REST releases/latest"| GH["GitHub Releases API"]

  CI["GitHub Actions"] -->|"publica APK"| GH
  Dev["Mantenedor"] -->|"tag v* / secrets"| CI
```

## Relações

- 🟢 **CONFIRMADO** — Leitores usam consulta pública/offline.
- 🟢 **CONFIRMADO** — Usuários logados via Google podem receber role e criar conteúdo conforme RBAC.
- 🟢 **CONFIRMADO** — Supabase concentra dados, auth, storage e realtime.
- 🟢 **CONFIRMADO** — GitHub Releases distribui APK e informa updates.

