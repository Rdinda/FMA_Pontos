import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import 'category_screen.dart'; // Will create next
import 'search_screen.dart'; // Will create next
import 'package:uuid/uuid.dart';
import '../utils/string_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/update_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    // Initial data load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SyncRepository>(context, listen: false).syncData();
      _checkForUpdates();
    });
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      );
    } else if (index == 2) {
      _showAddCategoryDialog();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
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
      builder: (ctx) => AlertDialog(
        title: const Text("Sobre o App"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Versão: 1.0.5"),
            const SizedBox(height: 8),
            const Text("Criado por: Rdinda"),
            const SizedBox(height: 16),
            const Text(
              "Filhos de Maria das Almas",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Fechar"),
          ),
        ],
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
        const maxDuration = Duration(seconds: 2);
        final isWarning =
            _lastPressedAt == null ||
            now.difference(_lastPressedAt!) > maxDuration;

        if (isWarning) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pressione novamente para sair'),
              duration: maxDuration,
            ),
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
            IconButton(
              onPressed: _showAppInfoDialog,
              icon: const Icon(Icons.info_outline),
              tooltip: "Informações",
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await syncRepo.syncData();
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
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            category.name.capitalize(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
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
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
