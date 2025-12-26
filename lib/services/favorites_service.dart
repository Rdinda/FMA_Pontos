import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serviço para gerenciar músicas favoritas do usuário.
/// Armazena favoritos localmente usando SharedPreferences.
class FavoritesService extends ChangeNotifier {
  static const String _favoritesKey = 'favorite_lyrics';

  final Set<String> _favorites = {};
  bool _isLoaded = false;

  /// Lista de IDs de músicas favoritas
  Set<String> get favorites => Set.unmodifiable(_favorites);

  /// Quantidade de favoritos
  int get count => _favorites.length;

  /// Se os favoritos já foram carregados
  bool get isLoaded => _isLoaded;

  FavoritesService() {
    _loadFavorites();
  }

  /// Carrega favoritos do armazenamento local
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = prefs.getStringList(_favoritesKey) ?? [];
      _favorites.clear();
      _favorites.addAll(favoritesList);
      _isLoaded = true;
      notifyListeners();
      debugPrint('[FavoritesService] Loaded ${_favorites.length} favorites');
    } catch (e) {
      debugPrint('[FavoritesService] Error loading favorites: $e');
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Salva favoritos no armazenamento local
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesKey, _favorites.toList());
      debugPrint('[FavoritesService] Saved ${_favorites.length} favorites');
    } catch (e) {
      debugPrint('[FavoritesService] Error saving favorites: $e');
    }
  }

  /// Verifica se uma música é favorita
  bool isFavorite(String lyricId) {
    return _favorites.contains(lyricId);
  }

  /// Adiciona ou remove uma música dos favoritos
  Future<void> toggleFavorite(String lyricId) async {
    if (_favorites.contains(lyricId)) {
      _favorites.remove(lyricId);
      debugPrint('[FavoritesService] Removed $lyricId from favorites');
    } else {
      _favorites.add(lyricId);
      debugPrint('[FavoritesService] Added $lyricId to favorites');
    }
    notifyListeners();
    await _saveFavorites();
  }

  /// Adiciona uma música aos favoritos
  Future<void> addFavorite(String lyricId) async {
    if (!_favorites.contains(lyricId)) {
      _favorites.add(lyricId);
      notifyListeners();
      await _saveFavorites();
    }
  }

  /// Remove uma música dos favoritos
  Future<void> removeFavorite(String lyricId) async {
    if (_favorites.contains(lyricId)) {
      _favorites.remove(lyricId);
      notifyListeners();
      await _saveFavorites();
    }
  }

  /// Remove todos os favoritos
  Future<void> clearAll() async {
    _favorites.clear();
    notifyListeners();
    await _saveFavorites();
  }
}
