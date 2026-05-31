import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import '../services/play_stats_service.dart';
import 'category_screen.dart';
import 'top_played_screen.dart';
import 'all_categories_screen.dart';
import 'lyric_view_screen.dart';
import 'package:uuid/uuid.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../services/update_service.dart';
import '../widgets/app_info_bottom_sheet.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../widgets/streaming/category_card.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastPressedAt;
  String _version = '';
  List<LyricWithStats> _topPlayed = [];
  List<Category> _featuredCategories = [];
  Map<String, Category> _categoryMap = {};
  static const int _homeCategoryLimit = 4;
  static const int _topPlayedPreviewLimit = 8;

  @override
  void initState() {
    super.initState();
    _loadVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SyncRepository>(context, listen: false).syncData();
      _checkForUpdates();
      _loadHomeData();
    });
  }

  Future<void> _loadHomeData() async {
    try {
      final repo = Provider.of<SyncRepository>(context, listen: false);
      final playStats = PlayStatsService();
      final categories = await repo.getCategories();
      final stats = await playStats.getTopPlayed(limit: _topPlayedPreviewLimit);
      final featured = await playStats.rankCategoriesByAccess(
        categories,
        lyricsCountFor: repo.getLyricsCount,
        limit: _homeCategoryLimit,
      );
      if (mounted) {
        setState(() {
          _topPlayed = stats;
          _featuredCategories = featured;
          _categoryMap = {for (var c in categories) c.id: c};
        });
      }
    } catch (e) {
      debugPrint('[HomeScreen] Error loading home data: $e');
    }
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() => _version = packageInfo.version);
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bom dia';
    if (hour < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  String _userName(AuthService auth) {
    if (!auth.isAnonymous && auth.displayName != null) {
      return auth.displayName!.split(' ').first;
    }
    return 'Usuário';
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    nameController.addListener(() {
      if (codeController.text.isEmpty) {
        final text = nameController.text.trim();
        if (text.isNotEmpty) {
          final len = text.length >= 2 ? 2 : text.length;
          codeController.text = text.substring(0, len).toUpperCase();
        }
      }
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nova Categoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome', filled: true),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'Código (Prefixo)',
                filled: true,
                helperText: 'Ex: OX para Oxum (Único)',
              ),
              textCapitalization: TextCapitalization.characters,
              maxLength: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
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
            child: const Text('Salvar'),
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
    final authService = Provider.of<AuthService>(context);

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
      child: StreamingScaffold(
        navContext: StreamingNavContext.home,
        currentNavIndex: StreamingNavIndex.home,
        onAddCategory: _showAddCategoryDialog,
        appVersion: _version.isEmpty ? null : _version,
        appBar: StreamingAppBar(
          leading: Consumer<AuthService>(
            builder: (context, auth, _) {
              final colorScheme = Theme.of(context).colorScheme;
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: _showAppInfoDialog,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: colorScheme.surfaceContainerHigh,
                    backgroundImage: !auth.isAnonymous && auth.photoUrl != null
                        ? NetworkImage(auth.photoUrl!)
                        : null,
                    child: auth.isAnonymous || auth.photoUrl == null
                        ? Icon(
                            Icons.person_outline,
                            size: 18,
                            color: colorScheme.onSurfaceVariant,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
          actions: [
            if (syncRepo.isOffline)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.wifi_off, color: Colors.red, size: 20),
              ),
            IconButton(
              onPressed: _showAppInfoDialog,
              icon: const Icon(Icons.notifications_outlined),
              tooltip: 'Informações',
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              syncRepo.syncData(),
              authService.refreshUserRole(),
              _loadHomeData(),
            ]);
          },
          child: FutureBuilder<List<Category>>(
            future: syncRepo.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  _featuredCategories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Nenhuma categoria encontrada.\nAdicione uma nova!',
                        ),
                      ),
                    ),
                  ],
                );
              }

              final displayCategories = _featuredCategories.isNotEmpty
                  ? _featuredCategories
                  : snapshot.data!.take(_homeCategoryLimit).toList();

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: StreamingTokens.spacingMd,
                  vertical: StreamingTokens.spacingSm,
                ),
                children: [
                  _GreetingBanner(
                    greeting: _greeting(),
                    userName: _userName(authService),
                  ),
                  const SizedBox(height: StreamingTokens.spacingLg),
                  _SectionHeader(
                    title: 'Categorias',
                    onArrowTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllCategoriesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: StreamingTokens.spacingMd),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: displayCategories.length,
                    itemBuilder: (context, index) {
                      final category = displayCategories[index];
                      final originalIndex =
                          snapshot.data!.indexWhere((c) => c.id == category.id);
                      return CategoryCard(
                        name: category.name.capitalize(),
                        index: originalIndex >= 0 ? originalIndex : index,
                        category: category,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CategoryScreen(category: category),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: StreamingTokens.spacingLg),
                  _SectionHeader(
                    title: 'Mais Tocados',
                    onArrowTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TopPlayedScreen(),
                        ),
                      );
                    },
                  ),
                  if (_topPlayed.isEmpty) ...[
                    const SizedBox(height: StreamingTokens.spacingMd),
                    Text(
                      'Nenhum ponto tocado ainda',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: StreamingTokens.spacingSm),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _topPlayed.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final item = _topPlayed[i];
                          final lyric = item.lyric;
                          final cat = _categoryMap[lyric.categoryId];

                          return _TopPlayedCarouselItem(
                            lyric: lyric,
                            categoryName: cat?.name.capitalize() ?? '',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      LyricViewScreen(lyric: lyric),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: StreamingTokens.spacingMd),
                ],
              );
            },
          ),
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
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return AlertDialog(
            title: const Text('Nova Atualização Disponível'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uma nova versão (${updateInfo.version}) está disponível.',
                ),
                if (updateInfo.changelog.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'O que há de novo:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 180),
                    child: SingleChildScrollView(
                      child: Text(updateInfo.changelog),
                    ),
                  ),
                ],
                if (updateInfo.sha256 != null && updateInfo.sha256!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Assinatura de Segurança (SHA-256)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                updateInfo.sha256!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: IconButton(
                                icon: const Icon(Icons.copy_rounded, size: 16),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: updateInfo.sha256!),
                                  );
                                  SnackbarUtils.show(
                                    context,
                                    message:
                                        'SHA-256 copiado para a área de transferência',
                                  );
                                },
                                tooltip: 'Copiar hash',
                              ),
                            ),
                          ],
                        ),
                      ],
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
                  Navigator.pop(context);
                  _launchUpdateUrl(updateInfo.url);
                },
                child: const Text('Baixar'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _launchUpdateUrl(String url) async {
    try {
      final uri = Uri.parse(url);
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onArrowTap;

  const _SectionHeader({required this.title, this.onArrowTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (onArrowTap != null)
          IconButton(
            onPressed: onArrowTap,
            icon: Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
            tooltip: 'Ver todos',
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}

class _GreetingBanner extends StatelessWidget {
  final String greeting;
  final String userName;

  const _GreetingBanner({required this.greeting, required this.userName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: StreamingTokens.cardRadius,
      child: SizedBox(
        height: 192,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/main.webp',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: colorScheme.surfaceContainerHigh,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                '$greeting,\n$userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 8)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopPlayedCarouselItem extends StatelessWidget {
  final Lyric lyric;
  final String categoryName;
  final VoidCallback onTap;

  const _TopPlayedCarouselItem({
    required this.lyric,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: StreamingTokens.horizontalCarouselItemWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: StreamingTokens.cardRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryContainer.withValues(alpha: 0.6),
                      colorScheme.surfaceContainerHighest,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 40,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lyric.title.capitalize(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              categoryName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
