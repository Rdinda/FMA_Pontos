# Release e Atualização — Tarefas de Implementação

## Pré-requisitos

- [ ] 🟢 Repositório GitHub `Rdinda/FMA_Pontos` com releases públicas.
- [ ] 🟢 `http`, `package_info_plus`, `url_launcher`, `logger` no `pubspec.yaml`.
- [ ] 🟢 Versão em `pubspec.yaml` alinhada ao processo de tag.
- [ ] 🟢 Secrets CI: `SUPABASE_URL`, `SUPABASE_ANON_KEY`; opcional keystore para signing.
- [ ] 🟢 Permissão de internet no AndroidManifest.

## Tarefas — UpdateService

- [ ] T-01, Implementar `UpdateInfo` DTO
  - Origem no legado: `update_service.dart`
  - Critério de pronto: campos version, url, changelog, hasUpdate.
  - Confiança: 🟢

- [ ] T-02, Implementar `checkForUpdate`
  - Origem no legado: `update_service.dart`
  - Critério de pronto: lê PackageInfo; GET releases/latest; parse tag e assets; retorna UpdateInfo ou null.
  - Confiança: 🟢

- [ ] T-03, Implementar `_compareVersions`
  - Origem no legado: `update_service.dart`
  - Critério de pronto: compara até 3 segmentos inteiros; false em empate ou erro.
  - Confiança: 🟢

- [ ] T-04, Selecionar URL APK vs html_url
  - Origem no legado: loop assets `.apk`
  - Critério de pronto: preferir `browser_download_url` do asset APK.
  - Confiança: 🟢

- [ ] T-05, Tratar erros com Logger sem throw
  - Origem no legado: catch retorna null
  - Critério de pronto: falhas logadas; não interrompe UI.
  - Confiança: 🟢

## Tarefas — Home UI

- [ ] T-06, Disparar check no init da Home
  - Origem no legado: `addPostFrameCallback` + `_checkForUpdates`
  - Critério de pronto: executa após primeiro frame junto com sync.
  - Confiança: 🟢

- [ ] T-07, Implementar dialog de atualização
  - Origem no legado: `home_screen.dart`
  - Critério de pronto: barrierDismissible false; versão; changelog scroll; Depois/Baixar.
  - Confiança: 🟢

- [ ] T-08, Implementar `_launchUpdateUrl`
  - Origem no legado: `launchUrl` externalApplication
  - Critério de pronto: snackbar se falhar launch.
  - Confiança: 🟢

## Tarefas — CI/CD

- [ ] T-09, Configurar workflow `release-app.yml`
  - Origem no legado: `.github/workflows/release-app.yml`
  - Critério de pronto: trigger `push tags v*`; Flutter 3.38.5; caches gradle/pub.
  - Confiança: 🟢

- [ ] T-10, Build APK com dart-define Supabase
  - Origem no legado: step Build APK
  - Critério de pronto: `flutter build apk --release` com secrets URL/anon key.
  - Confiança: 🟢

- [ ] T-11, Publicar release com APK anexo
  - Origem no legado: softprops/action-gh-release
  - Critério de pronto: arquivo `FMA-Pontos-{ref_name}.apk`; `generate_release_notes: true`.
  - Confiança: 🟢

- [ ] T-12, Configurar signing release opcional
  - Origem no legado: steps Decode Keystore / key.properties
  - Critério de pronto: condicional a `KEYSTORE_BASE64`; JKS + properties para Gradle.
  - Confiança: 🟢

## Tarefas — Processo de release (operacional)

- [ ] T-13, Documentar bump de versão
  - Origem no legado: `pubspec.yaml` version 1.0.19
  - Critério de pronto: incrementar version; commit; tag `vX.Y.Z`; push tag dispara CI.
  - Confiança: 🟢

## Tarefas — Melhorias (opcional)

- [ ] T-14, Externalizar owner/repo para dart-define
  - Origem no legado: constants hardcoded
  - Critério de pronto: configurável por flavor.
  - Confiança: 🟡

- [ ] T-15, Informar usuário quando check falha por rede
  - Origem no legado: lacuna
  - Critério de pronto: snackbar discreto ou ícone status.
  - Confiança: 🟡

- [ ] T-16, Verificar checksum do APK baixado
  - Origem no legado: não implementado
  - Critério de pronto: SHA256 na release notes ou asset checksum file.
  - Confiança: 🟡

## Ordem sugerida

1. T-09 → T-12 (CI)
2. T-01 → T-05 (service)
3. T-06 → T-08 (UI)
4. T-13 (processo)
5. T-14 → T-16 (hardening)
