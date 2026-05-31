import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../models/category.dart';
import 'streaming_bottom_nav.dart';
import 'streaming_mini_player.dart';
import 'streaming_navigation.dart';

/// Scaffold com bottom nav + mini player (Stitch shell).
class StreamingScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final StreamingNavContext? navContext;
  final int? currentNavIndex;
  final Category? category;
  final VoidCallback? onAddCategory;
  final VoidCallback? onEditCategory;
  final String? appVersion;
  final bool showMiniPlayer;
  final bool showBottomNav;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const StreamingScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.navContext,
    this.currentNavIndex,
    this.category,
    this.onAddCategory,
    this.onEditCategory,
    this.appVersion,
    this.showMiniPlayer = true,
    this.showBottomNav = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final items = showBottomNav && navContext != null
        ? StreamingNavigation.buildItems(auth, navContext!)
        : <BottomNavigationBarItem>[];
    final navIndex = currentNavIndex ?? 0;
    final canShowNav = showBottomNav &&
        navContext != null &&
        currentNavIndex != null &&
        items.isNotEmpty;

    return Scaffold(
      appBar: appBar,
      extendBody: false,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      // Body already lays out above [bottomNavigationBar]; extra bottom padding
      // duplicated nav + mini-player height and caused a dead zone when the
      // mini player was hidden (SizedBox.shrink).
      body: body,
      bottomNavigationBar: canShowNav
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showMiniPlayer) const StreamingMiniPlayer(),
                const SizedBox(height: 4),
                StreamingBottomNav(
                  currentIndex: navIndex.clamp(0, items.length - 1),
                  onTap: (index) => StreamingNavigation.handleTap(
                    context,
                    index,
                    navContext!,
                    category: category,
                    onAddCategory: onAddCategory,
                    onEditCategory: onEditCategory,
                    appVersion: appVersion,
                  ),
                  items: items,
                ),
              ],
            )
          : showMiniPlayer
              ? const SafeArea(
                  top: false,
                  child: StreamingMiniPlayer(),
                )
              : null,
    );
  }
}

/// App bar streaming com logo FMA Pontos (Stitch header).
class StreamingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final String title;

  const StreamingAppBar({
    super.key,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.title = 'FMA Pontos',
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      leading: leading,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: centerTitle ? 18 : 20,
          color: colorScheme.primary,
          letterSpacing: -0.5,
        ),
      ),
      actions: actions,
      backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
    );
  }
}
