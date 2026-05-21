# Release e Atualização — Requirements

## Visão Geral

🟢 **CONFIRMADO** — Esta unit cobre a verificação de novas versões do app Android via **GitHub Releases API**, comparação semântica de versão com o binário instalado e diálogo na Home para download do APK.  
🟢 **CONFIRMADO** — Pipeline CI em `.github/workflows/release-app.yml` publica APK assinado (quando secrets configurados) ao push de tag `v*`.  
🟢 **CONFIRMADO** — Versão instalada lida de `package_info_plus` (`pubspec.yaml` → `version`).  
🟡 **INFERIDO** — Fluxo voltado a **Android sideload**; não há update in-app store nem caminho iOS.  
🟡 **INFERIDO** — Falha na checagem é silenciosa para o usuário (retorna `null`, apenas log).

## Responsabilidades

- 🟢 **CONFIRMADO** — Consultar `GET /repos/Rdinda/FMA_Pontos/releases/latest` na abertura da Home.
- 🟢 **CONFIRMADO** — Comparar versão atual vs `tag_name` (strip prefixo `v`).
- 🟢 **CONFIRMADO** — Se houver update, retornar `UpdateInfo` com versão, URL de download e changelog (`body`).
- 🟢 **CONFIRMADO** — Preferir asset `.apk` em `assets[]`; fallback para `html_url` da release.
- 🟢 **CONFIRMADO** — Exibir `AlertDialog` não dispensável por toque fora (`barrierDismissible: false`) com opções Depois e Baixar.
- 🟢 **CONFIRMADO** — Abrir URL de download com `url_launcher` em modo externo.
- 🟢 **CONFIRMADO** — CI: build `flutter build apk --release` com `--dart-define` Supabase; anexar `FMA-Pontos-{tag}.apk` à release.

## Regras de Negócio

- 🟢 **CONFIRMADO** — Checagem dispara no primeiro frame após `HomeScreen` montar (junto com `syncData`).
- 🟢 **CONFIRMADO** — Diálogo só aparece se `updateInfo != null && hasUpdate && mounted`.
- 🟢 **CONFIRMADO** — Comparação numérica por segmentos `major.minor.patch` (até 3 partes).
- 🟢 **CONFIRMADO** — Se segmentos iguais em 3 posições, `hasUpdate = false`.
- 🟢 **CONFIRMADO** — Erro de parse de versão → `hasUpdate = false` (log warning).
- 🟢 **CONFIRMADO** — Status HTTP != 200 → sem update (log warning).
- 🟢 **CONFIRMADO** — Exceções de rede/API → `null`, app continua normalmente.
- 🟢 **CONFIRMADO** — Changelog exibido apenas se `body` não vazio (scroll max 200px).
- 🟢 **CONFIRMADO** — "Depois" fecha dialog sem baixar; usuário pode continuar usando app antigo.
- 🟢 **CONFIRMADO** — Repositório GitHub fixo: owner `Rdinda`, name `FMA_Pontos`.
- 🟡 **INFERIDO** — API pública sem token — sujeita a rate limit não tratado.
- 🟡 **INFERIDO** — iOS não verifica update (mesmo código compila mas APK asset irrelevante).

## Requisitos Funcionais

| ID | Requisito | Prioridade | Critério de Aceite |
|----|-----------|-----------|-------------------|
| RF-01 | 🟢 O app deve conhecer sua versão instalada. | Must | Dado build instalado, quando `checkForUpdate`, então `PackageInfo.version` é usada. |
| RF-02 | 🟢 O app deve consultar última release no GitHub. | Must | Dado rede disponível, quando check executa, então GET releases/latest é chamado. |
| RF-03 | 🟢 O app deve detectar versão mais nova. | Must | Dado latest > current semver, então `hasUpdate=true`. |
| RF-04 | 🟢 O app deve oferecer link de download APK. | Must | Dado release com asset `.apk`, quando monta UpdateInfo, então URL é `browser_download_url`. |
| RF-05 | 🟢 O app deve exibir changelog da release. | Should | Dado `body` preenchido, quando dialog abre, então texto aparece em área scrollável. |
| RF-06 | 🟢 O usuário deve poder adiar atualização. | Must | Dado dialog, quando Depois, então dialog fecha sem download. |
| RF-07 | 🟢 O usuário deve poder abrir download externo. | Must | Dado Baixar, quando aciona, então `launchUrl` external abre URL. |
| RF-08 | 🟢 Falha de update não deve travar Home. | Must | Dado erro API, quando check falha, então retorna null sem dialog. |
| RF-09 | 🟢 CI deve publicar APK em tag versionada. | Must | Dado push tag `v1.0.20`, quando workflow roda, então release contém APK renomeado. |
| RF-10 | 🟡 Usuário deve ser informado se link não abre. | Should | Dado launchUrl falha, quando mounted, então snackbar de erro. |

## Requisitos Não Funcionais

| Tipo | Requisito | Evidência | Confiança |
|------|-----------|-----------|-----------|
| Segurança | Download via HTTPS do GitHub. | browser_download_url | 🟢 |
| Segurança | Sem verificação de checksum/signature do APK no app. | lacuna | 🟡 |
| Performance | Check assíncrono pós-frame; não bloqueia render inicial. | postFrameCallback | 🟢 |
| Observabilidade | Logs via pacote `logger`. | UpdateService | 🟢 |
| Manutenibilidade | Repo owner/name hardcoded. | constants | 🟢 |
| Disponibilidade | Depende de api.github.com e releases publicadas. | http.get | 🟢 |

## Critérios de Aceitação

```gherkin
Dado app versão 1.0.19 instalada e release 1.0.20 no GitHub
Quando Home abre e checkForUpdate executa
Então dialog Nova Atualização Disponível é exibido

Dado app já na versão latest
Quando checkForUpdate executa
Então nenhum dialog é mostrado

Dado release com asset FMA-Pontos-v1.0.20.apk
Quando usuário toca Baixar
Então navegador ou gerenciador abre URL do APK

Dado API GitHub retorna 404
Quando check executa
Então retorna null e app segue na Home

Dado usuário toca Depois no dialog
Quando dialog fecha
Então Home permanece utilizável na versão antiga

Dado tag v1.0.21 push no repositório
Quando GitHub Actions completa
Então release contém APK com dart-define Supabase
```

## Prioridade (MoSCoW)

| Requisito | MoSCoW | Justificativa |
|-----------|--------|---------------|
| Check versão + dialog | Must | 🟢 Distribuição sideload Android. |
| Download APK asset | Must | 🟢 Entrega principal. |
| Pipeline CI release | Must | 🟢 Gera artefato consumido pelo app. |
| Changelog no dialog | Should | 🟢 UX implementada. |
| Play Store in-app update | Won't | 🟡 Não implementado. |
| iOS TestFlight/update | Won't | 🟡 Fora do escopo legado. |
| Verificação hash APK | Could | 🟡 Não implementado. |

## Rastreabilidade de Código

| Arquivo | Função / Classe | Cobertura |
|---------|-----------------|-----------|
| `lib/services/update_service.dart` | `UpdateService`, `UpdateInfo` | 🟢 |
| `lib/screens/home_screen.dart` | `_checkForUpdates`, `_launchUpdateUrl` | 🟢 |
| `pubspec.yaml` | `version` | 🟢 |
| `.github/workflows/release-app.yml` | build + gh-release | 🟢 |
| `android/app/build.gradle.kts` | `versionCode`/`versionName` from Flutter | 🟢 |

## Relação com outras units

| Unit | Relação |
|------|---------|
| `onboarding-privacidade` | Splash/Home exibem versão via `package_info_plus`. |
| `sincronizacao-offline` | Check de update roda em paralelo ao `syncData` na Home. |
| `platform-android` | APK, signing, applicationId `com.fmapontos.app`. |
| `release-pipeline` | Sinônimo desta unit no módulo scout `release-pipeline`. |
