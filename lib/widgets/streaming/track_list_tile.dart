import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/streaming_tokens.dart';

/// Linha de faixa estilo streaming (Stitch Categoria / Favoritos).
class TrackListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int? trackNumber;
  final bool isPlaying;
  final bool isCurrent;
  final bool showPlayOnHover;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  const TrackListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trackNumber,
    this.isPlaying = false,
    this.isCurrent = false,
    this.showPlayOnHover = true,
    this.leading,
    this.trailing,
    this.onTap,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: StreamingTokens.cardRadius,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: StreamingTokens.spacingMd,
            vertical: StreamingTokens.spacingSm + 4,
          ),
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            color: isCurrent
                ? AppColors.primaryContainer.withValues(alpha: 0.1)
                : null,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Center(
                  child: leading ??
                      _buildIndexOrPlaying(colorScheme),
                ),
              ),
              const SizedBox(width: StreamingTokens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 16,
                        color: isCurrent
                            ? AppColors.primaryContainer
                            : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
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
              if (trailing != null) trailing!,
              if (onPlay != null)
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onPressed: onPlay,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndexOrPlaying(ColorScheme colorScheme) {
    if (isPlaying) {
      return Icon(
        Icons.graphic_eq_rounded,
        color: AppColors.primaryContainer,
        size: 22,
      );
    }
    if (trackNumber != null) {
      return Text(
        '$trackNumber',
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      );
    }
    return Icon(
      Icons.music_note_outlined,
      color: colorScheme.onSurfaceVariant,
      size: 20,
    );
  }
}

/// Tile com thumbnail para favoritos (Stitch Favoritos.html glass card).
class GlassTrackTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPlaying;
  final bool isCurrent;
  final Widget? trailing;
  final VoidCallback? onTap;

  const GlassTrackTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.isPlaying = false,
    this.isCurrent = false,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StreamingTokens.spacingMd,
        vertical: 4,
      ),
      child: Material(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: StreamingTokens.cardRadius,
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(StreamingTokens.spacingMd - 4),
            child: Row(
              children: [
                _ArtPlaceholder(
                  isPlaying: isPlaying,
                  isCurrent: isCurrent,
                ),
                const SizedBox(width: StreamingTokens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isCurrent
                              ? AppColors.primaryHighlight
                              : colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtPlaceholder extends StatelessWidget {
  final bool isPlaying;
  final bool isCurrent;

  const _ArtPlaceholder({
    required this.isPlaying,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: StreamingTokens.trackArtSize - 8,
      height: StreamingTokens.trackArtSize - 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(StreamingTokens.radiusSm),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isCurrent
              ? [AppColors.primaryContainer, AppColors.surfaceContainerLowDark]
              : [
                  colorScheme.surfaceContainerHighest,
                  colorScheme.surfaceContainer,
                ],
        ),
      ),
      child: Center(
        child: Icon(
          isPlaying ? Icons.graphic_eq_rounded : Icons.music_note_rounded,
          color: isCurrent ? Colors.white : colorScheme.onSurfaceVariant,
          size: 24,
        ),
      ),
    );
  }
}
