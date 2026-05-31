import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/audio_player_service.dart';
import '../services/favorites_service.dart';
import '../services/sync_repository.dart';
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

    results.sort(
      (a, b) => a.key.title.toLowerCase().compareTo(b.key.title.toLowerCase()),
    );
    return results;
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
            .where(
              (l) =>
                  (l.audioUrl?.isNotEmpty ?? false) ||
                  (l.localAudioPath?.isNotEmpty ?? false),
            )
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

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, _) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            final entry = data[i];
            final lyric = entry.key;
            final category = entry.value;
            final isCurrent = audioService.currentLyric?.id == lyric.id;
            final isPlaying = isCurrent && audioService.isPlaying;
            final hasAudio =
                (lyric.audioUrl?.isNotEmpty ?? false) ||
                (lyric.localAudioPath?.isNotEmpty ?? false);

            return GlassTrackTile(
              title: lyric.title.capitalize(),
              subtitle:
                  '${category.name.capitalize()} • ${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}',
              isCurrent: isCurrent,
              isPlaying: isPlaying,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LyricViewScreen(lyric: lyric),
                  ),
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
                    icon: Icon(
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
          },
        );
      },
    );
  }
}
