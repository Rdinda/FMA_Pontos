import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
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
  final String categoryCode;

  LyricWithCategory({
    required this.lyric,
    required this.categoryName,
    required this.categoryCode,
  });
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

              return Consumer<AudioPlayerService>(
                builder: (context, audioService, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: lyricsWithCategory.length,
                    itemBuilder: (context, index) {
                      final item = lyricsWithCategory[index];
                      final lyric = item.lyric;
                      final isPlaying =
                          audioService.currentLyric?.id == lyric.id &&
                          audioService.isPlaying;
                      final isCurrent =
                          audioService.currentLyric?.id == lyric.id;
                      final hasAudio =
                          (lyric.audioUrl?.isNotEmpty ?? false) ||
                          (lyric.localAudioPath?.isNotEmpty ?? false);

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? colorScheme.primaryContainer.withValues(
                                  alpha: 0.3,
                                )
                              : colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCurrent
                                ? colorScheme.primary.withValues(alpha: 0.5)
                                : colorScheme.outlineVariant.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
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
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Center(
                              child: isPlaying
                                  ? Icon(
                                      Icons.graphic_eq,
                                      color: colorScheme.onPrimary,
                                    )
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
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isCurrent
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${item.categoryCode}${lyric.sequenceNumber.toString().padLeft(2, '0')} • ${item.categoryName.capitalize()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await favoritesService.toggleFavorite(
                                    lyric.id,
                                  );
                                  if (!context.mounted) return;
                                  SnackbarUtils.show(
                                    context,
                                    message: 'Removido dos favoritos',
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: colorScheme.error,
                                ),
                                tooltip: 'Remover dos favoritos',
                              ),
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
                            ],
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
                      );
                    },
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

    // Buscar todas as categorias para criar um mapa de id -> Category
    final categories = await repo.getCategories();
    final categoryMap = <String, Category>{};
    for (final cat in categories) {
      categoryMap[cat.id] = cat;
    }

    for (final id in favoriteIds) {
      final lyric = await repo.getLyric(id);
      if (lyric != null) {
        final category = categoryMap[lyric.categoryId];
        result.add(
          LyricWithCategory(
            lyric: lyric,
            categoryName: category?.name ?? 'Categoria',
            categoryCode: category?.code ?? '??',
          ),
        );
      }
    }

    // Ordenar por título
    result.sort((a, b) => a.lyric.title.compareTo(b.lyric.title));
    return result;
  }
}
