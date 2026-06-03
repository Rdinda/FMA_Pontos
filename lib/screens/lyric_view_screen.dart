import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'lyric_form_screen.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/play_stats_service.dart';
import '../services/auth_service.dart';
import '../services/favorites_service.dart';
import '../utils/lyric_sync.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';
import '../widgets/app_info_bottom_sheet.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';
import '../widgets/streaming/player_expansion.dart';

const _kLyricsSheetCollapsedHeight = 56.0;
const _kSheetHandleHeight = 40.0;
const _kCompactNowPlayingBarHeight = 64.0;

class LyricViewScreen extends StatefulWidget {
  final Lyric lyric;
  final bool fromMiniPlayer;

  const LyricViewScreen({
    super.key,
    required this.lyric,
    this.fromMiniPlayer = false,
  });

  @override
  State<LyricViewScreen> createState() => _LyricViewScreenState();
}

class _LyricViewScreenState extends State<LyricViewScreen>
    with SingleTickerProviderStateMixin {
  late Lyric _lyric;
  Category? _category;
  YoutubePlayerController? _youtubeController;
  _PlayerMode _playerMode = _PlayerMode.none;
  final PlayStatsService _playStatsService = PlayStatsService();
  final ScrollController _lyricsScrollController = ScrollController();
  AudioPlayerService? _audioService;
  double _sheetSize = 0;
  bool _sheetExpanded = false;
  late AnimationController _sheetSnapController;
  Animation<double>? _sheetSnapAnimation;
  double? _collapsedFraction;

  void _toggleSheet() {
    if (_sheetSnapController.isAnimating) return;
    _animateSheet(expanded: !_sheetExpanded);
  }

  void _animateSheet({required bool expanded}) {
    setState(() => _sheetExpanded = expanded);
    final target = expanded
        ? _lyricsExpandedSize
        : (_collapsedFraction ?? _kLyricsSheetCollapsedHeight / 600);
    _sheetSnapAnimation = Tween<double>(begin: _sheetSize, end: target).animate(
      CurvedAnimation(
        parent: _sheetSnapController,
        curve: Curves.easeOutCubic,
      ),
    );
    _sheetSnapController.forward(from: 0);
  }

  bool get _isCurrentLyric =>
      _audioService?.currentLyric?.id == _lyric.id;

  bool get _isPlaying => _isCurrentLyric && (_audioService?.isPlaying ?? false);

  Duration get _playbackDuration => _isCurrentLyric
      ? (_audioService?.duration ?? Duration.zero)
      : Duration.zero;

  Duration get _playbackPosition => _isCurrentLyric
      ? (_audioService?.position ?? Duration.zero)
      : Duration.zero;

  void _onAudioServiceChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _sheetSnapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    )..addListener(() {
        final animation = _sheetSnapAnimation;
        if (animation != null && mounted) {
          setState(() => _sheetSize = animation.value);
        }
      });
    _lyric = widget.lyric;
    _playStatsService.incrementAccessCount(_lyric.id);
    _loadCategory();
    _initYoutubePlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final audio = Provider.of<AudioPlayerService>(context, listen: false);
      _audioService = audio;
      _audioService!.addListener(_onAudioServiceChanged);
      final hasAudio = AudioPlayerService.hasPlayableAudio(_lyric);
      if (hasAudio) {
        if (audio.currentLyric?.id != _lyric.id) {
          unawaited(audio.selectLyric(_lyric));
        }
        setState(() => _playerMode = _PlayerMode.audio);
      } else if (audio.currentLyric?.id == _lyric.id) {
        setState(() => _playerMode = _PlayerMode.audio);
      }
    });
  }

  Future<void> _loadCategory() async {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final cat = await repo.getCategory(_lyric.categoryId);
    if (mounted && cat != null) setState(() => _category = cat);
  }

  void _initYoutubePlayer() {
    if (_lyric.youtubeLink != null) {
      final videoId = YoutubePlayer.convertUrlToId(_lyric.youtubeLink!);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            enableCaption: true,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioService?.removeListener(_onAudioServiceChanged);
    _sheetSnapController.dispose();
    _youtubeController?.dispose();
    _lyricsScrollController.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    final hasAudio =
        (_lyric.audioUrl?.trim().isNotEmpty ?? false) ||
        (_lyric.localAudioPath?.trim().isNotEmpty ?? false);
    if (!hasAudio) return;

    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );
    await audioService.play(_lyric);
    setState(() => _playerMode = _PlayerMode.audio);
  }

  void _edit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            LyricFormScreen(categoryId: _lyric.categoryId, lyric: _lyric),
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context);
    } else if (context.mounted) {
      final repo = Provider.of<SyncRepository>(context, listen: false);
      final updated = await repo.getLyric(_lyric.id);
      if (updated != null) _applyLyricUpdate(updated);
    }
  }

  void _applyLyricUpdate(Lyric updated) {
    setState(() {
      _lyric = updated;
      _youtubeController?.dispose();
      _youtubeController = null;
      _initYoutubePlayer();
      final hasAudio =
          (_lyric.audioUrl?.trim().isNotEmpty ?? false) ||
          (_lyric.localAudioPath?.trim().isNotEmpty ?? false);
      final hasVideo = _youtubeController != null;
      if (_playerMode == _PlayerMode.audio && !hasAudio) {
        _playerMode = _PlayerMode.none;
      }
      if (_playerMode == _PlayerMode.video && !hasVideo) {
        _playerMode = _PlayerMode.none;
      }
    });
  }

  String _formatDuration(Duration duration) {
    final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Letra?'),
        content: const Text('Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = Provider.of<SyncRepository>(context, listen: false);
              await repo.deleteLyric(_lyric.id);
              if (mounted) {
                Navigator.pop(context);
                SnackbarUtils.show(
                  context,
                  message: 'Letra excluída com sucesso.',
                );
              }
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static const _lyricsExpandedSize = 0.95;
  static const _lyricsContentMinFraction = 0.42;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasVideo = _youtubeController != null;

    return StreamingScaffold(
      navContext: StreamingNavContext.standard,
      currentNavIndex: StreamingNavIndex.home,
      showMiniPlayer: false,
      showBottomNav: false,
      body: _buildPlayerBody(theme, colorScheme, hasVideo),
    );
  }

  Widget _buildPlayerBody(
    ThemeData theme,
    ColorScheme colorScheme,
    bool hasVideo,
  ) {
    final shellBody = SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bodyHeight = constraints.maxHeight;
          final collapsedSize = _kLyricsSheetCollapsedHeight / bodyHeight;
          _collapsedFraction = collapsedSize;
          if (_sheetSize == 0) {
            _sheetSize = collapsedSize;
          }
          final effectiveSheetSize = _sheetSize.clamp(
            collapsedSize,
            _lyricsExpandedSize,
          );
          final showFullPlayer = !_sheetExpanded;
          final showCompactBar = _sheetExpanded;
          final showLyricsContent =
              effectiveSheetSize >= _lyricsContentMinFraction;

          final sheetTopInset =
              showCompactBar ? _kCompactNowPlayingBarHeight : 0.0;
          final maxSheetHeight = bodyHeight - sheetTopInset;
          final expandProgress = ((effectiveSheetSize - collapsedSize) /
                  (_lyricsExpandedSize - collapsedSize))
              .clamp(0.0, 1.0);
          final sheetPixelHeight = showCompactBar
              ? _kLyricsSheetCollapsedHeight +
                  expandProgress *
                      (maxSheetHeight - _kLyricsSheetCollapsedHeight)
              : bodyHeight * effectiveSheetSize;

          final playerColumn = Column(
            children: [
              if (!showCompactBar) _buildHeader(colorScheme),
              if (showFullPlayer)
                Expanded(
                  child: _audioService == null
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  8,
                                  24,
                                  4,
                                ),
                                child: PlayerAlbumArt(
                                  lyricId: _lyric.id,
                                  isPlaying: _isPlaying,
                                  expand: true,
                                  heroEnabled: widget.fromMiniPlayer,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                              child: _buildPlayerControls(
                                theme: theme,
                                colorScheme: colorScheme,
                                hasVideo: hasVideo,
                                audioService: _audioService!,
                              ),
                            ),
                          ],
                        ),
                )
              else
                const Spacer(),
              if (showFullPlayer)
                SizedBox(height: _kLyricsSheetCollapsedHeight),
            ],
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              playerColumn,
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: sheetPixelHeight,
                child: _LyricsPanel(
                  content: _lyric.content,
                  lyricsScrollController: _lyricsScrollController,
                  showLyricsContent: showLyricsContent,
                  title: _lyric.title.capitalize(),
                  onToggle: _toggleSheet,
                ),
              ),
              if (showCompactBar)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: _kCompactNowPlayingBarHeight,
                  child: Material(
                    color: colorScheme.surface,
                    elevation: 2,
                    child: _buildCompactNowPlayingBar(colorScheme),
                  ),
                ),
            ],
          );
        },
      ),
    );

    return shellBody;
  }

  Widget _buildPlayerControls({
    required ThemeData theme,
    required ColorScheme colorScheme,
    required bool hasVideo,
    required AudioPlayerService audioService,
  }) {
    final isCurrentLyric = _isCurrentLyric;
    final isPlaying = _isPlaying;
    final duration = _playbackDuration;
    final position = _playbackPosition;
    final hasAudio =
        (_lyric.audioUrl?.trim().isNotEmpty ?? false) ||
        (_lyric.localAudioPath?.trim().isNotEmpty ?? false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _lyric.title.capitalize(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _category?.name.capitalize() ?? '',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Consumer<FavoritesService>(
              builder: (context, favService, _) {
                final isFav = favService.isFavorite(_lyric.id);
                return IconButton(
                  onPressed: () async {
                    final wasFav = favService.isFavorite(_lyric.id);
                    await favService.toggleFavorite(_lyric.id);
                    if (!context.mounted) return;
                    SnackbarUtils.show(
                      context,
                      message: wasFav
                          ? 'Removido dos favoritos'
                          : 'Adicionado aos favoritos',
                    );
                  },
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    size: 28,
                  ),
                  color: isFav
                      ? AppColors.primaryHighlight
                      : colorScheme.onSurfaceVariant,
                );
              },
            ),
          ],
        ),
        if (_playerMode == _PlayerMode.video && hasVideo) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: StreamingTokens.cardRadius,
            child: YoutubePlayer(
              controller: _youtubeController!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.primaryContainer,
            ),
          ),
        ],
        if (hasAudio && _playerMode != _PlayerMode.video) ...[
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: AppColors.primaryContainer,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
            ),
            child: Slider(
              min: 0,
              max: duration.inSeconds.toDouble() > 0
                  ? duration.inSeconds.toDouble()
                  : 1.0,
              value: position.inSeconds.toDouble().clamp(
                0,
                duration.inSeconds.toDouble() > 0
                    ? duration.inSeconds.toDouble()
                    : 1.0,
              ),
              onChanged: isCurrentLyric
                  ? (value) async {
                      await audioService.seek(Duration(seconds: value.toInt()));
                    }
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(position),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  _formatDuration(duration),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: audioService.hasPlaylist
                    ? () => audioService.toggleRepeat()
                    : null,
                icon: Icon(
                  audioService.isRepeatEnabled
                      ? Icons.repeat_one
                      : Icons.repeat,
                  color: audioService.isRepeatEnabled
                      ? AppColors.primaryContainer
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              IconButton(
                onPressed: audioService.hasPrevious
                    ? () => audioService.skipPrevious()
                    : null,
                icon: const Icon(Icons.skip_previous_rounded),
                iconSize: 28,
                color: colorScheme.onSurface,
              ),
              Material(
                color: AppColors.primaryContainer,
                shape: const CircleBorder(),
                elevation: 8,
                child: InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await audioService.togglePlayPause();
                    } else {
                      await _togglePlay();
                    }
                  },
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 32,
                      color: AppColors.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    audioService.hasNext ? () => audioService.skipNext() : null,
                icon: const Icon(Icons.skip_next_rounded),
                iconSize: 32,
                color: colorScheme.onSurface,
              ),
              const SizedBox(width: 48),
            ],
          ),
        ],
        if (hasVideo) ...[
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              onPressed: () async {
                if (_playerMode == _PlayerMode.video) {
                  setState(() => _playerMode = _PlayerMode.audio);
                } else {
                  if (audioService.isPlaying) {
                    await audioService.togglePlayPause();
                  }
                  _youtubeController?.pause();
                  setState(() => _playerMode = _PlayerMode.video);
                }
              },
              icon: Icon(
                _playerMode == _PlayerMode.video
                    ? Icons.audiotrack
                    : Icons.smart_display_outlined,
                size: 16,
              ),
              label: Text(
                _playerMode == _PlayerMode.video ? 'Áudio' : 'Vídeo',
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHigh,
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ],
        if (!hasAudio && !hasVideo) ...[
          const SizedBox(height: 24),
          Text(
            'Sem mídia para tocar.',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.expand_more_rounded, size: 28),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'PLAYLIST',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Text(
                  'Reproduzindo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildLyricOptionsMenu(context),
        ],
      ),
    );
  }

  Widget _buildCompactNowPlayingBar(ColorScheme colorScheme) {
    final audio = _audioService;

    return Material(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.expand_more_rounded, size: 28),
            ),
            if (audio != null) ...[
              PlayerAlbumArt(
                lyricId: _lyric.id,
                isPlaying: _isPlaying,
                compact: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _lyric.title.capitalize(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _category?.name.capitalize() ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (_isPlaying) {
                    await audio.togglePlayPause();
                  } else {
                    await _togglePlay();
                  }
                },
                icon: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 28,
                ),
              ),
            ],
            _buildLyricOptionsMenu(context),
          ],
        ),
      ),
    );
  }

  void _showLoginRequired(BuildContext context, String action) {
    SnackbarUtils.show(
      context,
      message: 'Faça login com Google para $action',
      isError: true,
      action: SnackBarAction(
        label: 'Entrar',
        onPressed: () => showAppInfoBottomSheet(context),
      ),
    );
  }

  Widget _buildLyricOptionsMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        final showEdit = auth.canEditLyrics;
        final showDelete = auth.canDeleteLyrics;

        if (!showEdit && !showDelete) {
          return const SizedBox(width: 48);
        }

        return PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: colorScheme.onSurfaceVariant,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                if (auth.isAnonymous) {
                  _showLoginRequired(context, 'editar letras');
                } else {
                  _edit(context);
                }
              case 'delete':
                _confirmDelete();
            }
          },
          itemBuilder: (context) => [
            if (showEdit)
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Editar'),
                  ],
                ),
              ),
            if (showDelete)
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Excluir', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LyricsPanel extends StatelessWidget {
  final String content;
  final String title;
  final ScrollController lyricsScrollController;
  final bool showLyricsContent;
  final VoidCallback onToggle;

  const _LyricsPanel({
    required this.content,
    required this.title,
    required this.lyricsScrollController,
    required this.showLyricsContent,
    required this.onToggle,
  });

  Widget _handleBar(ColorScheme colorScheme) {
    return Container(
      width: 48,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _tapHandle({required Widget child}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final lines = LyricSync.parseLines(content);

    if (!showLyricsContent) {
      return Material(
        color: AppColors.lyricsPanelBackground,
        borderRadius: StreamingTokens.sheetRadius,
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        shadowColor: Colors.black54,
        child: _tapHandle(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _handleBar(colorScheme),
                const SizedBox(height: 8),
                Text(
                  'Letra',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: AppColors.lyricsPanelBackground,
      borderRadius: StreamingTokens.sheetRadius,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tapHandle(
            child: SizedBox(
              height: _kSheetHandleHeight,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_handleBar(colorScheme)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reproduzindo agora',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Letra',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.25),
          ),
          Expanded(
            child: ListView.builder(
              controller: lyricsScrollController,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              itemCount: lines.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    lines[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.85,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum _PlayerMode { none, audio, video }
