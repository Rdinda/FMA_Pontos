import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/lyric.dart';
import '../../services/audio_player_service.dart';
import '../../services/favorites_service.dart';
import '../../services/sync_repository.dart';
import '../../theme/app_colors.dart';
import '../../theme/streaming_tokens.dart';
import '../../screens/lyric_view_screen.dart';
import '../../utils/lyric_sync.dart';
import '../../utils/string_extensions.dart';

/// Mini player persistente acima da bottom nav (Stitch Home_Acervo).
class StreamingMiniPlayer extends StatelessWidget {
  const StreamingMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerService>(
      builder: (context, audio, _) {
        final lyric = audio.currentLyric;
        if (lyric == null) return const SizedBox.shrink();

        final colorScheme = Theme.of(context).colorScheme;
        final progress = audio.duration.inMilliseconds > 0
            ? audio.position.inMilliseconds / audio.duration.inMilliseconds
            : 0.0;
        final activeLine = LyricSync.activeLine(
          content: lyric.content,
          position: audio.position,
          duration: audio.duration,
        );

        return FutureBuilder<String?>(
          future: _categoryName(context, lyric),
          builder: (context, catSnap) {
            final categoryName = catSnap.data ?? '';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: StreamingTokens.cardRadius,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LyricViewScreen(lyric: lyric),
                      ),
                    );
                  },
                  borderRadius: StreamingTokens.cardRadius,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MiniPlayerProgressBar(
                        progress: progress.clamp(0.0, 1.0),
                        trackColor: colorScheme.surfaceContainerHighest,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            _MiniArt(isPlaying: audio.isPlaying),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeLine?.isNotEmpty == true
                                        ? activeLine!
                                        : lyric.title.capitalize(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    _secondaryMiniLabel(
                                      lyric: lyric,
                                      categoryName: categoryName,
                                    ),
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
                            Consumer<FavoritesService>(
                              builder: (context, fav, _) {
                                final isFav = fav.isFavorite(lyric.id);
                                return IconButton(
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 22,
                                  ),
                                  color: isFav
                                      ? AppColors.primaryHighlight
                                      : colorScheme.onSurfaceVariant,
                                  onPressed: () =>
                                      fav.toggleFavorite(lyric.id),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 36,
                                    minHeight: 36,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                audio.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 28,
                              ),
                              color: colorScheme.onSurface,
                              onPressed: () => audio.togglePlayPause(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            if (audio.hasPlaylist)
                              IconButton(
                                icon: const Icon(Icons.skip_next_rounded),
                                color: colorScheme.onSurfaceVariant,
                                onPressed: audio.hasNext
                                    ? () => audio.skipNext()
                                    : null,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _secondaryMiniLabel({
    required Lyric lyric,
    required String categoryName,
  }) {
    final title = lyric.title.capitalize();
    if (categoryName.isNotEmpty) {
      return '$title • $categoryName';
    }
    return title;
  }

  Future<String?> _categoryName(BuildContext context, Lyric lyric) async {
    final repo = Provider.of<SyncRepository>(context, listen: false);
    final cat = await repo.getCategory(lyric.categoryId);
    return cat?.name.capitalize();
  }
}

/// Barra de progresso opaca — evita saveLayer/clip do [LinearProgressIndicator]
/// com fundo transparente, que dispara erros no Impeller a cada tick de áudio.
class _MiniPlayerProgressBar extends StatelessWidget {
  final double progress;
  final Color trackColor;

  const _MiniPlayerProgressBar({
    required this.progress,
    required this.trackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      width: double.infinity,
      child: ColoredBox(
        color: trackColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress,
            child: const ColoredBox(color: AppColors.primaryContainer),
          ),
        ),
      ),
    );
  }
}

class _MiniArt extends StatelessWidget {
  final bool isPlaying;

  const _MiniArt({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryContainer, Color(0xFF0E0E0E)],
        ),
      ),
      child: Center(
        child: Icon(
          isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
          color: Colors.white70,
          size: 20,
        ),
      ),
    );
  }
}
