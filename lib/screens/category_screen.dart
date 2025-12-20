import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import 'lyric_form_screen.dart';
import 'search_screen.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';
// For navigation

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LyricFormScreen(categoryId: widget.category.id),
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name.capitalize()),
        actions: [
          IconButton(onPressed: _editCategory, icon: const Icon(Icons.edit)),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Card(
                    elevation: 2,
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
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
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
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Letra"),
        ],
      ),
    );
  }
}
