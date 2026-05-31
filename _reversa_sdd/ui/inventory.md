# Inventário de Telas — FMA Pontos (design streaming)

> Documentado pelo **Visor** em **2026-05-31** a partir de **6 screenshots** do novo visual (pós `001-novo-visual-streaming`).
> Rastreabilidade: `lib/screens/*.dart`, `lib/widgets/streaming/*`

---

## Resumo

| # | Tela | Arquivo Flutter | Estado capturado | Screenshot |
|---|------|-----------------|------------------|------------|
| 1 | Home (Início) | `home_screen.dart` | Preenchido — grid categorias + hero | ✅ |
| 2 | Buscar | `search_screen.dart` | Browse categorias (sem query) | ✅ |
| 3 | Categoria (playlist) | `category_screen.dart` | Preenchido — Caboclos, 213 pontos | ✅ |
| 4 | Visualização / Now Playing | `lyric_view_screen.dart` | Sem mídia + sheet de letra | ✅ |
| 5 | Favoritos (Gostei) | `favorites_screen.dart` | Vazio | ✅ |
| 6 | Admin | `admin_screen.dart` | Usuários — 1 admin | ✅ |

**Telas ainda sem screenshot desta rodada:** Splash, Onboarding, Top Tocados, Nova/Editar Letra, Todas as Categorias (`all_categories_screen.dart`), Política de Privacidade, App Info bottom sheet, mini-player com faixa ativa, estados de erro/offline.

**Screenshots legados (2026-05-21):** lista vertical na Home, app bar “Filhos de Maria das Almas” — **substituídos** por este inventário.

---

## Padrões visuais transversais (🟢 confirmado nos 6 captures)

| Token | Valor observado |
|-------|-----------------|
| Fundo | Preto / `#131313` (scaffold escuro) |
| Brand / ativo | Verde `#1DB954` — título “FMA Pontos”, tab ativa, play FAB, badges admin |
| App bar secundária | Título “FMA Pontos” verde bold; seta voltar verde à esquerda |
| Tipografia | Plus Jakarta Sans — títulos bold, corpo cinza claro |
| Cards categoria | Grid 2 colunas, arte ilustrada WebP, label canto inferior, cantos ~12–16dp |
| Bottom nav | 5 itens: Início · Buscar · Top · Gostei · Admin (admin) ou Categoria (+) (não-admin) |
| Bottom nav ativa | Ícone + label verdes |
| Busca | Pill escuro, placeholder “O que você quer ouvir?” |
| Feedback | Toasts `toastification` (não visíveis nos prints) |
| Hero Home | Banner full-width com saudação “Boa {dia/noite}, {nome}” |

---

## 1. Home (Início)

- **Propósito:** Hub com saudação personalizada, destaques de categorias e preview “Mais Tocados”.
- **Estado:** Preenchido — 4 categorias em grid; “Nenhum ponto tocado ainda” em Mais Tocados.
- **Contexto:** Tab **Início** ativa; após Splash/onboarding.
- **Header:** Avatar circular (Google) · “FMA Pontos” verde · sino de notificações (outline).
- **Hero:** Ilustração Preta Velha + “Boa noite, Roberto”.
- **Seção Categorias:** Título + chevron → `AllCategoriesScreen`.
- **Grid:** Caboclos, Pretos Velhos, Ogum, Iemanjá (artes WebP).
- **Seção Mais Tocados:** Chevron → `TopPlayedScreen`; empty state cinza.
- **Nav:** Início (ativo) · Buscar · Top · Gostei · **Admin** (usuário admin).

→ Detalhe: [`screens/home.md`](screens/home.md)

---

## 2. Buscar

- **Propósito:** Pesquisa global + navegação por categorias (browse).
- **Estado:** Sem query — grid “Navegar por todas as categorias”.
- **Contexto:** Tab **Buscar** ativa.
- **App bar:** Voltar · “FMA Pontos” · título página “Buscar”.
- **Campo:** “O que você quer ouvir?” (`StreamingSearchField`).
- **Grid:** `BentoCategoryCard` — Caboclos, Egunitá _ Oroiná, Iansã, Iemanjá, …
- **Nav:** Buscar ativo (verde).

→ Detalhe: [`screens/buscar-letras.md`](screens/buscar-letras.md)

---

## 3. Categoria — Caboclos

- **Propósito:** Playlist da categoria — hero, play all, lista numerada.
- **Estado:** Preenchido — 213 pontos · 639 min; faixas 1–5 visíveis.
- **Contexto:** Tap em card Caboclos (Home ou Buscar).
- **Hero:** Arte Caboclo full-bleed + título “Caboclos” + subtítulo contagem/duração.
- **Ações hero:** Editar · Excluir (moderador/admin) · FAB play verde grande.
- **Lista:** `#` · título · código (`CA00`) · menu ⋮.
- **Nav:** Início · Buscar · Top · Gostei · **Categoria** (editar) · **Letra** (+).

→ Detalhe: [`screens/categoria.md`](screens/categoria.md)

---

## 4. Visualização de Letra (Now Playing)

- **Propósito:** Experiência tipo player — capa, metadados, letra em bottom sheet.
- **Estado:** Sem mídia — placeholder verde com nota musical; “Sem mídia para tocar.”
- **Contexto:** Tap em faixa da categoria (player aberto).
- **Header:** Chevron minimizar · “PLAYLIST” / “Reproduzindo” · menu ⋮.
- **Capa:** Quadrado gradiente verde + ícone nota.
- **Metadados:** Título truncado · categoria · coração (favorito) outline.
- **Sheet letra:** Card escuro arrastável (grabber); estrofes bold + cinza.
- **Nav:** Início ativo (player empilhado na pilha).

→ Detalhe: [`screens/visualizacao-letra.md`](screens/visualizacao-letra.md)

---

## 5. Favoritos (Gostei)

- **Propósito:** Lista local de pontos favoritos.
- **Estado:** Vazio — ícone coração grande, mensagens de empty state.
- **Contexto:** Tab **Gostei** ativa.
- **App bar:** Voltar · “FMA Pontos” central verde.
- **Título:** “Seus Pontos Salvos” + subtítulo contagem favoritos.
- **Empty:** “Nenhum favorito ainda” · “Suas músicas favoritas aparecerão aqui.”
- **Nav:** Gostei ativo (verde).

→ Detalhe: [`screens/favoritos.md`](screens/favoritos.md)

---

## 6. Admin — Painel do Administrador

- **Propósito:** Gestão de usuários (roles, ativo) e auditoria.
- **Estado:** Aba **Usuários** — 1 usuário listado.
- **Contexto:** Tab **Admin** (somente `isAdmin`).
- **App bar:** Voltar · “Painel do Administrador”.
- **Tabs:** Usuários (ativo, sublinhado verde) · Auditoria.
- **Busca:** “Buscar usuário por e-mail…” (`StreamingSearchField`).
- **Card usuário:** Avatar verde · e-mail · badge “Administrador” · menu ⋮.
- **Nav:** Não exibida nesta tela (push full-screen).

→ Detalhe: [`screens/admin.md`](screens/admin.md)

---

## Confiança

- 🟢 **CONFIRMADO** — Layout, cores, labels e bottom nav batem com `StreamingScaffold` / `StreamingNavigation`.
- 🟡 **INFERIDO** — Duração “639 min” agregada no hero; comportamento exato de notificação (sino) não validado no print.
- 🔴 **LACUNA** — Splash, onboarding, Top, formulário letra, player com áudio ativo, toasts, offline.
