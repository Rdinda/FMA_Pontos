import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/audio_player_service.dart';
import '../services/play_stats_service.dart';
import '../services/sync_repository.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';

class TopPlayedScreen extends StatefulWidget {
  const TopPlayedScreen({super.key});

  @override
  State<TopPlayedScreen> createState() => _TopPlayedScreenState();
}

class _TopPlayedScreenState extends State<TopPlayedScreen> {
  final PlayStatsService _playStatsService = PlayStatsService();
  bool _isLoading = true;
  String? _errorMessage;
  List<LyricWithStats> _topPlayedList = [];
  Map<String, Category> _categoryMap = {};

  @override
  void initState() {
    super.initState();
    _fetchTopPlayed();
  }

  Future<void> _fetchTopPlayed() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = Provider.of<SyncRepository>(context, listen: false);
      final stats = await _playStatsService.getTopPlayed(limit: 50);
      final categories = await repo.getCategories();
      final catMap = {for (var c in categories) c.id: c};

      if (mounted) {
        setState(() {
          _topPlayedList = stats;
          _categoryMap = catMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Não foi possível carregar as estatísticas.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final playableLyrics = _topPlayedList
        .map((e) => e.lyric)
        .where(
          (l) =>
              (l.audioUrl?.isNotEmpty ?? false) ||
              (l.localAudioPath?.isNotEmpty ?? false),
        )
        .toList();

    return StreamingScaffold(
      navContext: StreamingNavContext.standard,
      currentNavIndex: StreamingNavIndex.top,
      appBar: StreamingAppBar(
        actions: [
          if (!_isLoading && _errorMessage == null && playableLyrics.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              tooltip: 'Tocar Todas',
              onPressed: () async {
                await Provider.of<AudioPlayerService>(
                  context,
                  listen: false,
                ).playAll(playableLyrics);
              },
            ),
        ],
      ),
      body: _buildBody(context, playableLyrics, colorScheme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    List<Lyric> playableLyrics,
    ColorScheme colorScheme,
  ) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _fetchTopPlayed,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_topPlayedList.isEmpty) {
      return RefreshIndicator(
        onRefresh: _fetchTopPlayed,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 120),
            Center(child: Text('Nenhum ponto acessado ainda')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchTopPlayed,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mais Acessados',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: StreamingTokens.cardRadius,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/main.webp',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            ColoredBox(color: colorScheme.surfaceContainerHigh),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryHighlight.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'PLAYLIST EM DESTAQUE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: AppColors.primaryHighlight,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Mix de Axé',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (playableLyrics.isNotEmpty)
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: Material(
                            color: AppColors.primaryContainer,
                            shape: const CircleBorder(),
                            elevation: 8,
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
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          Consumer<AudioPlayerService>(
            builder: (context, audioService, _) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final statsItem = _topPlayedList[i];
                    final lyric = statsItem.lyric;
                    final category = _categoryMap[lyric.categoryId];
                    final rank = i + 1;
                    final isCurrent =
                        audioService.currentLyric?.id == lyric.id;
                    final isPlaying = isCurrent && audioService.isPlaying;
                    final hasAudio =
                        (lyric.audioUrl?.isNotEmpty ?? false) ||
                        (lyric.localAudioPath?.isNotEmpty ?? false);

                    return _RankCard(
                      rank: rank,
                      title: lyric.title.capitalize(),
                      subtitle: category != null
                          ? '${statsItem.playCount} ${statsItem.playCount == 1 ? 'acesso' : 'acessos'} • ${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}'
                          : '${statsItem.playCount} acessos',
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
                      onPlay: hasAudio
                          ? () {
                              if (isPlaying) {
                                audioService.pause();
                              } else {
                                audioService.play(lyric);
                              }
                            }
                          : null,
                    );
                  },
                  childCount: _topPlayedList.length,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  final int rank;
  final String title;
  final String subtitle;
  final bool isCurrent;
  final bool isPlaying;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  const _RankCard({
    required this.rank,
    required this.title,
    required this.subtitle,
    this.isCurrent = false,
    this.isPlaying = false,
    this.onTap,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color trophyColor;
    Widget rankWidget;
    if (isPlaying) {
      rankWidget = Icon(
        Icons.graphic_eq_rounded,
        color: AppColors.primaryContainer,
      );
      trophyColor = AppColors.primaryContainer;
    } else {
      switch (rank) {
        case 1:
          trophyColor = const Color(0xFFFFD700);
          rankWidget = Icon(Icons.emoji_events, color: trophyColor, size: 28);
        case 2:
          trophyColor = const Color(0xFFC0C0C0);
          rankWidget = Icon(Icons.emoji_events, color: trophyColor, size: 28);
        case 3:
          trophyColor = const Color(0xFFCD7F32);
          rankWidget = Icon(Icons.emoji_events, color: trophyColor, size: 28);
        default:
          rankWidget = Text(
            '$rank',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: colorScheme.onSurfaceVariant,
            ),
          );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: StreamingTokens.cardRadius,
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(width: 40, child: Center(child: rankWidget)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onPlay != null)
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: colorScheme.onSurfaceVariant,
                      size: 32,
                    ),
                    onPressed: onPlay,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
