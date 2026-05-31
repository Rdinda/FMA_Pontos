# Requirements: Modernização Visual — Identidade Streaming

> Identificador: `001-novo-visual-streaming`
> Data: `2026-05-21`
> Pasta da extração reversa: `_reversa_sdd/`
> Confidência: 🟢 CONFIRMADO, 🟡 INFERIDO, 🔴 LACUNA / DÚVIDA

## 1. Resumo executivo

Modernizar a interface do app Flutter **Filhos de Maria das Almas** para uma identidade visual **dark streaming** (referência estilo Spotify), usando os mocks Stitch/HTML e PNGs já produzidos em `_reversa_sdd/stitch_screens/` e screenshots por feature (ex.: `_reversa_sdd/administracao/screenshots/Painel_Administrativo_Modernizado.png`).

A entrega é **puramente visual/UX**: cores, tipografia, espaçamentos, componentes, navegação e estados de tela. **Nenhuma** regra de negócio, fluxo de sync, RBAC ou contrato Supabase deve ser alterada.

Público: praticantes e colaboradores que consomem pontos, buscam letras, favoritam e (quando autorizados) administram usuários.

## 2. Contexto a partir do legado

| Fonte | Trecho relevante | Confidência |
|-------|------------------|-------------|
| `_reversa_sdd/ui/inventory.md#Resumo` | Inventário de 6 telas principais mapeadas para `lib/screens/*.dart` | 🟢 |
| `_reversa_sdd/design-system/tokens.md` | Tokens atuais: primária `#6200EE`, Outfit, radius 12, scaffold claro | 🟢 |
| `_reversa_sdd/administracao/design.md#Decisão Arquitetural` | Admin mobile-first; dados só Supabase; gate `isAdmin` | 🟢 |
| `_reversa_sdd/administracao/screenshots/` | Par legado vs modernizado do painel admin | 🟢 |
| `_reversa_sdd/stitch_screens/*.html` | Mocks dark com `primary` verde (`#1DB954` / `#53e076`), Plus Jakarta Sans | 🟢 |
| `_reversa_sdd/architecture.md#componentes` | Bootstrap via `ThemeProvider` + `MaterialApp` em `main.dart` | 🟢 |
| `_reversa_sdd/domain.md` | Regras RBAC, onboarding, favoritos locais — devem permanecer intactas | 🟢 |
| `_reversa_sdd/code-analysis.md#screens` | 11 telas em `lib/screens/` + widgets compartilhados | 🟡 |

### Catálogo visual de referência (golden files)

| Tela | Mock PNG | Mock HTML | Screenshot feature |
|------|----------|-----------|-------------------|
| Home / Acervo | `stitch_screens/Home_Acervo.png` | `Home_Acervo.html` | `acervo-categorias/screenshots/Home_Acervo.png` |
| Categoria | `Categoria_Ogum_1.png`, `Categoria_Ogum_2.png` | `.html` homônimos | `acervo-categorias/screenshots/` |
| Busca | `Busca.png` | `Busca.html` | `busca/screenshots/Busca.png` |
| Visualização / player | `Tocando_Agora_Ogum.png` | `.html` | `reproducao-audio/screenshots/` |
| Nova letra | `Novo_Ponto.png` | `Novo_Ponto.html` | `edicao-letra/screenshots/` |
| Favoritos | `Favoritos.png` | `Favoritos.html` | `favoritos/screenshots/` |
| Mais tocados | `Mais_Tocados.png`, `Mais_Tocados_Premium.png` | `.html` | `estatisticas-mais-tocados/screenshots/` |
| Onboarding | `Onboarding.png`, `Onboarding_Privacidade.png` | `.html` | `onboarding-privacidade/screenshots/` |
| Splash / capa | `Logo_Splash.png`, `Main_Cover.png` | — | `onboarding-privacidade/screenshots/` |
| Admin | `Painel_Administrativo_Modernizado.png` | `Painel_Administrativo_Modernizado.html` | `administracao/screenshots/` |

## 3. Personas e cenários de uso

| Persona | Objetivo | Cenário-chave |
|---------|----------|---------------|
| Praticante | Navegar e ouvir pontos com conforto visual noturno | Abre Home dark, escolhe categoria, lê/letra com mini-player visível |
| Colaborador (user) | Cadastrar letra com formulário legível | Acessa Nova Letra com campos e CTAs no novo padrão |
| Moderador / Admin | Gerir usuários e auditar | Abre Painel Administrativo modernizado, filtra usuários, vê badges de role |
| Visitante anônimo | Consumir acervo antes de login | Percorre telas sem perder hierarquia visual nem CTAs de login |

## 4. Regras de negócio novas ou alteradas

1. **RN-01:** A modernização **não altera** regras RBAC, sync offline-first, favoritos locais, estatísticas remotas nem fluxos de onboarding/privacidade. 🟢
   - Origem no legado: `_reversa_sdd/domain.md`
   - Tipo: nova (restrição de escopo)

2. **RN-02:** Telas administrativas continuam acessíveis **somente** via `AuthService.isAdmin`; apenas layout/componentes mudam. 🟢
   - Origem no legado: `_reversa_sdd/administracao/design.md#Decisão Arquitetural`
   - Tipo: alterada (apresentação)

3. **RN-03:** Identidade visual streaming usa **tema escuro como padrão**; o **tema claro** deve ser **redesenhado com paridade visual completa** (paleta, surfaces, cards e inputs equivalentes ao dark, não apenas tokens legados preservados). Alternância via `ThemeProvider` permanece. 🟢
   - Esclarecimento: sessão 2026-05-21
   - Tipo: nova

4. **RN-04:** Cores de badge de role no admin devem seguir o mock modernizado (Admin verde, Moderador roxo, User cinza, Inativo desaturado) em substituição ao esquema vermelho/amarelo legado. 🟢
   - Origem: `_reversa_sdd/administracao/screenshots/Painel_Administrativo_Modernizado.png`
   - Tipo: alterada (apresentação)

5. **RN-05:** Bottom navigation e mini-player (quando áudio ativo) devem permanecer **persistentes** nas telas onde já existem no legado, apenas reestilizados. 🟢
   - Origem: `_reversa_sdd/ui/flow.md`
   - Tipo: alterada (apresentação)

6. **RN-06:** Tipografia global migra de **Outfit** para **Plus Jakarta Sans** (como nos HTML Stitch); `pubspec.yaml` e `ThemeData` devem refletir a família única na UI. 🟢
   - Esclarecimento: sessão 2026-05-21
   - Tipo: alterada (apresentação)

7. **RN-07:** Entrega em **release única visual** — todas as telas do catálogo Stitch (Must e Should) no mesmo ciclo de implementação, sem faseamento por tela. 🟢
   - Esclarecimento: sessão 2026-05-21
   - Tipo: nova (restrição de escopo)

## 5. Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de aceite | Confidência |
|----|-----------|------------|--------------------|-------------|
| RF-01 | Centralizar tokens do novo tema (cores, tipografia **Plus Jakarta Sans**, radius, elevação) em camada reutilizável (`ThemeData` / extensões / widgets compartilhados), com variantes **dark e light** em paridade | Must | Um único ponto define `primary`, surfaces dark/light e estilos de card/input; telas não duplicam hex hardcoded; `ThemeProvider` expõe ambos os modos redesenhados | 🟢 |
| RF-02 | Aplicar layout modernizado na **Home** conforme `Home_Acervo.png` | Must | Cards de categoria, header e bottom nav visualmente alinhados ao mock (± tolerância 8dp) | 🟢 |
| RF-03 | Aplicar layout modernizado em **CategoryScreen** conforme mocks Ogum | Must | Lista numerada, chips/códigos, play inline e app bar equivalentes ao mock | 🟢 |
| RF-04 | Aplicar layout modernizado em **SearchScreen** conforme `Busca.png` | Must | Campo de busca pill dark, resultados em cards/list tiles no novo padrão | 🟢 |
| RF-05 | Aplicar layout modernizado em **LyricViewScreen** + estados de player conforme `Tocando_Agora_Ogum.png` | Must | Banner sem mídia, tipografia de letra e barra de player mini quando áudio ativo | 🟢 |
| RF-06 | Aplicar layout modernizado em **LyricFormScreen** conforme `Novo_Ponto.png` | Must | Formulário título/áudio/YouTube/letra com inputs e botão salvar no padrão streaming | 🟢 |
| RF-07 | Aplicar layout modernizado em **FavoritesScreen** e **TopPlayedScreen** | Must | Listas, ranks e empty states conforme mocks `Favoritos` e `Mais_Tocados*` | 🟢 |
| RF-08 | Aplicar layout modernizado em **AdminScreen** conforme `Painel_Administrativo_Modernizado.png` | Must | Tabs Usuários/Logs, search pill, cards de usuário, badges, mini-player e bottom nav admin | 🟢 |
| RF-09 | Aplicar layout modernizado em **OnboardingScreen** e **PrivacyPolicyScreen** | Must | Fluxo onboarding/privacidade conforme mocks e screenshots em `onboarding-privacidade/` | 🟢 |
| RF-10 | Atualizar **SplashScreen** com identidade dark/capa (`Logo_Splash`, `Main_Cover`) | Must | Splash não fica tela branca nativa-only; loader e logo alinhados ao novo branding | 🟢 |
| RF-11 | Reestilizar componentes compartilhados (`AppInfoBottomSheet`, `CategoryPlayerWidget`, snackbars) | Must | Componentes usados em ≥2 telas refletem tokens novos sem regressão funcional | 🟢 |
| RF-12 | Documentar delta visual em `_reversa_sdd/design-system/` (tokens atualizados) | Should | Arquivos de design system refletem paleta streaming pós-implementação | 🟡 |
| RF-13 | Manter acessibilidade mínima: contraste WCAG AA para texto primário sobre surfaces dark | Must | Texto principal legível; botões primários com contraste validado manualmente | 🟡 |

## 6. Requisitos Não Funcionais

| Tipo | Requisito | Evidência ou justificativa | Confidência |
|------|-----------|----------------------------|-------------|
| Desempenho | Não degradar tempo de first frame perceptível vs legado | Flutter Impeller; evitar rebuilds desnecessários em listas longas | 🟡 |
| Manutenibilidade | Preferir composição sobre copy-paste de decoration por tela | `_reversa_sdd/design-system/tokens.md` já cataloga tokens | 🟢 |
| Compatibilidade | Android emulador/dispositivo alvo do projeto; iOS secundário se já suportado | `_reversa_sdd/inventory.md` | 🟢 |
| Testabilidade | `flutter analyze` limpo; smoke manual das telas listadas em RF-02–RF-10 | Regra projeto Flutter | 🟢 |
| Observabilidade | Sem novos logs obrigatórios; debugPrint existente preservado | Escopo visual | 🟢 |

## 7. Critérios de Aceitação

```gherkin
Cenário: Home exibe identidade streaming dark
  Dado que o usuário concluiu onboarding
  Quando abre a Home
  Então o fundo é surface escura
  E os cards de categoria usam cantos arredondados e tipografia do novo tema
  E a bottom navigation reflete o mock Home_Acervo.png

Cenário: Admin modernizado preserva RBAC
  Dado um usuário com role admin autenticado
  Quando abre o Painel Administrativo
  Então vê abas Usuários e Logs de Auditoria no layout modernizado
  E badges Admin/Moderador/User seguem cores do mock modernizado
  E usuário não-admin continua sem acesso à tela

Cenário: Busca mantém funcionalidade com novo visual
  Dado a tela Buscar Letras aberta
  Quando digita um termo existente no acervo
  Então resultados aparecem com estilo streaming
  E toque em resultado abre LyricViewScreen sem regressão de conteúdo

Cenário: Player mini visível durante reprodução
  Dado uma letra com áudio disponível
  Quando usuário inicia reprodução e navega para Home
  Então barra mini-player permanece visível acima da bottom nav
  E controles play/pause respondem como no legado

Cenário: Tema claro com paridade visual
  Dado usuário alternou para tema claro no app
  Quando navega Home, Categoria, Busca e Admin
  Então surfaces, cards e inputs seguem o mesmo sistema visual do dark (paleta clara equivalente)
  E nenhum texto fica ilegível por contraste insuficiente (WCAG AA)
```

## 8. Prioridade MoSCoW

| Item | MoSCoW | Justificativa |
|------|--------|---------------|
| RF-01 a RF-11 | Must | Release única: paridade com catálogo Stitch completo (esclarecimento 2026-05-21) |
| RF-12 | Should | Documentação de tokens em `_reversa_sdd/design-system/` |
| RF-13 | Must | Acessibilidade mínima em tema escuro **e** claro |
| RN-03, RN-06, RN-07 | Must | Tema claro redesenhado, Plus Jakarta Sans, entrega única |

## 9. Esclarecimentos

### Sessão 2026-05-21

- **Q:** Entrega em uma única release visual ou fases (Must primeiro; Should depois)?
  **R:** **Release única** — todas as telas do catálogo Stitch (Must e Should) no mesmo ciclo de implementação.

- **Q:** Tema claro deve ser redesenhado com paridade ou dark-only substitui o roxo claro atual?
  **R:** **Dark padrão + tema claro redesenhado** com paridade visual completa; alternância via `ThemeProvider` mantida.

- **Q:** Tipografia global migra de Outfit para Plus Jakarta Sans ou Outfit permanece?
  **R:** **Migrar para Plus Jakarta Sans** conforme mocks Stitch/HTML.

## 10. Lacunas

- Nenhuma `[DÚVIDA]` pendente após esclarecimento de 2026-05-21.
- 🟡 Paridade do tema claro sem mock Stitch dedicado: derivar tokens light espelhando o dark (validação manual em RF-02–RF-10).

## 11. Histórico de alterações

| Data | Alteração | Autor |
|------|-----------|-------|
| 2026-05-21 | Versão inicial gerada por `/reversa-requirements` | reversa |
| 2026-05-21 | `/reversa-clarify`: release única, tema claro com paridade, Plus Jakarta Sans | reversa |
