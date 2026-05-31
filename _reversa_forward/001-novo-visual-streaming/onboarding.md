# Onboarding de teste: 001-novo-visual-streaming

> Guia para validar a modernização visual pela primeira vez.
> Data: `2026-05-21`

## Pré-requisitos

1. Flutter SDK compatível com `sdk: ^3.10.4` (`flutter doctor`).
2. `dart_defines.json` configurado (copiar de `dart_defines.example.json` com `SUPABASE_URL` e `SUPABASE_ANON_KEY`).
3. Emulador Android ou dispositivo físico.
4. Golden files abertos para comparação side-by-side:
   - `_reversa_sdd/stitch_screens/Home_Acervo.png`
   - `_reversa_sdd/stitch_screens/Busca.png`
   - `_reversa_sdd/administracao/screenshots/Painel_Administrativo_Modernizado.png`

## Como rodar

```powershell
cd c:\Users\rdinda\Documents\GitHub\FMA_Pontos
.\run-dev.ps1
```

Ou:

```powershell
flutter run --dart-define-from-file=dart_defines.json
```

## Checklist de smoke (release única)

### Fundação visual

- [ ] App abre em **tema escuro** (first install ou após reset prefs).
- [ ] Cor accent verde visível (botões, loader, tab ativa) — não roxo `#6200EE`.
- [ ] Tipografia Plus Jakarta Sans perceptível (títulos arredondados vs Outfit anterior).

### RF-10 Splash

- [ ] Splash Flutter com fundo escuro e logo (não tela branca prolongada após engine sobe).
- [ ] Loader verde durante sync inicial.

### RF-02 Home

- [ ] Cards de categoria com cantos arredondados sobre surface escura.
- [ ] Bottom navigation com item ativo destacado em verde.
- [ ] Comparar layout com `Home_Acervo.png` (±8dp tolerável).

### RF-03 Category

- [ ] Abrir uma categoria (ex.: Ogum).
- [ ] Lista numerada, chips/códigos legíveis.
- [ ] Play inline funciona (áudio inicia).

### RF-04 Search

- [ ] Menu Buscar → campo pill escuro.
- [ ] Digitar termo existente → resultados estilizados.
- [ ] Toque abre letra sem perda de conteúdo.

### RF-05 Lyric view + player

- [ ] Letra legível em card escuro.
- [ ] Reproduzir áudio → mini-player visível.
- [ ] Voltar à Home → mini-player **permanece** acima da bottom nav.
- [ ] Play/pause respondem.

### RF-06 Lyric form (login moderador+)

- [ ] Formulário Nova Letra com inputs e botão salvar no padrão streaming.
- [ ] File picker e campos YouTube intactos funcionalmente.

### RF-07 Favorites + Top played

- [ ] Favoritos: lista ou empty state estilizado.
- [ ] Mais tocados: ranks (ouro/prata/bronze) visíveis.

### RF-08 Admin (conta admin)

- [ ] Painel acessível só para admin.
- [ ] Tabs Usuários / Logs.
- [ ] Badges: Admin **verde**, Moderador roxo, User cinza.
- [ ] Usuário não-admin **não** acessa tela.

### RF-09 Onboarding + Privacy

- [ ] Reset onboarding (limpar prefs ou reinstalar) → fluxo visual modernizado.
- [ ] Tela privacidade legível.

### RF-11 Componentes compartilhados

- [ ] Sheet "Sobre o app" (`AppInfoBottomSheet`) com toggle de tema.
- [ ] Snackbars success/error com novo esquema de cores.

### RF-13 Tema claro

- [ ] Em App Info → alternar para **Claro**.
- [ ] Navegar Home, Categoria, Busca, Admin.
- [ ] Nenhum texto ilegível; cards/inputs com paridade visual (surfaces claras).

### Regressão funcional (não-visual)

- [ ] Sync offline/online ainda funciona (wifi on/off icon na Home).
- [ ] Login Google inalterado.
- [ ] Favoritar/desfavoritar funciona.
- [ ] `flutter analyze` limpo.

## Reset útil para reteste

```powershell
# Limpar prefs no emulador (Android)
adb shell pm clear com.example.pontos
```

(Ajuste o applicationId conforme `android/app/build.gradle`.)

## Critério de aprovação humana

Todos os itens Must (RF-01–RF-11, RF-13) marcados antes de merge do PR da release única.
