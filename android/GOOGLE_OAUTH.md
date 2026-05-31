# Google OAuth — FMA Pontos (projeto 674450422802)

## Clientes OAuth

| Tipo | Client ID | Uso |
|------|-----------|-----|
| **Web** | `674450422802-j9vle9l5ufp90m0av0pph3reoup6eeqf.apps.googleusercontent.com` | `serverClientId` no app (`GOOGLE_SERVER_CLIENT_ID`) e provider Google no Supabase |
| **Android** | `674450422802-le6d9rvtsm80a33kanuhkma898kkivjc.apps.googleusercontent.com` | Identificador no Google Console — **não** passar como `serverClientId`; Android valida package + SHA-1 |

## Android OAuth client (Google Cloud Console)

O cliente Android deve ter:

- **Package name:** `com.fmapontos.app`
- **SHA-1 (release):** `0C:6A:CF:0F:3F:ED:9C:EA:49:2D:4A:B1:AC:06:C5:15:14:9F:CB:74`

Não registrar SHA-1 de debug neste projeto — builds de desenvolvimento usam a keystore de release (ver abaixo).

Verificar SHA-1 localmente:

```powershell
cd android
# Senha em key.properties (storePassword)
keytool -list -v -keystore upload-keystore.jks -alias upload
```

## Assinatura em desenvolvimento

Com `android/key.properties` presente, `android/app/build.gradle.kts` assina **debug** com a mesma config **release** (`upload-keystore.jks`, alias `upload`). Assim `flutter run` e `run-dev.ps1` usam o certificado release esperado pelo Google Console.

Sem `key.properties`, debug usa o certificado padrão do Android SDK e o Google Sign-In falhará (ApiException 10) até configurar a keystore.

## App (`serverClientId`)

O Web Client ID é lido via `--dart-define`:

```dart
String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID', defaultValue: '674450422802-j9vle9l5ufp90m0av0pph3reoup6eeqf.apps.googleusercontent.com')
```

`run-dev.ps1` inclui `GOOGLE_SERVER_CLIENT_ID` do `.env` em `dart_defines.json` quando definido. Ver `.env.example`.

## Supabase — provider Google

No [Supabase Dashboard](https://supabase.com/dashboard) → Authentication → Providers → Google:

1. Ativar Google provider.
2. **Client ID (Web):** `674450422802-j9vle9l5ufp90m0av0pph3reoup6eeqf.apps.googleusercontent.com`
3. **Client Secret:** secret do **mesmo** cliente Web no projeto Google Cloud `674450422802` (não usar secret do cliente Android).
4. Salvar e testar login no app.

## Ação manual (Google Console)

Se o SHA-1 ainda não estiver cadastrado no cliente Android:

1. [Google Cloud Console](https://console.cloud.google.com/) → APIs & Services → Credentials.
2. Abrir o OAuth client **Android** (`674450422802-le6d9rvtsm80a33kanuhkma898kkivjc`).
3. Confirmar package `com.fmapontos.app` e adicionar/confirmar SHA-1 release: `0C:6A:CF:0F:3F:ED:9C:EA:49:2D:4A:B1:AC:06:C5:15:14:9F:CB:74`.
4. Aguardar alguns minutos para propagação antes de testar.
