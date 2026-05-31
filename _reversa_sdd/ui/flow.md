# Fluxo de Navegação — FMA Pontos

> Gerado pelo Visor · Mermaid

## Fluxo principal (capturado)

```mermaid
flowchart TD
    A[Splash] -->|auth + onboarding OK| B[Home - Acervo]
    A -->|primeiro acesso| O[Onboarding - não capturado]

    B -->|tap categoria| C[Categoria - ex: Caboclos]
    B -->|tab Buscar| D[Buscar Letras]
    B -->|tab Top| T[Top Tocados - não capturado]
    B -->|tab Gostei| F[Favoritos - não capturado]
    B -->|tab Categoria +| CAT[Dialog Nova Categoria - não capturado]

    C -->|tap letra| E[Visualização de Letra]
    C -->|tab Buscar| D
    C -->|tab Letra +| G[Nova Letra]

    D -->|tap resultado| E
    E -->|editar - moderador+| G2[Editar Letra - mesmo form]
    G -->|salvar| C
    G2 -->|salvar| E

    B -->|avatar / info| I[App Info Bottom Sheet - não capturado]
    B -->|pull refresh| B
```

## Bottom navigation — comportamento

```mermaid
flowchart LR
    subgraph HomeScreen["HomeScreen (5 tabs)"]
        H0[Home - index 0]
        H1[Buscar - push SearchScreen]
        H2[Top - push TopPlayedScreen]
        H3[Gostei - push FavoritesScreen]
        H4[Categoria - dialog add category]
    end

    subgraph CategoryScreen["CategoryScreen (3 tabs)"]
        C0[Home - popUntil first]
        C1[Buscar - push SearchScreen]
        C2[Letra - push LyricFormScreen]
    end
```

## Estados da Visualização de Letra

```mermaid
stateDiagram-v2
    [*] --> SemMidia: sem audio e sem YouTube
    [*] --> ComAudio: audioUrl ou localAudioPath
    [*] --> ComYouTube: youtubeLink válido
    SemMidia --> ComAudio: upload / editar
    SemMidia --> ComYouTube: adicionar link
    ComAudio --> Reproduzindo: tap play
    ComYouTube --> EmbedAtivo: player YouTube
```

## Pontos de entrada

| Entrada | Destino |
|---------|---------|
| Cold start | Splash → Home ou Onboarding |
| Deep link | Não observado nos screenshots |
| Notificação | Não observado |

## Pontos de saída

| Origem | Ação |
|--------|------|
| Home | Back duplo → fecha app |
| Qualquer tela empilhada | Back → tela anterior |
