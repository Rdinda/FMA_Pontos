import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

typedef FavoriteCategoryGroup = ({Category category, List<Lyric> lyrics});

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static const _kExpandedCategoriesKey = 'favorites_expanded_category_ids';

  Future<List<FavoriteCategoryGroup>>? _favoritesFuture;
  Set<String>? _lastFavoriteIds;
  Set<String> _expandedCategoryIds = {};
  bool _expandedPrefsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadExpandedCategoryIds();
  }

  Future<void> _loadExpandedCategoryIds() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_kExpandedCategoriesKey) ?? [];
    if (!mounted) return;
    setState(() {
      _expandedCategoryIds = stored.toSet();
      _expandedPrefsLoaded = true;
    });
  }

  Future<void> _saveExpandedCategoryIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _kExpandedCategoriesKey,
      _expandedCategoryIds.toList(),
    );
  }

  void _pruneExpandedCategoryIds(Iterable<String> visibleCategoryIds) {
    final visible = visibleCategoryIds.toSet();
    final pruned = _expandedCategoryIds.where(visible.contains).toSet();
    if (pruned.length != _expandedCategoryIds.length) {
      setState(() => _expandedCategoryIds = pruned);
      _saveExpandedCategoryIds();
    }
  }

  void _onCategoryExpansionChanged(String categoryId, bool expanded) {
    setState(() {
      if (expanded) {
        _expandedCategoryIds.add(categoryId);
      } else {
        _expandedCategoryIds.remove(categoryId);
      }
    });
    _saveExpandedCategoryIds();
  }

  Future<List<FavoriteCategoryGroup>> _loadFavoritesData(
    SyncRepository repo,
    Set<String> favoriteIds,
  ) async {
    if (favoriteIds.isEmpty) return [];

    final categories = await repo.getCategories();
    final categoryMap = {for (var c in categories) c.id: c};
    final lyrics = await repo.getLyricsByIds(favoriteIds.toList());

    return _groupLyrics(lyrics, categoryMap);
  }

  /// Agrupa por categoria (nome A–Z); letras ordenadas por título.
  static List<FavoriteCategoryGroup> _groupLyrics(
    List<Lyric> lyrics,
    Map<String, Category> categoryMap,
  ) {
    final map = <String, List<Lyric>>{};
    for (final lyric in lyrics) {
      if (!categoryMap.containsKey(lyric.categoryId)) continue;
      map.putIfAbsent(lyric.categoryId, () => []).add(lyric);
    }

    final groups = map.entries.map((e) {
      final category = categoryMap[e.key]!;
      final sortedLyrics = List<Lyric>.from(e.value)
        ..sort(
          (a, b) =>
              a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
      return (category: category, lyrics: sortedLyrics);
    }).toList();

    groups.sort(
      (a, b) => a.category.name
          .toLowerCase()
          .compareTo(b.category.name.toLowerCase()),
    );
    return groups;
  }

  static List<Lyric> _playableLyricsInDisplayOrder(
    List<FavoriteCategoryGroup> groups,
  ) {
    return [
      for (final g in groups)
        for (final l in g.lyrics)
          if (AudioPlayerService.hasPlayableAudio(l)) l,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final favService = Provider.of<FavoritesService>(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_lastFavoriteIds == null ||
        !setEquals(_lastFavoriteIds, favService.favorites)) {
      _lastFavoriteIds = Set.from(favService.favorites);
      _favoritesFuture = _loadFavoritesData(repo, favService.favorites).then(
        (groups) {
          if (mounted) {
            _pruneExpandedCategoryIds(groups.map((g) => g.category.id));
          }
          return groups;
        },
      );
    }

    return FutureBuilder<List<FavoriteCategoryGroup>>(
      future: _favoritesFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final groups = snapshot.data ?? [];
        final playableLyrics = _playableLyricsInDisplayOrder(groups);

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
              Expanded(
                child: _buildBody(
                  context,
                  isLoading,
                  groups,
                  favService,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isLoading,
    List<FavoriteCategoryGroup> groups,
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

    if (isLoading || !_expandedPrefsLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (groups.isEmpty) {
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
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            for (final group in groups)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _FavoriteCategorySection(
                  category: group.category,
                  lyrics: group.lyrics,
                  isExpanded:
                      _expandedCategoryIds.contains(group.category.id),
                  onExpandedChanged: (expanded) => _onCategoryExpansionChanged(
                    group.category.id,
                    expanded,
                  ),
                  audioService: audioService,
                  favService: favService,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FavoriteCategorySection extends StatelessWidget {
  final Category category;
  final List<Lyric> lyrics;
  final bool isExpanded;
  final ValueChanged<bool> onExpandedChanged;
  final AudioPlayerService audioService;
  final FavoritesService favService;

  const _FavoriteCategorySection({
    required this.category,
    required this.lyrics,
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.audioService,
    required this.favService,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: StreamingTokens.cardRadius,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onExpandedChanged(!isExpanded),
            borderRadius: StreamingTokens.cardRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  _FavoriteCategoryLeading(category: category),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name.capitalize(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${lyrics.length} '
                          '${lyrics.length == 1 ? 'ponto' : 'pontos'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstCurve: Curves.easeOutCubic,
            secondCurve: Curves.easeInCubic,
            sizeCurve: Curves.easeOutCubic,
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final lyric in lyrics)
                    _FavoriteLyricTile(
                      lyric: lyric,
                      category: category,
                      audioService: audioService,
                      favService: favService,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
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
