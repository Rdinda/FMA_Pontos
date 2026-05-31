# Fluxograma — app-bootstrap

```mermaid
flowchart TD
  A["main()"] --> B["WidgetsFlutterBinding.ensureInitialized"]
  B --> C["Ler SUPABASE_URL e SUPABASE_ANON_KEY via String.fromEnvironment"]
  C --> D{"Credenciais vazias?"}
  D -- "sim" --> E["Lançar exceção (splash nativa trava)"]
  D -- "não" --> F["Supabase.initialize"]
  F --> G["AudioPlayerService.create"]
  G --> H["runApp(MyApp)"]
  H --> I["MultiProvider"]
  I --> J["MaterialApp pt-BR"]
  J --> J1["theme / darkTheme: AppTheme"]
  J1 --> J2["themeMode: ThemeProvider"]
  J2 --> K["SplashScreen"]
```

## Tema (🟢 re-extração visual 2026-05-31)

```mermaid
flowchart LR
  TP["ThemeProvider"] --> MM["MaterialApp.themeMode"]
  AT["AppTheme.buildLightTheme"] --> MM
  AT2["AppTheme.buildDarkTheme"] --> MM
  AC["AppColors tokens"] --> AT
  AC --> AT2
```

- 🟢 **CONFIRMADO** — `ThemeProvider` default `ThemeMode.dark` (sem prefs).
- 🟢 **CONFIRMADO** — `AppTheme` usa Plus Jakarta Sans e `ColorScheme` explícito (verde `#1DB954`).

## Desenvolvimento local (🟢 re-extração 2026-05-21)

```mermaid
flowchart LR
  ENV[".env"] --> PS["run-dev.ps1"]
  PS --> JSON["dart_defines.json"]
  JSON --> RUN["flutter run --dart-define-from-file=dart_defines.json"]
  IDE[".vscode/launch.json FMA Pontos dev"] --> RUN
```

- 🟢 **CONFIRMADO** — Release/CI continuam usando `--dart-define=SUPABASE_URL=...` direto (GitHub Actions).
- 🟢 **CONFIRMADO** — `dart_defines.example.json` documenta formato JSON esperado.
- 🟡 **INFERIDO** — Sem `--dart-define`, app falha antes de `runApp` (tela branca = splash nativa Android).
