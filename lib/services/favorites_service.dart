import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'supabase_service.dart';

/// Favoritos (Gostei): local para visitante; local + Supabase para usuário logado.
class FavoritesService extends ChangeNotifier {
  static const String _guestFavoritesKey = 'favorite_lyrics';

  final SupabaseService _supabase = SupabaseService();

  AuthService? _auth;
  String? _boundUserId;
  bool _boundIsAnonymous = true;

  final Set<String> _favorites = {};
  bool _isLoaded = false;

  Set<String> get favorites => Set.unmodifiable(_favorites);
  int get count => _favorites.length;
  bool get isLoaded => _isLoaded;

  bool get _canSyncRemote =>
      _auth != null &&
      _auth!.isAuthenticated &&
      !_auth!.isAnonymous &&
      _auth!.userId != null;

  String? get _userId => _auth?.userId;

  FavoritesService() {
    _loadForCurrentAuth();
  }

  void bindAuth(AuthService auth) {
    final userId = auth.userId;
    final isAnonymous = auth.isAnonymous;
    if (_boundUserId == userId && _boundIsAnonymous == isAnonymous) return;
    _auth = auth;
    _boundUserId = userId;
    _boundIsAnonymous = isAnonymous;
    _loadForCurrentAuth();
  }

  String _userPrefsKey(String userId) => 'favorite_lyrics_$userId';

  Future<void> _loadForCurrentAuth() async {
    _isLoaded = false;
    notifyListeners();

    if (_canSyncRemote) {
      await _loadLoggedInFavorites();
    } else {
      await _loadGuestFavorites();
    }

    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _loadGuestFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_guestFavoritesKey) ?? [];
      _favorites
        ..clear()
        ..addAll(list);
      debugPrint('[FavoritesService] Guest: ${_favorites.length} favorites');
    } catch (e) {
      debugPrint('[FavoritesService] Error loading guest favorites: $e');
      _favorites.clear();
    }
  }

  Future<void> _loadLoggedInFavorites() async {
    final userId = _userId;
    if (userId == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final guestList = prefs.getStringList(_guestFavoritesKey) ?? [];
      final localList = prefs.getStringList(_userPrefsKey(userId)) ?? [];

      Set<String> remote = {};
      try {
        remote = await _supabase.fetchUserFavoriteLyricIds(userId);
      } catch (e) {
        debugPrint('[FavoritesService] Remote fetch failed: $e');
      }

      final merged = <String>{
        ...localList,
        ...remote,
        ...guestList,
      };

      _favorites
        ..clear()
        ..addAll(merged);

      await _saveLocalPrefs(userId: userId);
      await _pushMissingToRemote(userId, remote);

      debugPrint(
        '[FavoritesService] Logged in ($userId): ${_favorites.length} favorites',
      );
    } catch (e) {
      debugPrint('[FavoritesService] Error loading logged-in favorites: $e');
    }
  }

  Future<void> _pushMissingToRemote(
    String userId,
    Set<String> alreadyOnRemote,
  ) async {
    for (final lyricId in _favorites) {
      if (alreadyOnRemote.contains(lyricId)) continue;
      try {
        await _supabase.addUserFavorite(userId: userId, lyricId: lyricId);
      } catch (e) {
        debugPrint(
          '[FavoritesService] Push favorite $lyricId failed: $e',
        );
      }
    }
  }

  Future<void> _saveLocalPrefs({String? userId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (userId != null) {
        await prefs.setStringList(
          _userPrefsKey(userId),
          _favorites.toList(),
        );
      } else {
        await prefs.setStringList(_guestFavoritesKey, _favorites.toList());
      }
    } catch (e) {
      debugPrint('[FavoritesService] Error saving favorites: $e');
    }
  }

  Future<void> _syncAddRemote(String lyricId) async {
    if (!_canSyncRemote) return;
    final userId = _userId!;
    try {
      await _supabase.addUserFavorite(userId: userId, lyricId: lyricId);
    } catch (e) {
      debugPrint('[FavoritesService] Remote add failed: $e');
    }
  }

  Future<void> _syncRemoveRemote(String lyricId) async {
    if (!_canSyncRemote) return;
    final userId = _userId!;
    try {
      await _supabase.removeUserFavorite(userId: userId, lyricId: lyricId);
    } catch (e) {
      debugPrint('[FavoritesService] Remote remove failed: $e');
    }
  }

  bool isFavorite(String lyricId) => _favorites.contains(lyricId);

  Future<void> toggleFavorite(String lyricId) async {
    if (_favorites.contains(lyricId)) {
      _favorites.remove(lyricId);
      await _syncRemoveRemote(lyricId);
      debugPrint('[FavoritesService] Removed $lyricId');
    } else {
      _favorites.add(lyricId);
      await _syncAddRemote(lyricId);
      debugPrint('[FavoritesService] Added $lyricId');
    }
    notifyListeners();
    await _saveLocalPrefs(userId: _canSyncRemote ? _userId : null);
  }

  Future<void> addFavorite(String lyricId) async {
    if (_favorites.contains(lyricId)) return;
    _favorites.add(lyricId);
    await _syncAddRemote(lyricId);
    notifyListeners();
    await _saveLocalPrefs(userId: _canSyncRemote ? _userId : null);
  }

  Future<void> removeFavorite(String lyricId) async {
    if (!_favorites.contains(lyricId)) return;
    _favorites.remove(lyricId);
    await _syncRemoveRemote(lyricId);
    notifyListeners();
    await _saveLocalPrefs(userId: _canSyncRemote ? _userId : null);
  }

  Future<void> clearAll() async {
    _favorites.clear();
    if (_canSyncRemote) {
      try {
        await _supabase.clearUserFavorites(_userId!);
      } catch (e) {
        debugPrint('[FavoritesService] Remote clear failed: $e');
      }
    }
    notifyListeners();
    await _saveLocalPrefs(userId: _canSyncRemote ? _userId : null);
  }

  /// Reconcilia com o remoto (ex.: após login). Chamado via [bindAuth].
  Future<void> syncWithRemote() async {
    if (!_canSyncRemote) return;
    await _loadLoggedInFavorites();
    _isLoaded = true;
    notifyListeners();
  }
}
