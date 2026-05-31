# Keystore de release (local — não commitar)

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `upload-keystore.jks` | Keystore de assinatura release |
| `key.properties` | Senhas e alias (lidas pelo Gradle) |
| `keystore.base64.txt` | `.jks` codificado em Base64 (uma linha) para secrets de CI |

Todos estão no `.gitignore`. **Nunca** faça commit desses arquivos.

## Backup

Guarde `upload-keystore.jks` e as senhas em um gerenciador de senhas offline. Perder a keystore impede atualizar o app na Play Store com o mesmo pacote.

## `storeFile` no Gradle

O `android/app/build.gradle.kts` resolve `storeFile` em relação à pasta `android/app/`. Por isso `key.properties` usa:

```properties
storeFile=../upload-keystore.jks
```

(com o `.jks` na pasta `android/`).

## Firebase / Google Console

Alias: `upload`

**Google Sign-In (OAuth):** ver [`GOOGLE_OAUTH.md`](GOOGLE_OAUTH.md) — package `com.fmapontos.app`, SHA-1 release, Web client para Supabase.

Listar fingerprints:

```powershell
# Senha: ver android/key.properties (storePassword)
keytool -list -v -keystore upload-keystore.jks -alias upload
```

## CI (GitHub Actions etc.)

1. Secret: conteúdo de `keystore.base64.txt` (uma linha).
2. Secret: valores de `storePassword`, `keyPassword`, `keyAlias` (`upload`).

Decodificar antes do build (Linux/macOS runner):

```bash
echo "$KEYSTORE_BASE64" | base64 -d > android/upload-keystore.jks
```

PowerShell (Windows runner):

```powershell
[IO.File]::WriteAllBytes("android/upload-keystore.jks", [Convert]::FromBase64String($env:KEYSTORE_BASE64))
```

Crie `android/key.properties` no job a partir dos secrets ou use variáveis de ambiente conforme seu workflow.

## Build release local

```bash
flutter build apk --release
# ou
flutter build appbundle --release
```
