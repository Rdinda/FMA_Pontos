import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/streaming_tokens.dart';

/// Card de categoria estilo playlist (Stitch Home_Acervo).
class CategoryCard extends StatelessWidget {
  final String name;
  final int index;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  const CategoryCard({
    super.key,
    required this.name,
    required this.index,
    this.onTap,
    this.onPlay,
  });

  static const gradients = [
    [Color(0xFF065F46), Color(0xFF064E3B)],
    [Color(0xFF1E40AF), Color(0xFF312E81)],
    [Color(0xFF991B1B), Color(0xFF7C2D12)],
    [Color(0xFF115E59), Color(0xFF065F46)],
    [Color(0xFF6D4C41), Color(0xFF4E342E)],
    [Color(0xFF2E7D32), Color(0xFF1B5E20)],
    [Color(0xFF0277BD), Color(0xFF004D40)],
    [Color(0xFFFBC02D), Color(0xFFE65100)],
  ];

  List<Color> _gradientForIndex(int i) => gradients[i % gradients.length];

  @override
  Widget build(BuildContext context) {
    final colors = _gradientForIndex(index);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: StreamingTokens.cardRadius,
        child: Ink(
          height: StreamingTokens.categoryCardHeight,
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -16,
                bottom: -16,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(StreamingTokens.spacingMd),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (onPlay != null)
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Material(
                    color: AppColors.primaryContainer,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onPlay,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.onPrimaryContainer,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card quadrado bento para grid de busca (Stitch Busca.html).
class BentoCategoryCard extends StatelessWidget {
  final String name;
  final int index;
  final VoidCallback? onTap;

  const BentoCategoryCard({
    super.key,
    required this.name,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CategoryCard.gradients[index % CategoryCard.gradients.length];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: StreamingTokens.cardRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: StreamingTokens.cardRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(StreamingTokens.spacingMd),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
