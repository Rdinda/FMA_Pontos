import 'package:flutter/material.dart';

/// Widget de skeleton/shimmer para estados de carregamento.
/// Substitui CircularProgressIndicator com uma animação mais moderna.
class SkeletonWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isCircle;

  const SkeletonWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.isCircle = false,
  });

  /// Cria um skeleton retangular
  const SkeletonWidget.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  }) : isCircle = false;

  /// Cria um skeleton circular (avatar)
  const SkeletonWidget.circular({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = 0,
      isCircle = true;

  @override
  State<SkeletonWidget> createState() => _SkeletonWidgetState();
}

class _SkeletonWidgetState extends State<SkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle
                ? null
                : BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [0.0, 0.5 + (_animation.value * 0.25), 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Widget para mostrar um card de categoria em skeleton
class CategoryCardSkeleton extends StatelessWidget {
  const CategoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SkeletonWidget.circular(size: 48),
            const SizedBox(height: 12),
            SkeletonWidget.rectangular(width: 80, height: 16, borderRadius: 4),
          ],
        ),
      ),
    );
  }
}

/// Widget para mostrar uma lista de itens em skeleton
class ListItemSkeleton extends StatelessWidget {
  final bool hasLeading;
  final bool hasSubtitle;

  const ListItemSkeleton({
    super.key,
    this.hasLeading = true,
    this.hasSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (hasLeading) ...[
            const SkeletonWidget.circular(size: 40),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonWidget.rectangular(
                  width: double.infinity,
                  height: 16,
                  borderRadius: 4,
                ),
                if (hasSubtitle) ...[
                  const SizedBox(height: 8),
                  SkeletonWidget.rectangular(
                    width: 150,
                    height: 12,
                    borderRadius: 4,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Grid de skeletons para categorias
class CategoryGridSkeleton extends StatelessWidget {
  final int itemCount;

  const CategoryGridSkeleton({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const CategoryCardSkeleton(),
    );
  }
}

/// Lista de skeletons
class ListSkeleton extends StatelessWidget {
  final int itemCount;
  final bool hasLeading;
  final bool hasSubtitle;

  const ListSkeleton({
    super.key,
    this.itemCount = 5,
    this.hasLeading = true,
    this.hasSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) =>
          ListItemSkeleton(hasLeading: hasLeading, hasSubtitle: hasSubtitle),
    );
  }
}
