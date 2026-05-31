import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'lyric_form_screen.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/auth_service.dart';
import '../services/favorites_service.dart';
import '../utils/lyric_sync.dart';
import '../utils/snackbar_utils.dart';
import '../utils/string_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/streaming_tokens.dart';
import '../widgets/streaming/streaming_scaffold.dart';
import '../widgets/streaming/streaming_navigation.dart';

class LyricViewScreen extends StatefulWidget {
  final Lyric lyric;

  const LyricViewScreen({super.key, required this.lyric});

  @override
  State<LyricViewScreen> createState() => _LyricViewScreenState();
}

class _LyricViewScreenState extends State<LyricViewScreen> {
  late Lyric _lyric;
  Category? _category;
  YoutubePlayerController? _youtubeController;
  _PlayerMode _playerMode = _PlayerMode.none;

  @override
  void initState() {
    super.initState();
    _lyric = widget.lyric;
    _loadCategory();
    _initYoutubePlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final audio = Provider.of<AudioPlayerService>(context, listen: false);
      final hasAudio =
          (_lyric.audioUrl?.trim().isNotEmpty ?? false) ||
          (_lyric.localAudioPath?.trim().isNotEmpty ?? false);
      if (hasAudio && audio.currentLyric?.id != _lyric.id) {
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
    _youtubeController?.dispose();
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

  void _showOptionsMenu(AuthService auth) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (auth.canEditLyrics)
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Editar'),
                onTap: () {
                  Navigator.pop(ctx);
                  _edit(context);
                },
              ),
            if (auth.canDeleteLyrics)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Excluir'),
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmDelete();
                },
              ),
          ],
        ),
      ),
    );
  }

  static const _lyricsCollapsedSize = 0.22;
  static const _lyricsMidSnapSize = 0.40;
  static const _lyricsExpandedSize = 0.95;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasVideo = _youtubeController != null;

    return StreamingScaffold(
      navContext: StreamingNavContext.standard,
      currentNavIndex: StreamingNavIndex.home,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lyricsBottomInset =
                constraints.maxHeight * _lyricsCollapsedSize;

            return Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(colorScheme),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: lyricsBottomInset),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            final repo = Provider.of<SyncRepository>(
                              context,
                              listen: false,
                            );
                            await repo.syncData();
                            final updated = await repo.getLyric(_lyric.id);
                            if (updated != null && mounted) {
                              _applyLyricUpdate(updated);
                            }
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Consumer<AudioPlayerService>(
                    builder: (context, audioService, _) {
                      final isCurrentLyric =
                          audioService.currentLyric?.id == _lyric.id;
                      final isPlaying = isCurrentLyric && audioService.isPlaying;
                      final duration = isCurrentLyric
                          ? audioService.duration
                          : Duration.zero;
                      final position = isCurrentLyric
                          ? audioService.position
                          : Duration.zero;
                      final hasAudio =
                          (_lyric.audioUrl?.trim().isNotEmpty ?? false) ||
                          (_lyric.localAudioPath?.trim().isNotEmpty ?? false);

                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          _AlbumArtPlaceholder(isPlaying: isPlaying),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _lyric.title.capitalize(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.headlineSmall
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
                                      final wasFav =
                                          favService.isFavorite(_lyric.id);
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
                                      isFav
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
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
                                progressIndicatorColor:
                                    AppColors.primaryContainer,
                              ),
                            ),
                          ],
                          if (hasAudio && _playerMode != _PlayerMode.video) ...[
                            const SizedBox(height: 24),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
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
                                        await audioService.seek(
                                          Duration(seconds: value.toInt()),
                                        );
                                      }
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            const SizedBox(height: 16),
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
                                  iconSize: 32,
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
                                      width: 64,
                                      height: 64,
                                      child: Icon(
                                        isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 36,
                                        color: AppColors.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: audioService.hasNext
                                      ? () => audioService.skipNext()
                                      : null,
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
                                    setState(
                                      () => _playerMode = _PlayerMode.audio,
                                    );
                                  } else {
                                    if (audioService.isPlaying) {
                                      await audioService.togglePlayPause();
                                    }
                                    _youtubeController?.pause();
                                    setState(
                                      () => _playerMode = _PlayerMode.video,
                                    );
                                  }
                                },
                                icon: Icon(
                                  _playerMode == _PlayerMode.video
                                      ? Icons.audiotrack
                                      : Icons.smart_display_outlined,
                                  size: 16,
                                ),
                                label: Text(
                                  _playerMode == _PlayerMode.video
                                      ? 'Áudio'
                                      : 'Vídeo',
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      colorScheme.surfaceContainerHigh,
                                  side: BorderSide(
                                    color: colorScheme.outlineVariant
                                        .withValues(alpha: 0.3),
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
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
                    ),
                  ],
                ),
                DraggableScrollableSheet(
                  initialChildSize: _lyricsCollapsedSize,
                  minChildSize: _lyricsCollapsedSize,
                  maxChildSize: _lyricsExpandedSize,
                  snap: true,
                  snapSizes: const [
                    _lyricsCollapsedSize,
                    _lyricsMidSnapSize,
                    _lyricsExpandedSize,
                  ],
                  builder: (context, scrollController) {
                    return Consumer<AudioPlayerService>(
                      builder: (context, audio, _) {
                        final isCurrent =
                            audio.currentLyric?.id == _lyric.id;
                        return _LyricsPanel(
                          content: _lyric.content,
                          scrollController: scrollController,
                          position: isCurrent
                              ? audio.position
                              : Duration.zero,
                          duration: isCurrent
                              ? audio.duration
                              : Duration.zero,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.expand_more_rounded, size: 28),
          ),
          Column(
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
          Consumer<AuthService>(
            builder: (context, auth, _) {
              if (!auth.canEditLyrics && !auth.canDeleteLyrics) {
                return const SizedBox(width: 48);
              }
              return IconButton(
                onPressed: () => _showOptionsMenu(auth),
                icon: const Icon(Icons.more_vert),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AlbumArtPlaceholder extends StatelessWidget {
  final bool isPlaying;

  const _AlbumArtPlaceholder({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          borderRadius: StreamingTokens.cardRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryContainer.withValues(alpha: 0.5),
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
            size: 80,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

class _LyricsPanel extends StatelessWidget {
  final String content;
  final ScrollController scrollController;
  final Duration position;
  final Duration duration;

  const _LyricsPanel({
    required this.content,
    required this.scrollController,
    required this.position,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lines = LyricSync.parseLines(content);
    final activeIndex = LyricSync.activeLineIndex(
      position: position,
      duration: duration,
      lineCount: lines.length,
    );

    return Material(
      color: colorScheme.surfaceContainer,
      borderRadius: StreamingTokens.sheetRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: StreamingTokens.sheetRadius,
          border: Border(
            top: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.2),
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemCount: lines.length,
                itemBuilder: (context, i) {
                  final isActive = lines.isNotEmpty && i == activeIndex;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      lines[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isActive ? 22 : 16,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.7,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PlayerMode { none, audio, video }
