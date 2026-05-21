# Release e Atualização — Fluxos Operacionais

## Fluxo 1 — Verificação automática na Home

```mermaid
flowchart TD
  A["HomeScreen initState"] --> B["postFrameCallback"]
  B --> C["syncData"]
  B --> D["_checkForUpdates"]
  D --> E["UpdateService.checkForUpdate"]
  E --> F{"UpdateInfo com hasUpdate?"}
  F -- "sim" --> G["showDialog update"]
  F -- "não/null" --> H["sem UI extra"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Check não bloqueia render da Home (async pós-frame).
- 🟢 **CONFIRMADO** — Sync e update rodam no mesmo callback (paralelo implícito).

## Fluxo 2 — Consulta GitHub e comparação

```mermaid
flowchart TD
  A["checkForUpdate"] --> B["PackageInfo.version"]
  B --> C["GET releases/latest"]
  C --> D{"status 200?"}
  D -- "não" --> E["log warning return null"]
  D -- "sim" --> F["parse tag_name → latestVersion"]
  F --> G["_compareVersions"]
  G --> H{"has update?"}
  H -- "não" --> I["return null"]
  H -- "sim" --> J["resolver download URL"]
  J --> K["return UpdateInfo"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Prefixo `v` removido de `tag_name`.
- 🟢 **CONFIRMADO** — `body` vira changelog (pode ser markdown bruto).

## Fluxo 3 — Dialog e decisão do usuário

```mermaid
flowchart TD
  A["Dialog exibido"] --> B{"ação?"}
  B -- "Depois" --> C["Navigator.pop"]
  C --> D["continua versão antiga"]
  B -- "Baixar" --> E["pop dialog"]
  E --> F["_launchUpdateUrl"]
  F --> G{"launchUrl ok?"}
  G -- "sim" --> H["app externo abre download"]
  G -- "não" --> I["snackbar erro"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Tap fora do dialog não fecha (`barrierDismissible: false`).
- 🟢 **CONFIRMADO** — Usuário pode adiar indefinidamente.

## Fluxo 4 — Publicação de release (CI)

```mermaid
flowchart TD
  A["git tag v1.0.20 && push"] --> B["GitHub Actions release-app"]
  B --> C["flutter pub get"]
  C --> D["flutter build apk --release"]
  D --> E["mv → FMA-Pontos-v1.0.20.apk"]
  E --> F["action-gh-release upload asset"]
  F --> G["Release visível na API latest"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — `generate_release_notes: true` preenche body automaticamente quando GitHub gera notas.
- 🟢 **CONFIRMADO** — APK embute credenciais Supabase do secret (não do repo).

## Fluxo 5 — Instalação pelo usuário (fora do app)

```mermaid
flowchart LR
  A["Baixar no browser"] --> B["APK baixado"]
  B --> C["Instalar manualmente Android"]
  C --> D["Nova versão ativa"]
  D --> E["Próximo check: sem update"]
```

### Contrato do fluxo

- 🟡 **INFERIDO** — App **não** instala APK automaticamente (sem permissão REQUEST_INSTALL_PACKAGES no fluxo documentado).
- 🟡 **INFERIDO** — Usuário precisa habilitar "fontes desconhecidas" conforme OEM.

## Fluxo 6 — Falha silenciosa de check

```mermaid
flowchart TD
  A["checkForUpdate"] --> B{"exceção ou HTTP erro?"}
  B -- "sim" --> C["Logger.e / Logger.w"]
  C --> D["return null"]
  D --> E["Home sem dialog"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Usuário não vê mensagem de falha do check (apenas logs).

## Fluxo 7 — Exibição de versão (contexto)

```mermaid
flowchart TD
  A["Splash / Home / Bottom sheet"] --> B["PackageInfo.fromPlatform"]
  B --> C["exibir version no UI"]
```

### Contrato do fluxo

- 🟢 **CONFIRMADO** — Versão exibida independente do check de update.
- 🟢 **CONFIRMADO** — `pubspec.yaml` `1.0.19` é fonte para comparação.

## Matriz fluxo × RF

| Fluxo | RF |
|-------|-----|
| Check Home | RF-01, RF-02, RF-03, RF-08 |
| GitHub compare | RF-02, RF-03, RF-04 |
| Dialog | RF-05, RF-06, RF-07 |
| CI release | RF-09 |
| Instalação manual | (externo) |
| Falha silenciosa | RF-08 |
| Launch URL erro | RF-10 |
