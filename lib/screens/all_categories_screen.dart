import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import '../services/auth_service.dart';
import '../utils/add_category_dialog.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../widgets/app_info_bottom_sheet.dart';
import '../widgets/streaming/category_card.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../theme/streaming_tokens.dart';
import 'category_screen.dart';

/// Lista completa de categorias (acessível pela seta em "Categorias" na Home).
class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  Future<List<Category>>? _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final syncRepo = Provider.of<SyncRepository>(context, listen: false);
    final future = syncRepo.getCategories();
    setState(() {
      _categoriesFuture = future;
    });
  }

  Future<void> _onAddCategoryTap() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    if (!auth.canAddCategories) {
      SnackbarUtils.show(
        context,
        message: auth.isAnonymous
            ? 'Faça login com Google para adicionar categorias'
            : 'Você precisa ser moderador para adicionar categorias',
        isError: true,
        action: auth.isAnonymous
            ? SnackBarAction(
                label: 'Entrar',
                onPressed: () => showAppInfoBottomSheet(context),
              )
            : null,
      );
      return;
    }

    await showAddCategoryDialog(context);
    if (mounted) _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final syncRepo = Provider.of<SyncRepository>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return StreamingScaffold(
      navContext: StreamingNavContext.standard,
      currentNavIndex: StreamingNavIndex.home,
      appBar: StreamingAppBar(
        title: 'Categorias',
        actions: [
          IconButton(
            onPressed: _onAddCategoryTap,
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Nova categoria',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await syncRepo.syncData();
          _loadCategories();
        },
        child: FutureBuilder<List<Category>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final categories = snapshot.data ?? [];
            if (categories.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Nenhuma categoria encontrada.')),
                ],
              );
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(StreamingTokens.spacingMd),
              children: [
                Text(
                  'Todas as categorias',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: StreamingTokens.spacingMd),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      name: category.name.capitalize(),
                      index: index,
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
              ],
            );
          },
        ),
      ),
    );
  }
}
