import 'package:flutter/material.dart';
import '../../models/lyric.dart';
import '../../screens/lyric_view_screen.dart';
import '../../theme/app_colors.dart';
import '../../theme/streaming_tokens.dart';

/// Tags compartilhadas entre mini player e tela completa (Hero).
abstract final class PlayerHeroTags {
  static String art(String lyricId) => 'player-art-$lyricId';

  static String shell(String lyricId) => 'player-shell-$lyricId';
}

/// Abre a tela de letra com transição estilo YouTube Music (slide + Hero).
abstract final class PlayerExpansion {
  static const Duration transitionDuration = Duration(milliseconds: 420);
  static const Duration reverseDuration = Duration(milliseconds: 360);

  static void openFromMiniPlayer(BuildContext context, Lyric lyric) {
    Navigator.of(context).push(
      _PlayerExpansionRoute(
        builder: (_) => LyricViewScreen(
          lyric: lyric,
          fromMiniPlayer: true,
        ),
      ),
    );
  }
}

class _PlayerExpansionRoute extends PageRouteBuilder<void> {
  _PlayerExpansionRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: PlayerExpansion.transitionDuration,
          reverseTransitionDuration: PlayerExpansion.reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            );
          },
        );

  final WidgetBuilder builder;
}

/// Arte do álbum reutilizada no mini player e na tela completa.
class PlayerAlbumArt extends StatelessWidget {
  final String lyricId;
  final bool isPlaying;
  final bool heroEnabled;
  final bool compact;
  final double? maxSize;

  /// Preenche o espaço livre mantendo proporção 1:1 (tela completa).
  final bool expand;

  const PlayerAlbumArt({
    super.key,
    required this.lyricId,
    required this.isPlaying,
    this.heroEnabled = false,
    this.compact = false,
    this.maxSize,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconSize = compact ? 20.0 : (maxSize != null ? maxSize! * 0.35 : 80.0);
    final icon = Icon(
      isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
      color: Colors.white.withValues(alpha: compact ? 0.7 : 0.4),
      size: iconSize,
    );

    final Widget art;
    if (compact) {
      art = Container(
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
        child: Center(child: icon),
      );
    } else if (expand) {
      art = LayoutBuilder(
        builder: (context, constraints) {
          final side = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;
          final iconSide = side * 0.35;
          return Center(
            child: SizedBox(
              width: side,
              height: side,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: StreamingTokens.cardRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryContainer.withValues(alpha: 0.5),
                      colorScheme.surfaceContainerHighest,
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
                    isPlaying
                        ? Icons.graphic_eq_rounded
                        : Icons.music_note_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: iconSide,
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else if (maxSize != null) {
      art = Center(
        child: Container(
          width: maxSize,
          height: maxSize,
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryContainer.withValues(alpha: 0.5),
                colorScheme.surfaceContainerHighest,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(child: icon),
        ),
      );
    } else {
      art = AspectRatio(
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
                colorScheme.surfaceContainerHighest,
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
          child: Center(child: icon),
        ),
      );
    }

    if (!heroEnabled) return art;

    return Hero(
      tag: PlayerHeroTags.art(lyricId),
      child: Material(
        color: Colors.transparent,
        child: art,
      ),
    );
  }
}
