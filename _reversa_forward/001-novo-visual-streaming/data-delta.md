# Data Delta: 001-novo-visual-streaming

> Data: `2026-05-21`
> Baseline: `_reversa_sdd/data-dictionary.md`, `_reversa_sdd/erd-complete.md`

## 1. Escopo

Esta feature é **visual-only** (RN-01). Este documento registra explicitamente a ausência de mudanças de dados e documenta únicos pontos de persistência client-side tangenciados pela UI.

## 2. SQLite local

| Tabela | Mudança | Migração |
|--------|---------|----------|
| `categories` | nenhuma | n/a |
| `lyrics` | nenhuma | n/a |
| Demais | nenhuma | n/a |

**Versão schema (`DatabaseHelper`):** inalterada.

## 3. Supabase / Postgres

| Objeto | Mudança | Migração SQL |
|--------|---------|--------------|
| Todas tabelas, RLS, RPC, Storage | nenhuma | n/a |

## 4. SharedPreferences

| Chave | Mudança | Notas |
|-------|---------|-------|
| `theme_mode` | **sem mudança de schema** | Continua `int` index de `ThemeMode`. Apenas default em código muda para dark quando chave ausente (D-05) |
| `onboarding_completed` | nenhuma | n/a |
| `privacy_policy_version` | nenhuma | n/a |
| Favoritos / sync keys | nenhuma | n/a |

## 5. Modelos Dart (`lib/models/`)

Nenhum campo adicionado, removido ou renomeado.

## 6. Assets

| Asset | Mudança possível | Notas |
|-------|------------------|-------|
| `assets/images/splash.png` | 🟡 opcional | Substituir ou adicionar logo alinhado a `Logo_Splash.png` do Stitch (RF-10) — decisão visual, não schema |
| Novos PNGs em `assets/` | 🟡 opcional | Importar de `_reversa_sdd/stitch_screens/` se necessário |

## 7. Design system (documentação)

| Artefato | Mudança |
|----------|---------|
| `_reversa_sdd/design-system/tokens.md` | Atualizar cores e fonte (RF-12) |
| `_reversa_sdd/design-system/color-palette.md` | `#6200EE` → paleta streaming |
| `_reversa_sdd/design-system/typography.md` | Outfit → Plus Jakarta Sans |

Isso é documentação Reversa, não dado de runtime.

## 8. Resumo

```
Campos novos:     0
Campos removidos: 0
Migrations SQL:   0
Prefs alteradas:  0 (comportamento default only)
```

Nenhuma ação de `/reversa-data-master` é pré-requisito para esta feature.
