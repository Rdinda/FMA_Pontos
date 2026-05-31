import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import 'category_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'top_played_screen.dart';
import 'package:uuid/uuid.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/update_service.dart';
import '../widgets/app_info_bottom_sheet.dart';

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
      // Buscar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      );
    } else if (index == 2) {
      // Mais Tocados
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TopPlayedScreen()),
      );
    } else if (index == 3) {
      // Gostei (Favoritos)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FavoritesScreen()),
      );
    } else if (index == 4) {
      // Adicionar Categoria
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
          ? SnackBarAction(
              label: 'Entrar',
              onPressed: () =>
                  showAppInfoBottomSheet(context, version: _version),
            )
          : null,
    );
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    // Auto-generate code when name changes, if code is empty
    nameController.addListener(() {
      if (codeController.text.isEmpty) {
        final text = nameController.text.trim();
        if (text.isNotEmpty) {
          // Take up to 2 characters
          final len = text.length >= 2 ? 2 : text.length;
          codeController.text = text.substring(0, len).toUpperCase();
        }
      }
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Nova Categoria"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                filled: true,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: "Código (Prefixo)",
                filled: true,
                helperText: "Ex: OX para Oxum (Único)",
              ),
              textCapitalization: TextCapitalization.characters,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  codeController.text.isNotEmpty) {
                final newCat = Category(
                  id: const Uuid().v4(),
                  name: nameController.text.trim(),
                  code: codeController.text.trim().toUpperCase(),
                  updatedAt: DateTime.now(),
                );
                Provider.of<SyncRepository>(
                  context,
                  listen: false,
                ).addCategory(newCat);
                Navigator.pop(ctx);
              } else {
                SnackbarUtils.show(
                  context,
                  message: 'Preencha nome e código',
                  isError: true,
                );
              }
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _showAppInfoDialog() {
    showAppInfoBottomSheet(context, version: _version);
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
          SnackbarUtils.show(context, message: 'Pressione novamente para sair');
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
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_rounded),
              label: "Top",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Gostei",
            ),
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
