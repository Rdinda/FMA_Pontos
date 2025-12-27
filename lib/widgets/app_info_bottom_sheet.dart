import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../screens/admin_screen.dart';
import '../screens/privacy_policy_screen.dart';
import '../services/auth_service.dart';
import '../utils/snackbar_utils.dart';

Future<void> showAppInfoBottomSheet(
  BuildContext context, {
  String? version,
}) async {
  final colorScheme = Theme.of(context).colorScheme;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Consumer<AuthService>(
      builder: (context, authService, child) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              if (!authService.isAnonymous) ...[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colorScheme.primaryContainer,
                  backgroundImage: authService.photoUrl != null
                      ? NetworkImage(authService.photoUrl!)
                      : null,
                  child: authService.photoUrl == null
                      ? Icon(
                          Icons.person,
                          size: 40,
                          color: colorScheme.primary,
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  authService.displayName ?? authService.userEmail ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (authService.displayName != null)
                  Text(
                    authService.userEmail ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.outline,
                        ),
                  ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getRoleLabel(authService.userRole),
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.person_outline,
                  size: 60,
                  color: colorScheme.outline,
                ),
                const SizedBox(height: 12),
                Text(
                  'Visitante',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.outline,
                      ),
                ),
                Text(
                  'Entre para contribuir com a comunidade',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color:
                      colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return ListTile(
                          leading: Icon(
                            themeProvider.themeIcon,
                            color: colorScheme.primary,
                          ),
                          title: const Text('Tema'),
                          subtitle: Text(themeProvider.themeLabel),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: colorScheme.outline,
                          ),
                          onTap: () => themeProvider.cycleTheme(),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      indent: 56,
                      color: colorScheme.outline.withValues(alpha: 0.2),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        color: colorScheme.primary,
                      ),
                      title: const Text('Política de Privacidade'),
                      subtitle: const Text('Leia como seus dados são utilizados'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colorScheme.outline,
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    if (authService.isAdmin) ...[
                      Divider(
                        height: 1,
                        indent: 56,
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.admin_panel_settings,
                          color: colorScheme.primary,
                        ),
                        title: const Text('Administração'),
                        subtitle: const Text('Gerenciar usuários e logs'),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: colorScheme.outline,
                        ),
                        onTap: () {
                          Navigator.pop(ctx);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminScreen(),
                            ),
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (authService.isAnonymous)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: authService.isLoading
                        ? null
                        : () async {
                            final success = await authService.signInWithGoogle();
                            if (success && ctx.mounted) {
                              Navigator.pop(ctx);
                              SnackbarUtils.show(
                                context,
                                message: 'Login realizado!',
                              );
                            } else if (!success &&
                                authService.error != null &&
                                ctx.mounted) {
                              SnackbarUtils.show(
                                context,
                                message: authService.error!,
                                isError: true,
                              );
                            }
                          },
                    icon: authService.isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.login),
                    label: const Text('Entrar com Google'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await authService.signOut();
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair da conta'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      side: BorderSide(
                        color: colorScheme.error.withValues(alpha: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              if ((version ?? '').isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  'Filhos de Maria das Almas • v$version',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: colorScheme.outline),
                ),
              ],
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    ),
  );
}

String _getRoleLabel(String role) {
  switch (role) {
    case 'admin':
      return 'Administrador';
    case 'moderator':
      return 'Moderador';
    default:
      return 'Usuário';
  }
}

