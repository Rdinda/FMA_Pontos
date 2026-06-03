import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../database/db_helper.dart';
import 'auth_service.dart';
import 'play_stats_service.dart';
import 'supabase_service.dart';
import 'sync_merge.dart';

class SyncRepository with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final SupabaseService _supabaseService = SupabaseService();
  final PlayStatsService _playStatsService = PlayStatsService.instance;
  AuthService? _auth;

  bool _isSyncing = false;
  bool _isOffline = true;
  double _downloadProgress = 0.0;
  String _downloadStatus = '';
  bool _isDownloading = false;
  String? _lastSyncError;
  DateTime? _lastSyncAt;
  int _pendingCategoriesCount = 0;
  int _pendingLyricsCount = 0;

  bool get isSyncing => _isSyncing;
  bool get isOffline => _isOffline;
  bool get isDownloading => _isDownloading;
  double get downloadProgress => _downloadProgress;
  String get downloadStatus => _downloadStatus;
  String? get lastSyncError => _lastSyncError;
  DateTime? get lastSyncAt => _lastSyncAt;
  int get pendingCategoriesCount => _pendingCategoriesCount;
  int get pendingLyricsCount => _pendingLyricsCount;

  Future<int> get pendingAccessEventsCount =>
      _playStatsService.pendingAccessEventsCount();

  SyncRepository() {
    _initConnectivity();
    _refreshPendingCounts();
  }

  void bindAuth(AuthService auth) {
    _auth = auth;
    auth.registerPostLoginSync(() => syncData());
  }

  Future<void> _refreshPendingCounts() async {
    _pendingCategoriesCount =
        (await _dbHelper.getUnsyncedCategories()).length;
    _pendingLyricsCount = (await _dbHelper.getUnsyncedLyrics()).length;
    notifyListeners();
  }

  void _initConnectivity() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _isOffline = results.contains(ConnectivityResult.none);
      notifyListeners();
      if (!_isOffline) {
        syncData();
      }
    });
    Connectivity().checkConnectivity().then((results) {
      _isOffline = results.contains(ConnectivityResult.none);
      notifyListeners();
    });
  }

  Future<void> syncData() async {
    if (_isSyncing || _isOffline) return;

    _isSyncing = true;
    _lastSyncError = null;
    notifyListeners();

    try {
      await _pushPendingChanges();
      await _playStatsService.flushPendingAccessEvents();

      final prefs = await SharedPreferences.getInstance();
      final lastSyncStr = prefs.getString('last_sync_timestamp');
      final lastSync = lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;

      final cloudCategories = await _supabaseService.fetchCategories(
        since: lastSync,
      );

      for (var cat in cloudCategories) {
        if (cat.isDeleted) {
          await _dbHelper.hardDeleteCategory(cat.id);
          continue;
        }

        final existing = await _dbHelper.getCategory(cat.id);
        if (existing != null && !existing.isSynced) {
          if (existing.updatedAt.isAfter(cat.updatedAt)) {
            continue;
          }
          final merged = SyncMerge.mergeCategory(existing, cat);
          await _dbHelper.upsertCategory(merged);
        } else {
          final localCat = Category(
            id: cat.id,
            name: cat.name,
            code: cat.code,
            updatedAt: cat.updatedAt,
            isSynced: true,
            isDeleted: false,
          );
          await _dbHelper.upsertCategory(localCat);
        }
      }

      final cloudLyrics = await _supabaseService.fetchLyrics(since: lastSync);

      for (var lyric in cloudLyrics) {
        if (lyric.isDeleted) {
          final local = await _dbHelper.getLyricById(lyric.id);
          if (local != null && local.localAudioPath != null) {
            final file = File(local.localAudioPath!);
            if (await file.exists()) await file.delete();
          }
          await _dbHelper.hardDeleteLyric(lyric.id);
          continue;
        }

        final existing = await _dbHelper.getLyricById(lyric.id);
        String? preservedPath = existing?.localAudioPath;

        if (existing != null && existing.localAudioPath != null) {
          final audioRemoved = lyric.audioUrl == null;
          final audioChanged =
              lyric.audioUrl != null && lyric.audioUrl != existing.audioUrl;
          if (audioRemoved || audioChanged) {
            final file = File(existing.localAudioPath!);
            if (await file.exists()) {
              try {
                await file.delete();
              } catch (e) {
                debugPrint('Failed to delete stale audio: $e');
              }
            }
            preservedPath = null;
          } else if (lyric.audioUrl == existing.audioUrl) {
            preservedPath = existing.localAudioPath;
          }
        }

        if (existing != null && !existing.isSynced) {
          if (existing.updatedAt.isAfter(lyric.updatedAt)) {
            continue;
          }
          final merged = SyncMerge.mergeLyric(
            existing,
            lyric,
            preservedLocalAudioPath: preservedPath,
          );
          await _dbHelper.upsertLyric(merged);
        } else {
          final localLyric = Lyric(
            id: lyric.id,
            categoryId: lyric.categoryId,
            title: lyric.title,
            content: lyric.content,
            updatedAt: lyric.updatedAt,
            isSynced: true,
            isDeleted: false,
            audioUrl: lyric.audioUrl,
            localAudioPath: preservedPath,
            youtubeLink: lyric.youtubeLink,
            sequenceNumber: lyric.sequenceNumber,
          );
          await _dbHelper.upsertLyric(localLyric);
        }
      }

      await _pushPendingChanges();

      await prefs.setString(
        'last_sync_timestamp',
        DateTime.now().toIso8601String(),
      );
      _lastSyncAt = DateTime.now();

      await _downloadMissingAudios();
      await _refreshPendingCounts();
    } catch (e, st) {
      _lastSyncError = e.toString();
      debugPrint('Sync Error: $e\n$st');
      await _refreshPendingCounts();
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  bool _mayPushCategory(Category cat, Category? remote) {
    final auth = _auth;
    if (auth == null || auth.isAnonymous || !auth.isActive) return false;
    if (cat.isDeleted) return auth.canDeleteCategories;
    if (remote == null || remote.isDeleted) return auth.canAddCategories;
    return auth.canEditCategories;
  }

  bool _mayPushLyric(Lyric lyric, Lyric? remote) {
    final auth = _auth;
    if (auth == null || auth.isAnonymous || !auth.isActive) return false;
    if (lyric.isDeleted) return auth.canDeleteLyrics;
    if (remote == null || remote.isDeleted) return auth.canAddLyrics;
    return auth.canEditLyrics;
  }

  Future<void> _pushPendingChanges() async {
    final unsyncedCategories = await _dbHelper.getUnsyncedCategories();
    for (var cat in unsyncedCategories) {
      final remote = await _supabaseService.fetchCategoryById(cat.id);
      if (!_mayPushCategory(cat, remote)) continue;

      if (cat.isDeleted) {
        await _supabaseService.deleteCategory(cat.id);
        await _dbHelper.hardDeleteCategory(cat.id);
        continue;
      }

      var toPush = cat;
      if (remote != null &&
          !remote.isDeleted &&
          remote.updatedAt.isAfter(cat.updatedAt)) {
        toPush = SyncMerge.mergeCategory(cat, remote);
        await _dbHelper.upsertCategory(toPush);
        if (toPush.updatedAt == remote.updatedAt) {
          await _dbHelper.markCategorySynced(cat.id);
          continue;
        }
      }

      await _supabaseService.upsertCategory(toPush);
      await _dbHelper.markCategorySynced(cat.id);
    }

    final unsyncedLyrics = await _dbHelper.getUnsyncedLyrics();
    for (var lyric in unsyncedLyrics) {
      final remote = await _supabaseService.fetchLyricById(lyric.id);
      if (!_mayPushLyric(lyric, remote)) continue;

      if (lyric.isDeleted) {
        await _supabaseService.deleteLyric(lyric.id);
        await _dbHelper.hardDeleteLyric(lyric.id);
        continue;
      }

      var toPush = lyric;
      if (remote != null &&
          !remote.isDeleted &&
          remote.updatedAt.isAfter(lyric.updatedAt)) {
        toPush = SyncMerge.mergeLyric(
          lyric,
          remote,
          preservedLocalAudioPath: lyric.localAudioPath,
        );
        await _dbHelper.upsertLyric(toPush);
        if (toPush.updatedAt == remote.updatedAt) {
          await _dbHelper.markLyricSynced(lyric.id);
          continue;
        }
      }

      await _supabaseService.upsertLyric(toPush);
      await _dbHelper.markLyricSynced(lyric.id);
    }

    await _refreshPendingCounts();
  }

  Future<void> _downloadMissingAudios() async {
    final lyrics = await _dbHelper.readAllLyrics();
    final lyricsToDownload = lyrics
        .where((l) => l.audioUrl != null && l.localAudioPath == null)
        .toList();

    if (lyricsToDownload.isEmpty) return;

    _isDownloading = true;
    _downloadStatus = 'Baixando áudios...';
    notifyListeners();

    final total = lyricsToDownload.length;
    var completed = 0;

    final appDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${appDir.path}/audios');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    for (var lyric in lyricsToDownload) {
      try {
        final url = lyric.audioUrl!;
        final filename = url.split('/').last;
        final savePath = '${audioDir.path}/$filename';

        if (await File(savePath).exists()) {
          final updated = Lyric(
            id: lyric.id,
            categoryId: lyric.categoryId,
            title: lyric.title,
            content: lyric.content,
            updatedAt: lyric.updatedAt,
            isSynced: lyric.isSynced,
            isDeleted: lyric.isDeleted,
            audioUrl: lyric.audioUrl,
            localAudioPath: savePath,
            youtubeLink: lyric.youtubeLink,
            sequenceNumber: lyric.sequenceNumber,
          );
          await _dbHelper.upsertLyric(updated);
          completed++;
          _downloadProgress = completed / total;
          notifyListeners();
          continue;
        }

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);

          final updatedLyric = Lyric(
            id: lyric.id,
            categoryId: lyric.categoryId,
            title: lyric.title,
            content: lyric.content,
            updatedAt: lyric.updatedAt,
            isSynced: lyric.isSynced,
            isDeleted: lyric.isDeleted,
            audioUrl: lyric.audioUrl,
            localAudioPath: savePath,
            youtubeLink: lyric.youtubeLink,
            sequenceNumber: lyric.sequenceNumber,
          );

          await _dbHelper.upsertLyric(updatedLyric);
        }
      } catch (e) {
        debugPrint('Error downloading audio for ${lyric.title}: $e');
      }

      completed++;
      _downloadProgress = completed / total;
      _downloadStatus = 'Baixando áudios: $completed/$total';
      notifyListeners();
    }

    _isDownloading = false;
    _downloadStatus = '';
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    if (_auth != null && !_auth!.canAddCategories) {
      debugPrint('addCategory denied: insufficient permission');
      return;
    }
    await _dbHelper.upsertCategory(category);
    await _refreshPendingCounts();
    notifyListeners();
    if (!_isOffline) syncData();
  }

  Future<void> updateCategory(Category category) async {
    if (_auth != null && !_auth!.canEditCategories) {
      debugPrint('updateCategory denied: insufficient permission');
      return;
    }
    await _dbHelper.upsertCategory(category);
    await _refreshPendingCounts();
    notifyListeners();
    if (!_isOffline) syncData();
  }

  Future<void> deleteCategory(String id) async {
    if (_auth != null && !_auth!.canDeleteCategories) {
      debugPrint('deleteCategory denied: insufficient permission');
      return;
    }
    await _dbHelper.softDeleteCategory(id);
    await _refreshPendingCounts();
    notifyListeners();
    if (!_isOffline) syncData();
  }

  Future<void> deleteLyric(String id) async {
    if (_auth != null && !_auth!.canDeleteLyrics) {
      debugPrint('deleteLyric denied: insufficient permission');
      return;
    }
    await _dbHelper.softDeleteLyric(id);
    await _refreshPendingCounts();
    notifyListeners();
    if (!_isOffline) syncData();
  }

  Future<void> addLyric(Lyric lyric) async {
    if (_auth != null && !_auth!.canAddLyrics) {
      debugPrint('addLyric denied: insufficient permission');
      return;
    }
    await _dbHelper.upsertLyric(lyric);
    await _refreshPendingCounts();
    notifyListeners();
    if (!_isOffline) syncData();
  }

  Future<List<Category>> getCategories() async {
    return _dbHelper.readAllCategories();
  }

  Future<Category?> getCategory(String id) async {
    return _dbHelper.getCategory(id);
  }

  Future<List<Lyric>> getLyrics(String categoryId) =>
      _dbHelper.readLyricsByCategory(categoryId);
  Future<List<Lyric>> searchLyrics(String query) =>
      _dbHelper.searchLyrics(query);
  Future<Lyric?> getLyric(String id) => _dbHelper.getLyricById(id);

  Future<List<Lyric>> getLyricsByIds(List<String> ids) =>
      _dbHelper.getLyricsByIds(ids);

  Future<int> getLyricsCount(String categoryId) async {
    final lyrics = await _dbHelper.readLyricsByCategory(categoryId);
    return lyrics.length;
  }

  Future<int> getNextSequenceNumber(String categoryId) async {
    final max = await _dbHelper.getMaxSequenceNumber(categoryId);
    return max + 1;
  }
}
