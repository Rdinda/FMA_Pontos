# User Stories — Jornadas Principais

Gerado pelo Reversa Writer em 2026-05-20.  
Formato: Como [persona] / Quero [ação] / Para [valor].

---

## US-01 — Primeiro acesso e privacidade

**Como** visitante na primeira instalação  
**Quero** ver um onboarding curto e aceitar a política de privacidade  
**Para** entender o app e usar o acervo com transparência LGPD  

**Critérios de aceitação:**

- Dado app novo, quando abro pela primeira vez, então vejo 3 telas de onboarding.
- Dado última tela, quando marco o checkbox e toco "Começar a usar", então entro na Home.
- Dado não marquei o checkbox, quando tento concluir, então vejo mensagem pedindo aceite.

**Specs:** `onboarding-privacidade/requirements.md` (RF-01, RF-03, RF-07)

---

## US-02 — Explorar categorias e letras

**Como** membro da comunidade  
**Quero** navegar por categorias e abrir letras  
**Para** estudar pontos nas giras  

**Critérios de aceitação:**

- Dado Home carregada, quando toco uma categoria, então vejo lista de letras ordenadas.
- Dado offline, quando abro o app, então ainda consigo ler conteúdo já sincronizado.

**Specs:** `acervo-categorias/`, `sincronizacao-offline/`

---

## US-03 — Buscar e favoritar

**Como** usuário frequente  
**Quero** buscar letras por texto e marcar favoritos  
**Para** acessar rápido o que mais uso  

**Critérios de aceitação:**

- Dado termo na busca, quando pesquiso, então resultados vêm do SQLite local.
- Dado letra aberta, quando toco o coração, então favorito persiste após fechar o app.

**Specs:** `busca/`, `favoritos/`

---

## US-04 — Ouvir áudio e ver ranking

**Como** usuário  
**Quero** reproduzir áudio e ver os pontos mais tocados  
**Para** praticar com o que a comunidade mais escuta  

**Critérios de aceitação:**

- Dado letra com MP3, quando toco play, então áudio inicia e contador global incrementa.
- Dado aba Mais Tocados, quando lista carrega, então vejo ranking com quantidade de plays.

**Specs:** `reproducao-audio/`, `estatisticas-mais-tocados/`

---

## US-05 — Contribuir com letras (login Google)

**Como** filho de santo cadastrado  
**Quero** entrar com Google e adicionar letras  
**Para** contribuir com o acervo  

**Critérios de aceitação:**

- Dado anônimo, quando tento adicionar letra, então sou orientado a fazer login.
- Dado logado como user, quando adiciono letra com áudio, então conteúdo sincroniza quando online.

**Specs:** `autenticacao/`, `edicao-letra/`

---

## US-06 — Moderar acervo

**Como** moderador  
**Quero** editar letras e categorias  
**Para** manter o acervo organizado  

**Critérios de aceitação:**

- Dado role moderator, quando abro letra, então vejo opção editar.
- Dado role user, quando tento editar letra alheia, então ação não está disponível.

**Specs:** `autenticacao/permissions.md`, `edicao-letra/`, `acervo-categorias/`

---

## US-07 — Administrar usuários e auditoria

**Como** administrador  
**Quero** alterar roles e consultar logs  
**Para** governar quem pode editar o acervo  

**Critérios de aceitação:**

- Dado role admin, quando abro Administração, então vejo usuários e logs.
- Dado altero role de usuário, quando ele está online, então permissões atualizam sem relogin.

**Specs:** `administracao/`, `autenticacao/`

---

## US-08 — Atualizar o app

**Como** usuário Android  
**Quero** ser avisado quando houver versão nova  
**Para** instalar correções e melhorias  

**Critérios de aceitação:**

- Dado release mais nova no GitHub, quando abro Home, então vejo dialog com changelog.
- Dado toco Baixar, então link do APK abre no navegador/downloader.

**Specs:** `release-update/`

---

## Mapa persona × jornada

| Persona | Stories |
|---------|---------|
| Visitante / anônimo | US-01, US-02, US-03 (leitura), US-04 (ouvir) |
| User autenticado | US-05 |
| Moderator | US-06 |
| Admin | US-07 |
| Qualquer (Android) | US-08 |
