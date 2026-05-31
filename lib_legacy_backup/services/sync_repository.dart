import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import 'db_helper.dart';
import 'supabase_service.dart';
import 'sync_merge.dart';

class SyncRepository with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final SupabaseService _supabaseService = SupabaseService();

  bool _isSyncing = false;
  bool _isOffline = true;
  double _downloadProgress = 0.0;
  String _downloadStatus = '';
  bool _isDownloading = false;

  bool get isSyncing => _isSyncing;
  bool get isOffline => _isOffline;
  bool get isDownloading => _isDownloading;
  double get downloadProgress => _downloadProgress;
  String get downloadStatus => _downloadStatus;

  SyncRepository() {
    _initConnectivity();
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
    // Initial check
    Connectivity().checkConnectivity().then((results) {
      _isOffline = results.contains(ConnectivityResult.none);
      notifyListeners();
    });
  }

  Future<void> syncData() async {
    if (_isSyncing || _isOffline) return;

    _isSyncing = true;
    notifyListeners();

    try {
      await _pushPendingChanges();

      // 2. PULL Changes (Incremental)
      final prefs = await SharedPreferences.getInstance();
      final lastSyncStr = prefs.getString('last_sync_timestamp');
      final lastSync = lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;

      final cloudCategories = await _supabaseService.fetchCategories(
        since: lastSync,
      );
      // Removed "Delete local synced items not in cloud" logic because we are now doing incremental sync
      // and we rely on 'isDeleted' flag from cloud to handle deletions.

      // Upsert cloud items
      for (var cat in cloudCategories) {
        if (cat.isDeleted) {
          await _dbHelper.hardDeleteCategory(cat.id);
        } else {
          final existing = await _dbHelper.getCategory(cat.id);
          Category localCat;
          if (existing != null && !existing.isSynced) {
            localCat = SyncMerge.mergeCategory(existing, cat);
          } else {
            localCat = Category(
              id: cat.id,
              name: cat.name,
              code: cat.code,
              updatedAt: cat.updatedAt,
              isSynced: existing == null || existing.isSynced,
              isDeleted: false,
            );
          }
          await _dbHelper.upsertCategory(localCat);
        }
      }

      final cloudLyrics = await _supabaseService.fetchLyrics(since: lastSync);

      // Upsert cloud items
      for (var lyric in cloudLyrics) {
        if (lyric.isDeleted) {
          // Handle deletion
          if (lyric.audioUrl != null) {
            // Optionally delete audio file? We don't have local path in cloud model.
            // We need to look up local DB.
            final local = await _dbHelper.getLyricById(lyric.id);
            if (local != null && local.localAudioPath != null) {
              final file = File(local.localAudioPath!);
              if (await file.exists()) await file.delete();
            }
          }
          await _dbHelper.hardDeleteLyric(lyric.id);
          continue;
        }

        // Check if we already have this lyric and preserve local path if exists
        // Actually, dbHelper.upsertLyric replaces. We should check if we need to preserve something or if the cloud one has new data.
        // For audio path, the Cloud doesn't know about local paths. So we should probably merge or handle path persistence.
        // Since we added local_audio_path to the model and toMap/fromMap, if we create a Lyric from Cloud map, local_audio_path is NULL.
        // If we upsert, we overwrite local path with null! BAD.
        // FIX: Read existing local lyric first.

        final existing = await _dbHelper.getLyricById(lyric.id);

        String? preservedPath = existing?.localAudioPath;

        // Check for audio changes
        if (existing != null && existing.localAudioPath != null) {
          // Case 1: Audio removed in cloud
          bool audioRemoved = lyric.audioUrl == null;
          // Case 2: Audio URL changed in cloud (different file)
          bool audioChanged = lyric.audioUrl != existing.audioUrl;

          if (audioRemoved || audioChanged) {
            final file = File(existing.localAudioPath!);
            if (await file.exists()) {
              try {
                await file.delete();
              } catch (e) {
                debugPrint("Failed to delete stale audio: $e");
              }
            }
            preservedPath =
                null; // Don't preserve path, so it's null (or re-downloaded if url exists)
          }
        }

        Lyric localLyric;
        if (existing != null && !existing.isSynced) {
          localLyric = SyncMerge.mergeLyric(
            existing,
            lyric,
            preservedLocalAudioPath: preservedPath,
          );
        } else {
          localLyric = Lyric(
            id: lyric.id,
            categoryId: lyric.categoryId,
            title: lyric.title,
            content: lyric.content,
            updatedAt: lyric.updatedAt,
            isSynced: existing == null || existing.isSynced,
            isDeleted: false,
            audioUrl: lyric.audioUrl,
            localAudioPath: preservedPath,
            youtubeLink: lyric.youtubeLink,
            sequenceNumber: lyric.sequenceNumber,
          );
        }
        await _dbHelper.upsertLyric(localLyric);
      }

      // Reenvia alterações produzidas por merge no PULL
      await _pushPendingChanges();

      // Save new sync timestamp
      await prefs.setString(
        'last_sync_timestamp',
        DateTime.now().toIso8601String(),
      );

      // 3. Download Missing Audios
      await _downloadMissingAudios();
    } catch (e) {
      debugPrint("Sync Error: $e");
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  Future<void> _pushPendingChanges() async {
    final unsyncedCategories = await _dbHelper.getUnsyncedCategories();
    for (var cat in unsyncedCategories) {
      if (cat.isDeleted) {
        await _supabaseService.deleteCategory(cat.id);
        await _dbHelper.hardDeleteCategory(cat.id);
      } else {
        var toPush = cat;
        final remote = await _supabaseService.fetchCategoryById(cat.id);
        if (remote != null && !remote.isDeleted) {
          toPush = SyncMerge.mergeCategory(cat, remote);
          await _dbHelper.upsertCategory(toPush);
        }
        await _supabaseService.upsertCategory(toPush);
        await _dbHelper.markCategorySynced(cat.id);
      }
    }

    final unsyncedLyrics = await _dbHelper.getUnsyncedLyrics();
    for (var lyric in unsyncedLyrics) {
      if (lyric.isDeleted) {
        await _supabaseService.deleteLyric(lyric.id);
        await _dbHelper.hardDeleteLyric(lyric.id);
      } else {
        var toPush = lyric;
        final remote = await _supabaseService.fetchLyricById(lyric.id);
        if (remote != null && !remote.isDeleted) {
          toPush = SyncMerge.mergeLyric(
            lyric,
            remote,
            preservedLocalAudioPath: lyric.localAudioPath,
          );
          await _dbHelper.upsertLyric(toPush);
        }
        await _supabaseService.upsertLyric(toPush);
        await _dbHelper.markLyricSynced(lyric.id);
      }
    }
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

    int total = lyricsToDownload.length;
    int completed = 0;

    final appDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${appDir.path}/audios');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    // Parallel or Sequential? Sequential is safer for bandwidth/connection
    for (var lyric in lyricsToDownload) {
      try {
        final url = lyric.audioUrl!;
        final filename = url.split('/').last; // Simple strategy
        final savePath = '${audioDir.path}/$filename';

        // Simple check if file exists (maybe from previous interrupted download)
        if (await File(savePath).exists()) {
          // Update DB only
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
        debugPrint("Error downloading audio for ${lyric.title}: $e");
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

  // --- CRUD Wrappers (UI should use these) ---

  Future<void> addCategory(Category category) async {
    await _dbHelper.upsertCategory(category);
    notifyListeners();
    if (!_isOffline) {
      _supabaseService
          .upsertCategory(category)
          .then((_) {
            _dbHelper.markCategorySynced(category.id);
          })
          .catchError((e) {
            debugPrint("Failed to push category: $e");
          });
    }
  }

  Future<void> updateCategory(Category category) async {
    await addCategory(category);
  }

  Future<void> deleteCategory(String id) async {
    await _dbHelper.softDeleteCategory(id);
    notifyListeners();
    if (!_isOffline) {
      _supabaseService
          .deleteCategory(id)
          .then((_) => _dbHelper.hardDeleteCategory(id))
          .catchError((e) {
            debugPrint(e.toString());
            return 0;
          });
    }
  }

  Future<void> deleteLyric(String id) async {
    await _dbHelper.softDeleteLyric(id);
    notifyListeners();
    if (!_isOffline) {
      _supabaseService
          .deleteLyric(id)
          .then((_) => _dbHelper.hardDeleteLyric(id))
          .catchError((e) {
            debugPrint("Failed to delete lyric cloud: $e");
          });
    }
  }

  Future<void> addLyric(Lyric lyric) async {
    await _dbHelper.upsertLyric(lyric);
    notifyListeners();
    if (!_isOffline) {
      _supabaseService
          .upsertLyric(lyric)
          .then((_) {
            _dbHelper.markLyricSynced(lyric.id);
          })
          .catchError((e) {
            debugPrint("Failed to push lyric: $e");
          });
    }
  }

  Future<List<Category>> getCategories() async {
    return await _dbHelper.readAllCategories();
  }

  Future<Category?> getCategory(String id) async {
    return await _dbHelper.getCategory(id);
  }

  Future<List<Lyric>> getLyrics(String categoryId) =>
      _dbHelper.readLyricsByCategory(categoryId);
  Future<List<Lyric>> searchLyrics(String query) =>
      _dbHelper.searchLyrics(query);
  Future<Lyric?> getLyric(String id) => _dbHelper.getLyricById(id);

  Future<int> getLyricsCount(String categoryId) async {
    final lyrics = await _dbHelper.readLyricsByCategory(categoryId);
    return lyrics.length;
  }

  Future<int> getNextSequenceNumber(String categoryId) async {
    final max = await _dbHelper.getMaxSequenceNumber(categoryId);
    return max + 1;
  }
}
