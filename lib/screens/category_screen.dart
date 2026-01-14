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
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../widgets/app_info_bottom_sheet.dart';

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
    SnackbarUtils.show(
      context,
      message: isAnonymous
          ? 'Faça login com Google para adicionar letras'
          : 'Você não tem permissão para esta ação',
      isError: true,
      action: isAnonymous
          ? SnackBarAction(
              label: 'Entrar',
              onPressed: () => showAppInfoBottomSheet(context),
            )
          : null,
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
    final codeController = TextEditingController(text: widget.category.code);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Editar Categoria"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nome"),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: "Código (Prefixo)"),
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
              final updatedCat = Category(
                id: widget.category.id,
                name: nameController.text.trim(),
                code: codeController.text.trim().toUpperCase(),
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
        SnackbarUtils.show(context, message: 'Nenhuma letra nesta categoria.');
      }
      return;
    }

    await audioService.playAll(lyrics);
  }

  Widget _buildMusicalLyricTile(
    BuildContext context,
    Lyric lyric,
    Category category,
    AudioPlayerService audioService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaying =
        audioService.currentLyric?.id == lyric.id && audioService.isPlaying;
    final isCurrent = audioService.currentLyric?.id == lyric.id;
    final hasAudio =
        (lyric.audioUrl?.isNotEmpty ?? false) ||
        (lyric.localAudioPath?.isNotEmpty ?? false);
    final hasVideo = lyric.youtubeLink?.isNotEmpty ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrent
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isCurrent
                ? colorScheme.primary
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (isCurrent)
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: isPlaying
                ? Icon(Icons.graphic_eq, color: colorScheme.onPrimary)
                : Text(
                    lyric.sequenceNumber.toString(),
                    style: TextStyle(
                      color: isCurrent
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
        title: Text(
          lyric.title.capitalize(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
            color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        subtitle: Row(
          children: [
            if (hasAudio) ...[
              Icon(Icons.music_note, size: 14, color: colorScheme.secondary),
              const SizedBox(width: 4),
            ],
            if (hasVideo) ...[
              Icon(Icons.videocam, size: 14, color: colorScheme.tertiary),
              const SizedBox(width: 4),
            ],
            Text(
              "${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasAudio)
              IconButton(
                icon: Icon(
                  isCurrent && isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  if (isCurrent && isPlaying) {
                    audioService.pause();
                  } else {
                    audioService.play(lyric);
                  }
                },
              ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LyricViewScreen(lyric: lyric)),
          );
        },
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
            child: Consumer<AudioPlayerService>(
              builder: (context, audioService, child) {
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: lyrics.length,
                  itemBuilder: (ctx, i) {
                    final lyric = lyrics[i];
                    return _buildMusicalLyricTile(
                      context,
                      lyric,
                      widget.category,
                      audioService,
                    );
                  },
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
