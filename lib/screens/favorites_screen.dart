import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../widgets/category_player_widget.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';

/// Classe para armazenar lyric com informações da categoria
class LyricWithCategory {
  final Lyric lyric;
  final String categoryName;

  LyricWithCategory({required this.lyric, required this.categoryName});
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<void> _playAllFavorites() async {
    final favoritesService = Provider.of<FavoritesService>(
      context,
      listen: false,
    );
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );

    if (favoritesService.favorites.isEmpty) {
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Nenhuma música favorita.',
          isError: true,
        );
      }
      return;
    }

    // Buscar todas as letras favoritas
    final List<Lyric> favoriteLyrics = [];
    for (final lyricId in favoritesService.favorites) {
      final lyric = await repo.getLyric(lyricId);
      if (lyric != null) {
        favoriteLyrics.add(lyric);
      }
    }

    if (favoriteLyrics.isEmpty) {
      if (mounted) {
        SnackbarUtils.show(
          context,
          message: 'Nenhuma música favorita encontrada.',
          isError: true,
        );
      }
      return;
    }

    // Ordenar por título
    favoriteLyrics.sort((a, b) => a.title.compareTo(b.title));

    await audioService.playAll(favoriteLyrics);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gostei'),
        actions: [
          Consumer<FavoritesService>(
            builder: (context, favoritesService, child) {
              if (favoritesService.favorites.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: _playAllFavorites,
                icon: const Icon(Icons.play_circle_outline),
                tooltip: 'Tocar Todas',
              );
            },
          ),
        ],
      ),
      body: Consumer2<FavoritesService, SyncRepository>(
        builder: (context, favoritesService, repo, child) {
          if (!favoritesService.isLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favoritesService.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma música favorita',
                    style: TextStyle(fontSize: 18, color: colorScheme.outline),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toque no ícone de coração\npara adicionar favoritas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.outline.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          return FutureBuilder<List<LyricWithCategory>>(
            future: _getFavoriteLyricsWithCategory(
              favoritesService.favorites,
              repo,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final lyricsWithCategory = snapshot.data ?? [];

              if (lyricsWithCategory.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 60,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Músicas favoritas não encontradas',
                        style: TextStyle(color: colorScheme.outline),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: lyricsWithCategory.length,
                itemBuilder: (context, index) {
                  final item = lyricsWithCategory[index];
                  final lyric = item.lyric;
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
                        contentPadding: const EdgeInsets.only(
                          left: 4,
                          right: 16,
                        ),
                        leading: IconButton(
                          onPressed: () async {
                            await favoritesService.toggleFavorite(lyric.id);
                            if (!context.mounted) return;
                            SnackbarUtils.show(
                              context,
                              message: 'Removido dos favoritos',
                            );
                          },
                          icon: Icon(Icons.favorite, color: colorScheme.error),
                          tooltip: 'Remover dos favoritos',
                        ),
                        title: Text(
                          lyric.title.capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        subtitle: Text(
                          item.categoryName.capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onTap: () {
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
              );
            },
          );
        },
      ),
      bottomSheet: const CategoryPlayerWidget(),
    );
  }

  Future<List<LyricWithCategory>> _getFavoriteLyricsWithCategory(
    Set<String> favoriteIds,
    SyncRepository repo,
  ) async {
    final List<LyricWithCategory> result = [];

    // Buscar todas as categorias para criar um mapa de id -> nome
    final categories = await repo.getCategories();
    final categoryMap = <String, String>{};
    for (final cat in categories) {
      categoryMap[cat.id] = cat.name;
    }

    for (final id in favoriteIds) {
      final lyric = await repo.getLyric(id);
      if (lyric != null) {
        final categoryName = categoryMap[lyric.categoryId] ?? 'Categoria';
        result.add(LyricWithCategory(lyric: lyric, categoryName: categoryName));
      }
    }

    // Ordenar por título
    result.sort((a, b) => a.lyric.title.compareTo(b.lyric.title));
    return result;
  }
}
