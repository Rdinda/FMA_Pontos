# Inventário de Telas — FMA Pontos

> Documentado pelo **Visor** em 2026-05-21 a partir de 6 screenshots.
> Rastreabilidade: `lib/screens/*.dart`

---

## Resumo

| # | Tela | Arquivo Flutter | Estado capturado | Prioridade |
|---|------|-----------------|------------------|------------|
| 1 | Splash | `splash_screen.dart` | Carregando | Alta |
| 2 | Home (Acervo) | `home_screen.dart` | Preenchido | Alta |
| 3 | Categoria | `category_screen.dart` | Preenchido (Caboclos) | Alta |
| 4 | Visualização de Letra | `lyric_view_screen.dart` | Preenchido, sem mídia | Alta |
| 5 | Buscar Letras | `search_screen.dart` | Vazio (inicial) | Alta |
| 6 | Nova Letra | `lyric_form_screen.dart` | Formulário vazio | Média |

**Telas não capturadas** (existem no código): Onboarding, Favoritos, Top Tocados, Admin, Política de Privacidade.

---

## 1. Splash

- **Propósito:** Tela inicial enquanto o app solicita permissões, autentica (sessão anônima/Google) e decide rota (Home vs Onboarding).
- **Estado:** Carregando — logo centralizado, fundo branco; versão no canto inferior direito (quando carregada).
- **Contexto:** Entry point após `main()` → `MaterialApp.home`.
- **Elementos visíveis (screenshot):** Logo circular “Filhos de Maria das Almas” (estrela + taça), fundo branco limpo.
- **Elementos esperados (código):** `CupertinoActivityIndicator`, texto “Carregando…”, barra de progresso se sync em download.

---

## 2. Home — Acervo de Categorias

- **Propósito:** Hub principal — lista categorias de pontos (Orixás, linhas, etc.) com contagem.
- **Estado:** Preenchido — 8+ categorias visíveis com ícones coloridos.
- **Contexto:** Após Splash + onboarding concluído; tab **Home** ativa.
- **App bar:** Título “Filhos de Maria das Almas”, avatar do usuário (Google) à direita.
- **Lista:** Cards arredondados — ícone musical colorido, nome da categoria, “N pontos”, chevron.
- **Bottom nav:** Home · Buscar · Top · Gostei · Categoria (+).

---

## 3. Categoria — Caboclos

- **Propósito:** Lista letras/pontos de uma categoria; reprodução rápida e navegação para detalhe.
- **Estado:** Preenchido — 213 pontos (Home), lista numerada CA01–CA08 visível.
- **Contexto:** Tap em card “Caboclos” na Home.
- **App bar:** Voltar, título “Caboclos”, ícone play (playlist da categoria).
- **Lista:** Número sequencial, título truncado, código `CA##`, chevron; play inline se houver áudio.
- **Bottom nav:** Home · Buscar · Letra (+) — subset da nav da Home.

---

## 4. Visualização de Letra

- **Propósito:** Ler letra completa; ouvir MP3 ou assistir YouTube quando disponível.
- **Estado:** Preenchido sem mídia — alerta informativo + texto da letra.
- **Contexto:** Tap em item da lista de categoria ou resultado de busca.
- **App bar:** Voltar, título “CA01 - CABOCLO 7 FLECHAS …” (código + título).
- **Alerta:** Banner roxo claro — “Sem mídia para tocar. Adicione um arquivo de áudio MP3 ou um link do YouTube.”
- **Conteúdo:** Card com letra em texto corrido (fonte Outfit).

---

## 5. Buscar Letras

- **Propósito:** Pesquisa global por nome ou trecho de letra.
- **Estado:** Vazio — campo de busca sem query, área de resultados em branco.
- **Contexto:** Tab **Buscar** na bottom nav (Home ou Categoria).
- **App bar:** Voltar, título “Buscar Letras”.
- **Campo:** Placeholder “Pesquisar por nome ou trecho”, ícone lupa.

---

## 6. Nova Letra

- **Propósito:** Criar (ou editar) ponto/letra em uma categoria.
- **Estado:** Formulário vazio — modo criação.
- **Contexto:** Tab **Letra** (+) na CategoryScreen (requer permissão `user+`).
- **App bar:** Voltar, título “Nova Letra”, ícone salvar (check).
- **Campos:** Título · Anexar áudio (estado “Nenhum áudio selecionado”) · Link do YouTube · Letra (multilinha).

---

## Padrões visuais transversais

| Token | Valor observado |
|-------|-----------------|
| Cor primária | Roxo (`#6200EE` no código) |
| App bar | Roxo sólido, texto branco, título bold |
| Cards | Fundo branco/superfície clara, cantos arredondados (~12px) |
| Tipografia | Outfit (Google Fonts) |
| Ícones nav | Material — casa, lupa, trending, coração, plus |
| Feedback | Snackbars (código); banners informativos na visualização |

---

## Confiança

- 🟢 **CONFIRMADO** — layout e labels visíveis nos screenshots batem com widgets em `lib/screens/`.
- 🟡 **INFERIDO** — estados de erro, offline e loading não foram capturados.
- 🔴 **LACUNA** — Onboarding, Favoritos, Top, Admin, player com áudio/YouTube ativo.
