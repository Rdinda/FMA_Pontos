# Fluxo de Navegação — FMA Pontos (design streaming)

> Gerado pelo Visor · 2026-05-31 · 6 screenshots do novo visual

## Fluxo principal (capturado)

```mermaid
flowchart TD
    SPLASH[Splash - não capturado] --> HOME[Home - Início]
    SPLASH --> ONB[Onboarding - não capturado]

    HOME -->|chevron Categorias| ALL[AllCategoriesScreen - não capturado]
    HOME -->|card categoria| CAT[Categoria - playlist]
    HOME -->|tab Buscar| SRCH[Buscar]
    HOME -->|tab Top| TOP[Top Tocados - não capturado]
    HOME -->|tab Gostei| FAV[Favoritos]
    HOME -->|tab Admin| ADM[Admin - Usuários]

    SRCH -->|card categoria| CAT
    SRCH -->|resultado busca| LYR[Visualização / Now Playing]

    CAT -->|tap faixa| LYR
    CAT -->|tab Letra +| FORM[Nova Letra - não capturado]

    FAV -->|item com áudio| LYR
    TOP --> LYR

    LYR -->|chevron| CAT
    ADM -->|tab Auditoria| ADM2[Admin - Logs - não capturado]
```

## Bottom navigation — por contexto

```mermaid
flowchart TB
    subgraph homeCtx["StreamingNavContext.home"]
        H0[0 Início - ativo]
        H1[1 Buscar → SearchScreen]
        H2[2 Top → TopPlayedScreen]
        H3[3 Gostei → FavoritesScreen]
        H4a[4 Admin → AdminScreen se isAdmin]
        H4b[4 Categoria → dialog add se moderador+]
    end

    subgraph catCtx["StreamingNavContext.category"]
        C0[0 Início → popUntil first]
        C1[1 Buscar]
        C2[2 Top]
        C3[3 Gostei]
        C4[4 Categoria → editar]
        C5[5 Letra → LyricFormScreen]
    end

    subgraph stdCtx["StreamingNavContext.standard"]
        S0[0 Início]
        S1[1 Buscar]
        S2[2 Top]
        S3[3 Gostei]
        S4[4 Admin se isAdmin]
    end
```

**Observação (screenshot Home):** usuário admin vê 5º slot **Admin** em vez de **Categoria (+)**.

## Estados da Visualização de Letra

```mermaid
stateDiagram-v2
    [*] --> SemMidia: sem audio e sem YouTube
    [*] --> ComAudio: audioUrl ou local path
    [*] --> ComYouTube: youtubeLink válido
    SemMidia --> ComAudio: upload / sync
    ComAudio --> Reproduzindo: play FAB / lista
    Reproduzindo --> SheetLetra: bottom sheet expandido
    ComYouTube --> EmbedAtivo: player YouTube
```

## Admin — subfluxo

```mermaid
flowchart LR
    A[AdminScreen] --> T1[Aba Usuários]
    A --> T2[Aba Auditoria]
    T1 --> S[Busca por e-mail]
    T1 --> M[Menu ⋮ por usuário]
    M --> R[Alterar role / ativo]
```

## Pontos de entrada

| Entrada | Destino |
|---------|---------|
| Cold start | Splash → Home ou Onboarding |
| Tab Início (qualquer tela) | `popUntil` primeira rota (= Home) |
| Deep link | Não observado |

## Pontos de saída

| Origem | Ação |
|--------|------|
| Home | Back duplo → fecha app (código) |
| Telas empilhadas | Seta voltar verde → pop |
| LyricView | Chevron superior → pop (minimizar player) |
