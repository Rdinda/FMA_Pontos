import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../theme/app_colors.dart';
import '../../theme/streaming_tokens.dart';
import '../../utils/category_artwork.dart';

const _kCategoryFooterHeight = 36.0;

/// Faixa inferior escura para legibilidade do nome da categoria.
class _CategoryNameFooter extends StatelessWidget {
  final String name;

  const _CategoryNameFooter({required this.name});

  @override
  Widget build(BuildContext context) {
    final bottomRadius = StreamingTokens.cardRadius.bottomLeft;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: bottomRadius,
          bottomRight: bottomRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            Container(
              height: _kCategoryFooterHeight - 8,
              color: Colors.black.withValues(alpha: 0.65),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card de categoria estilo playlist (Stitch Home_Acervo).
class CategoryCard extends StatelessWidget {
  final String name;
  final int index;
  final Category? category;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  const CategoryCard({
    super.key,
    required this.name,
    required this.index,
    this.category,
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

  String? _imageAsset() {
    if (category != null) return categoryImageAsset(category!);
    return categoryImageAssetFor(name: name);
  }

  @override
  Widget build(BuildContext context) {
    final colors = _gradientForIndex(index);
    final imageAsset = _imageAsset();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: StreamingTokens.cardRadius,
        child: Ink(
          height: StreamingTokens.categoryCardHeight,
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            gradient: imageAsset == null
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  )
                : null,
            image: imageAsset != null
                ? DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: (imageAsset != null ? Colors.black : colors.first)
                    .withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              if (imageAsset == null)
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
              _CategoryNameFooter(name: name),
              if (onPlay != null)
                Positioned(
                  right: 8,
                  bottom: _kCategoryFooterHeight + 4,
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
  final Category? category;
  final VoidCallback? onTap;

  const BentoCategoryCard({
    super.key,
    required this.name,
    required this.index,
    this.category,
    this.onTap,
  });

  String? _imageAsset() {
    if (category != null) return categoryImageAsset(category!);
    return categoryImageAssetFor(name: name);
  }

  @override
  Widget build(BuildContext context) {
    final colors = CategoryCard.gradients[index % CategoryCard.gradients.length];
    final imageAsset = _imageAsset();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: StreamingTokens.cardRadius,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: StreamingTokens.cardRadius,
            gradient: imageAsset == null
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  )
                : null,
            image: imageAsset != null
                ? DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: (imageAsset != null ? Colors.black : colors.first)
                    .withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageAsset == null)
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
              _CategoryNameFooter(name: name),
            ],
          ),
        ),
      ),
    );
  }
}
