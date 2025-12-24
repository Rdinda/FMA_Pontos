import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/auth_service.dart';
import '../widgets/category_player_widget.dart';
import 'lyric_form_screen.dart';
import 'search_screen.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final int _currentIndex = 0; // 0=Home, 1=Search, 2=Add

  void _onTabTapped(int index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      );
    } else if (index == 2) {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (!authService.canAddLyrics) {
        _showPermissionMessage(authService.isAnonymous);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LyricFormScreen(categoryId: widget.category.id),
          ),
        );
      }
    }
  }

  void _showPermissionMessage(bool isAnonymous) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAnonymous
              ? 'Faça login com Google para adicionar letras'
              : 'Você não tem permissão para esta ação',
        ),
      ),
    );
  }

  // Getters de permissão usando AuthService
  bool get _canEditCategory {
    final authService = Provider.of<AuthService>(context, listen: false);
    return authService.canEditCategories;
  }

  bool get _canDeleteCategory {
    final authService = Provider.of<AuthService>(context, listen: false);
    return authService.canDeleteCategories;
  }

  void _editCategory() {
    final nameController = TextEditingController(text: widget.category.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Editar Categoria"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Nome"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedCat = Category(
                id: widget.category.id,
                name: nameController.text,
                updatedAt: DateTime.now(),
              );
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).updateCategory(updatedCat);
              Navigator.pop(ctx);
              Navigator.pop(context); // Go back to reload? Or set state?
              // Ideally we update local state or pop. A simple pop works.
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  void _deleteCategory() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir Categoria?"),
        content: const Text("Isso excluirá todas as letras desta categoria."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).deleteCategory(widget.category.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _playAllLyrics() async {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );

    final lyrics = await repo.getLyrics(widget.category.id);
    if (lyrics.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhuma letra nesta categoria.')),
        );
      }
      return;
    }

    await audioService.playAll(lyrics);
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name.capitalize()),
        actions: [
          IconButton(
            onPressed: _playAllLyrics,
            icon: const Icon(Icons.play_circle_outline),
            tooltip: 'Tocar Todas',
          ),
          if (_canEditCategory)
            IconButton(onPressed: _editCategory, icon: const Icon(Icons.edit)),
          if (_canDeleteCategory)
            IconButton(
              onPressed: _deleteCategory,
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: FutureBuilder<List<Lyric>>(
        future: repo.getLyrics(widget.category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final lyrics = snapshot.data ?? [];
          if (lyrics.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await repo.syncData();
              },
              child: ListView(
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text("Nenhuma letra nesta categoria."),
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await repo.syncData();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: lyrics.length,
              itemBuilder: (ctx, i) {
                final lyric = lyrics[i];
                final colorScheme = Theme.of(context).colorScheme;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Card(
                    elevation: 2,
                    color: colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        lyric.title.capitalize(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onTap: () {
                        // Open View Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LyricViewScreen(lyric: lyric),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Letra"),
        ],
      ),
      bottomSheet: const CategoryPlayerWidget(),
    );
  }
}
