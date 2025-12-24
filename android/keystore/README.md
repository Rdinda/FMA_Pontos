# Keystore para Assinatura do App

Esta pasta contém (ou deve conter) a keystore usada para assinar o APK de release.

## ⚠️ IMPORTANTE

- **NUNCA** faça commit da keystore (arquivo .jks) no repositório
- A keystore já está no .gitignore
- Guarde a keystore e suas senhas em local seguro (backup!)

## Como gerar uma nova keystore

Execute o seguinte comando no terminal:

```bash
keytool -genkey -v -keystore fmapontos-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias fmapontos
```

Você será solicitado a fornecer:

1. **Senha da keystore** (mínimo 6 caracteres)
2. **Seu nome** (ou da organização)
3. **Unidade organizacional**
4. **Organização**
5. **Cidade**
6. **Estado**
7. **Código do país** (BR)
8. **Senha da chave** (pode ser a mesma da keystore)

## Configuração local

1. Gere a keystore conforme acima e salve nesta pasta
2. Copie o arquivo `android/key.properties.example` para `android/key.properties`
3. Edite `android/key.properties` com suas senhas reais

## Configuração para GitHub Actions

Para que o GitHub Actions possa assinar o APK, você precisa:

1. Converter a keystore para base64:

   ```bash
   base64 -i android/keystore/fmapontos-release-key.jks > keystore.base64.txt
   ```

2. Adicionar os seguintes secrets no repositório GitHub:
   - `KEYSTORE_BASE64`: Conteúdo do arquivo keystore.base64.txt
   - `KEYSTORE_PASSWORD`: Senha da keystore
   - `KEY_ALIAS`: fmapontos
   - `KEY_PASSWORD`: Senha da chave

3. O workflow já está configurado para usar esses secrets
