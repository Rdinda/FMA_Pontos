import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../services/sync_repository.dart';
import '../utils/category_artwork.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../widgets/streaming/track_list_tile.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';
import 'lyric_view_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<MapEntry<Lyric, Category>>>? _favoritesFuture;
  Set<String>? _lastFavoriteIds;

  Future<List<MapEntry<Lyric, Category>>> _loadFavoritesData(
    SyncRepository repo,
    Set<String> favoriteIds,
  ) async {
    if (favoriteIds.isEmpty) return [];

    final categories = await repo.getCategories();
    final categoryMap = {for (var c in categories) c.id: c};

    final List<MapEntry<Lyric, Category>> results = [];
    for (final id in favoriteIds) {
      final lyric = await repo.getLyric(id);
      if (lyric != null) {
        final category = categoryMap[lyric.categoryId];
        if (category != null) {
          results.add(MapEntry(lyric, category));
        }
      }
    }

    return results;
  }

  /// Agrupa favoritos por categoria (nome A–Z); letras ordenadas por título.
  static List<({Category category, List<Lyric> lyrics})> _groupByCategory(
    List<MapEntry<Lyric, Category>> data,
  ) {
    final map = <String, List<MapEntry<Lyric, Category>>>{};
    for (final entry in data) {
      map.putIfAbsent(entry.value.id, () => []).add(entry);
    }

    final groups = map.entries.map((e) {
      final category = e.value.first.value;
      final lyrics = e.value.map((x) => x.key).toList()
        ..sort(
          (a, b) =>
              a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
      return (category: category, lyrics: lyrics);
    }).toList();

    groups.sort(
      (a, b) => a.category.name
          .toLowerCase()
          .compareTo(b.category.name.toLowerCase()),
    );
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final favService = Provider.of<FavoritesService>(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_lastFavoriteIds == null ||
        !setEquals(_lastFavoriteIds, favService.favorites)) {
      _lastFavoriteIds = Set.from(favService.favorites);
      _favoritesFuture = _loadFavoritesData(repo, favService.favorites);
    }

    return FutureBuilder<List<MapEntry<Lyric, Category>>>(
      future: _favoritesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final data = snapshot.data ?? [];
        final playableLyrics = data
            .map((e) => e.key)
            .where(AudioPlayerService.hasPlayableAudio)
            .toList();

        return StreamingScaffold(
          navContext: StreamingNavContext.standard,
          currentNavIndex: StreamingNavIndex.favorites,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'FMA Pontos',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seus Pontos Salvos',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${favService.favorites.length} ${favService.favorites.length == 1 ? 'ponto marcado' : 'pontos marcados'} como favoritos',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLoading && playableLyrics.isNotEmpty)
                      Material(
                        color: AppColors.primaryContainer,
                        shape: const CircleBorder(),
                        elevation: 8,
                        shadowColor:
                            AppColors.primaryContainer.withValues(alpha: 0.4),
                        child: InkWell(
                          onTap: () async {
                            await Provider.of<AudioPlayerService>(
                              context,
                              listen: false,
                            ).playAll(playableLyrics);
                          },
                          customBorder: const CircleBorder(),
                          child: const SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.onPrimaryContainer,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: StreamingTokens.spacingMd),
              Expanded(child: _buildBody(context, isLoading, data, favService)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isLoading,
    List<MapEntry<Lyric, Category>> data,
    FavoritesService favService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    if (favService.favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum favorito ainda',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Suas músicas favoritas aparecerão aqui.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.clear_all),
              label: const Text('Limpar lista de favoritos'),
              onPressed: () async {
                await favService.clearAll();
                if (context.mounted) {
                  SnackbarUtils.show(
                    context,
                    message: 'Lista de favoritos limpa com sucesso.',
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    final groups = _groupByCategory(data);

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, _) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            for (final group in groups)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: StreamingTokens.cardRadius,
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    childrenPadding: const EdgeInsets.only(bottom: 4),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: StreamingTokens.cardRadius,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: StreamingTokens.cardRadius,
                    ),
                    leading: _FavoriteCategoryLeading(category: group.category),
                    title: Text(
                      group.category.name.capitalize(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${group.lyrics.length} '
                      '${group.lyrics.length == 1 ? 'ponto' : 'pontos'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    iconColor: colorScheme.onSurfaceVariant,
                    collapsedIconColor: colorScheme.onSurfaceVariant,
                    children: [
                      for (final lyric in group.lyrics)
                        _FavoriteLyricTile(
                          lyric: lyric,
                          category: group.category,
                          audioService: audioService,
                          favService: favService,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FavoriteCategoryLeading extends StatelessWidget {
  final Category category;

  const _FavoriteCategoryLeading({required this.category});

  @override
  Widget build(BuildContext context) {
    final asset = categoryImageAsset(category);
    const size = 44.0;

    if (asset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          asset,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, _, _) => _placeholder(context, size),
        ),
      );
    }
    return _placeholder(context, size);
  }

  Widget _placeholder(BuildContext context, double size) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Icon(
        Icons.category_rounded,
        color: colorScheme.onSurfaceVariant,
        size: 22,
      ),
    );
  }
}

class _FavoriteLyricTile extends StatelessWidget {
  final Lyric lyric;
  final Category category;
  final AudioPlayerService audioService;
  final FavoritesService favService;

  const _FavoriteLyricTile({
    required this.lyric,
    required this.category,
    required this.audioService,
    required this.favService,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrent = audioService.currentLyric?.id == lyric.id;
    final isPlaying = isCurrent && audioService.isPlaying;
    final hasAudio = AudioPlayerService.hasPlayableAudio(lyric);

    return GlassTrackTile(
      title: lyric.title.capitalize(),
      subtitle:
          '${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}',
      isCurrent: isCurrent,
      isPlaying: isPlaying,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LyricViewScreen(lyric: lyric)),
        );
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasAudio)
            IconButton(
              icon: Icon(
                isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: AppColors.primaryContainer,
              ),
              onPressed: () {
                if (isPlaying) {
                  audioService.pause();
                } else {
                  audioService.play(lyric);
                }
              },
            ),
          IconButton(
            icon: const Icon(
              Icons.favorite_rounded,
              color: AppColors.primaryHighlight,
            ),
            onPressed: () async {
              await favService.removeFavorite(lyric.id);
              if (context.mounted) {
                SnackbarUtils.show(
                  context,
                  message: 'Removido dos favoritos',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
