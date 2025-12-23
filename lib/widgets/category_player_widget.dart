import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/audio_player_service.dart';
import '../utils/string_extensions.dart';

/// A compact player widget that appears at the bottom of the CategoryScreen
/// when a playlist is active.
class CategoryPlayerWidget extends StatefulWidget {
  const CategoryPlayerWidget({super.key});

  @override
  State<CategoryPlayerWidget> createState() => _CategoryPlayerWidgetState();
}

class _CategoryPlayerWidgetState extends State<CategoryPlayerWidget> {
  bool _showLyrics = false;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    // Calculate max height for lyrics panel (65% of screen height)
    final screenHeight = MediaQuery.of(context).size.height;
    final lyricsMaxHeight = screenHeight * 0.65;

    return Consumer<AudioPlayerService>(
      builder: (context, audioService, child) {
        // Don't show if no playlist is active
        if (!audioService.hasPlaylist) {
          return const SizedBox.shrink();
        }

        final currentLyric = audioService.currentLyric;
        final isPlaying = audioService.isPlaying;
        final position = audioService.position;
        final duration = audioService.duration;
        final currentIndex = audioService.currentIndex;
        final totalTracks = audioService.playlist.length;
        final isRepeat = audioService.isRepeatEnabled;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lyrics panel (expandable)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _showLyrics ? lyricsMaxHeight : 0,
                  child: ClipRect(
                    child: _showLyrics && currentLyric != null
                        ? Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                // Header with title and close
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).primaryColor.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.music_note,
                                          size: 18,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentLyric.title.capitalize(),
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${currentIndex + 1} de $totalTracks',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            setState(() => _showLyrics = false),
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        iconSize: 26,
                                        color: Colors.grey[600],
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(
                                          minWidth: 36,
                                          minHeight: 36,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Lyrics content
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      currentLyric.content,
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        height: 1.75,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                // Progress bar
                LinearProgressIndicator(
                  value: duration.inSeconds > 0
                      ? position.inSeconds / duration.inSeconds
                      : 0.0,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  minHeight: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: Row(
                    children: [
                      // Close button (left)
                      IconButton(
                        onPressed: () => audioService.clearPlaylist(),
                        icon: const Icon(Icons.close),
                        iconSize: 22,
                        color: Colors.grey[600],
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      // Track info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              currentLyric?.title.capitalize() ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${currentIndex + 1}/$totalTracks • ${_formatDuration(position)}/${_formatDuration(duration)}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Show lyrics button
                      IconButton(
                        onPressed: currentLyric != null
                            ? () => setState(() => _showLyrics = !_showLyrics)
                            : null,
                        icon: Icon(
                          _showLyrics ? Icons.article : Icons.article_outlined,
                        ),
                        iconSize: 22,
                        color: _showLyrics
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      // Controls (right side)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Repeat
                          IconButton(
                            onPressed: () => audioService.toggleRepeat(),
                            icon: Icon(
                              isRepeat ? Icons.repeat_one : Icons.repeat,
                            ),
                            iconSize: 20,
                            color: isRepeat
                                ? Theme.of(context).primaryColor
                                : Colors.grey[500],
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                          // Previous
                          IconButton(
                            onPressed: () => audioService.skipPrevious(),
                            icon: const Icon(Icons.skip_previous_rounded),
                            iconSize: 28,
                            color: Colors.black87,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                          // Play/Pause (main button)
                          IconButton(
                            onPressed: () => audioService.togglePlayPause(),
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                            ),
                            iconSize: 44,
                            color: Theme.of(context).primaryColor,
                            padding: EdgeInsets.zero,
                          ),
                          // Next
                          IconButton(
                            onPressed: () => audioService.skipNext(),
                            icon: const Icon(Icons.skip_next_rounded),
                            iconSize: 28,
                            color: Colors.black87,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
