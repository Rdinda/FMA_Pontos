import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  /// Incremente ao publicar nova política — força novo aceite no onboarding.
  static const String policyVersion = '2026-05';

  static const String _policyText = '''
POLÍTICA DE USO E PRIVACIDADE — FMA Pontos

Versão: 2026-05
Última atualização: 19/05/2026

Esta política descreve como o aplicativo FMA Pontos ("Aplicativo"), de Roberto Dinda Santos Pereira, trata dados pessoais. Ao utilizar o Aplicativo, você concorda com estes termos.

1. DADOS QUE COLETAMOS

• Login com Google: nome, e-mail e foto de perfil fornecidos pelo provedor OAuth.
• Uso do acervo: pontos, letras, categorias, favoritos e preferências salvas no dispositivo (SQLite).
• Sincronização: os dados do acervo que você cria ou edita são replicados no Supabase (PostgreSQL) quando há conexão.
• Estatísticas de reprodução: contagem de execuções de letras (tabela lyric_play_stats), quando você ouve um ponto com áudio.
• Sessão anônima: antes do login, o Supabase pode criar uma sessão anônima apenas para leitura do acervo público; escritas exigem login.

Não coletamos CPF, telefone, localização GPS nem dados de marketing nesta versão do app.

2. FINALIDADES

• Operar o acervo offline-first e sincronizar alterações entre dispositivo e nuvem.
• Autenticar usuários e aplicar permissões (usuário, moderador, administrador).
• Exibir estatísticas de músicas mais tocadas e registrar auditoria de alterações em categorias e letras (administração).
• Verificar atualizações do aplicativo via GitHub Releases.

3. COMPARTILHAMENTO

Utilizamos Supabase (autenticação, banco e armazenamento de áudio), Google Sign-In e GitHub (releases). Não vendemos dados pessoais.

4. ARMAZENAMENTO E SEGURANÇA

Dados locais ficam no seu aparelho. Dados na nuvem ficam na infraestrutura Supabase. Adotamos boas práticas de segurança; nenhum sistema é 100% invulnerável.

5. SEUS DIREITOS (LGPD)

Você pode solicitar acesso, correção ou exclusão de dados pelo e-mail: rdinda51@gmail.com (assunto: Privacidade FMA Pontos).

6. RETENÇÃO

Mantemos dados enquanto sua conta estiver ativa ou enquanto necessário para operar o Aplicativo e cumprir obrigações legais.

7. ALTERAÇÕES

Podemos atualizar esta política. Mudanças relevantes exigirão novo aceite no aplicativo (versão 2026-05 ou superior).

8. CONTATO

E-mail: rdinda51@gmail.com

Lei aplicável: República Federativa do Brasil. Foro: comarca de São Paulo/SP, salvo direito do consumidor em foro de seu domicílio.
''';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidade'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Text(
              _policyText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
