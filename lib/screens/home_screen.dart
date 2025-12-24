import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import '../providers/theme_provider.dart';
import 'category_screen.dart';
import 'search_screen.dart';
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

  void _showAppInfoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Consumer<AuthService>(
        builder: (context, authService, child) {
          return AlertDialog(
            title: const Text("Sobre o App"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Versão: $_version"),
                const SizedBox(height: 8),
                const Text("Criado por: Rdinda"),
                const SizedBox(height: 16),
                const Text(
                  "Filhos de Maria das Almas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Divider(height: 24),
                // Tema
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(themeProvider.themeIcon),
                      title: const Text('Tema'),
                      subtitle: Text(themeProvider.themeLabel),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => themeProvider.cycleTheme(),
                    );
                  },
                ),
                const Divider(height: 24),
                // Status de login
                Row(
                  children: [
                    Icon(
                      authService.isAnonymous
                          ? Icons.person_outline
                          : Icons.person,
                      size: 20,
                      color: authService.isAnonymous
                          ? Colors.grey
                          : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authService.isAnonymous
                            ? "Usando como convidado"
                            : "${authService.userEmail}\n${authService.userRole.toUpperCase()}",
                        style: TextStyle(
                          color: authService.isAnonymous
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Botão de login/logout
                if (authService.isAnonymous)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: const Text("Entrar com Google"),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () async {
                        await authService.signOut();
                        if (ctx.mounted) Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Sair",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Fechar"),
              ),
            ],
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

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final colorScheme = Theme.of(context).colorScheme;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(category: category),
                        ),
                      );
                    },
                    child: Card(
                      color: colorScheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.name.capitalize(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
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
