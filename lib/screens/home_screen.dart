import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import '../providers/theme_provider.dart';
import 'category_screen.dart';
import 'search_screen.dart';
import 'admin_screen.dart';
import 'package:uuid/uuid.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/update_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;
  String _version = '';

  @override
  void initState() {
    super.initState();
    // Initial data load
    _loadVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SyncRepository>(context, listen: false).syncData();
      _checkForUpdates();
    });
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      );
    } else if (index == 2) {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (!authService.canAddCategories) {
        _showPermissionDeniedMessage('moderador', 'adicionar categorias');
      } else {
        _showAddCategoryDialog();
      }
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showPermissionDeniedMessage(String requiredRole, String action) {
    final authService = Provider.of<AuthService>(context, listen: false);
    String message;

    if (authService.isAnonymous) {
      message = 'Faça login com Google para $action';
    } else {
      message = 'Você precisa ser $requiredRole para $action';
    }

    SnackbarUtils.show(
      context,
      message: message,
      isError: true, // Permission denied effectively an error/warning
      action: authService.isAnonymous
          ? SnackBarAction(label: 'Entrar', onPressed: _showAppInfoDialog)
          : null,
    );
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nova Categoria"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Nome", filled: true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final newCat = Category(
                  id: const Uuid().v4(),
                  name: nameController.text,
                  updatedAt: DateTime.now(),
                );
                Provider.of<SyncRepository>(
                  context,
                  listen: false,
                ).addCategory(newCat);
                Navigator.pop(ctx);
              }
            },
            child: const Text("Salvar"),
          ),
        ],
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

  void _showAppInfoDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Consumer<AuthService>(
        builder: (context, authService, child) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),

                // Header com foto/avatar
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
                  // Badge de role
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
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

                // Opções
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Tema
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
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(
                        height: 1,
                        indent: 56,
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                      // Admin
                      if (authService.isAdmin)
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: authService.isAnonymous
                                  ? Radius.zero
                                  : const Radius.circular(16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Botão de login/logout
                if (authService.isAnonymous)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: authService.isLoading
                          ? null
                          : () async {
                              final success = await authService
                                  .signInWithGoogle();
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

                const SizedBox(height: 20),

                // Info do app
                Text(
                  'Filhos de Maria das Almas • v$_version',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                ),

                // Safe area padding
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final syncRepo = Provider.of<SyncRepository>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final now = DateTime.now();
        const maxDuration = Duration(seconds: 3);
        final isWarning =
            _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > maxDuration;

        if (isWarning) {
          _lastPressedAt = now;
          SnackbarUtils.show(
            context,
            message: 'Pressione novamente para sair',
            duration: maxDuration,
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Filhos de Maria das Almas"),
          actions: [
            if (syncRepo.isOffline)
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.wifi_off, color: Colors.red),
              ),
            Consumer<AuthService>(
              builder: (context, authService, child) {
                if (!authService.isAnonymous && authService.photoUrl != null) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: _showAppInfoDialog,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(authService.photoUrl!),
                      ),
                    ),
                  );
                }
                return IconButton(
                  onPressed: _showAppInfoDialog,
                  icon: const Icon(Icons.info_outline),
                  tooltip: "Informações",
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            final authService = Provider.of<AuthService>(
              context,
              listen: false,
            );
            await Future.wait([
              syncRepo.syncData(),
              authService.refreshUserRole(),
            ]);
          },
          child: FutureBuilder<List<Category>>(
            future: syncRepo.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Nenhuma categoria encontrada.\nAdicione uma nova!",
                        ),
                      ),
                    ),
                  ],
                );
              }
              final categories = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final colorScheme = Theme.of(context).colorScheme;

                  // Cores variadas baseadas no índice
                  final hue = (index * 37) % 360;
                  final accentColor = HSLColor.fromAHSL(
                    1,
                    hue.toDouble(),
                    0.6,
                    0.5,
                  ).toColor();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CategoryScreen(category: category),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: colorScheme.surfaceContainerHighest,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withValues(
                                  alpha: 0.08,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Ícone
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.music_note_rounded,
                                    color: accentColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Texto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category.name.capitalize(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.onSurface,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      FutureBuilder<int>(
                                        future: syncRepo.getLyricsCount(
                                          category.id,
                                        ),
                                        builder: (context, countSnapshot) {
                                          final count = countSnapshot.data ?? 0;
                                          return Text(
                                            '$count ${count == 1 ? 'ponto' : 'pontos'}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: colorScheme.outline,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // Seta
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: colorScheme.outline,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Categoria",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    final updateInfo = await UpdateService.checkForUpdate();
    if (updateInfo != null && updateInfo.hasUpdate && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Nova Atualização Disponível'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Uma nova versão (${updateInfo.version}) está disponível.'),
              if (updateInfo.changelog.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'O que há de novo:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(updateInfo.changelog),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Depois'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                _launchUpdateUrl(updateInfo.url);
              },
              child: const Text('Baixar'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _launchUpdateUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      debugPrint('[Update] Attempting to launch URL: $url');

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        SnackbarUtils.show(
          context,
          message: 'Não foi possível abrir o link de download',
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('[Update] Error launching URL: $e');
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Erro ao abrir download: $e',
          isError: true,
        );
      }
    }
  }
}
