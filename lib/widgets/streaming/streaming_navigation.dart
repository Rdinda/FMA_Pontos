import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../screens/favorites_screen.dart';
import '../../screens/lyric_form_screen.dart';
import '../../screens/search_screen.dart';
import '../../screens/top_played_screen.dart';
import '../../services/auth_service.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/app_info_bottom_sheet.dart';

/// Contexto do 5º/6º slot da bottom nav (ação contextual).
enum StreamingNavContext {
  /// Categoria: slot extra = adicionar letra.
  category,

  /// Busca, favoritos, top, letra: sem slot contextual.
  standard,
}

/// Índice selecionado nas telas principais (0–3 fixos; 4+ contextual).
abstract final class StreamingNavIndex {
  static const int home = 0;
  static const int search = 1;
  static const int top = 2;
  static const int favorites = 3;
}

/// Navegação inferior unificada (itens + toques + RBAC).
abstract final class StreamingNavigation {
  static List<BottomNavigationBarItem> buildItems(
    AuthService auth,
    StreamingNavContext context,
  ) {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Início',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        label: 'Buscar',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.trending_up_rounded),
        label: 'Top',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline_rounded),
        label: 'Gostei',
      ),
    ];

    switch (context) {
      case StreamingNavContext.category:
        items.add(
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: 'Letra',
          ),
        );
      case StreamingNavContext.standard:
        break;
    }

    return items;
  }

  static void handleTap(
    BuildContext context,
    int index,
    StreamingNavContext navContext, {
    Category? category,
    VoidCallback? onAddCategory,
    VoidCallback? onEditCategory,
    String? appVersion,
  }) {
    final auth = Provider.of<AuthService>(context, listen: false);

    switch (index) {
      case StreamingNavIndex.home:
        Navigator.popUntil(context, (route) => route.isFirst);
      case StreamingNavIndex.search:
        _openIfNotCurrent(context, const SearchScreen());
      case StreamingNavIndex.top:
        _openIfNotCurrent(context, const TopPlayedScreen());
      case StreamingNavIndex.favorites:
        _openIfNotCurrent(context, const FavoritesScreen());
      case 4:
        _handleContextSlot(context, navContext, auth,
            category: category,
            onAddCategory: onAddCategory,
            onEditCategory: onEditCategory,
            appVersion: appVersion);
    }
  }

  static void _handleContextSlot(
    BuildContext context,
    StreamingNavContext navContext,
    AuthService auth, {
    Category? category,
    VoidCallback? onAddCategory,
    VoidCallback? onEditCategory,
    String? appVersion,
  }) {
    switch (navContext) {
      case StreamingNavContext.category:
        if (category == null) break;
        _openAddLyric(context, category, auth, appVersion: appVersion);
      case StreamingNavContext.standard:
        break;
    }
  }

  static void _openAddLyric(
    BuildContext context,
    Category category,
    AuthService auth, {
    String? appVersion,
  }) {
    if (!auth.canAddLyrics) {
      _showPermission(
        context,
        auth,
        action: 'adicionar letras',
        appVersion: appVersion,
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LyricFormScreen(categoryId: category.id),
      ),
    );
  }

  static void _openIfNotCurrent(BuildContext context, Widget screen) {
    final route = ModalRoute.of(context);
    if (route?.settings.name == screen.runtimeType.toString()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: screen.runtimeType.toString()),
        builder: (_) => screen,
      ),
    );
  }

  static void _showPermission(
    BuildContext context,
    AuthService auth, {
    String? roleLabel,
    required String action,
    String? appVersion,
  }) {
    final String message;
    if (auth.isAnonymous) {
      message = 'Faça login com Google para $action';
    } else if (roleLabel != null) {
      message = 'Você precisa ser $roleLabel para $action';
    } else {
      message = 'Você não tem permissão para esta ação';
    }

    SnackbarUtils.show(
      context,
      message: message,
      isError: true,
      action: auth.isAnonymous
          ? SnackBarAction(
              label: 'Entrar',
              onPressed: () => showAppInfoBottomSheet(
                context,
                version: appVersion,
              ),
            )
          : null,
    );
  }
}
