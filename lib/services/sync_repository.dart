import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/lyric.dart';
import 'db_helper.dart';
import 'supabase_service.dart';

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
      // 1. PUSH Changes
      final unsyncedCategories = await _dbHelper.getUnsyncedCategories();
      for (var cat in unsyncedCategories) {
        if (cat.isDeleted) {
          await _supabaseService.deleteCategory(cat.id);
          await _dbHelper.hardDeleteCategory(cat.id);
        } else {
          await _supabaseService.upsertCategory(cat);
          await _dbHelper.markCategorySynced(cat.id);
        }
      }

      final unsyncedLyrics = await _dbHelper.getUnsyncedLyrics();
      for (var lyric in unsyncedLyrics) {
        if (lyric.isDeleted) {
          // Assuming SupabaseService has or we access client
          await _supabaseService.client
              .from('lyrics')
              .delete()
              .eq('id', lyric.id);
          await _dbHelper.hardDeleteLyric(lyric.id);
        } else {
          await _supabaseService.upsertLyric(lyric);
          await _dbHelper.markLyricSynced(lyric.id);
        }
      }

      // 2. PULL Changes
      final cloudCategories = await _supabaseService.fetchCategories();
      final cloudCategoryIds = cloudCategories.map((c) => c.id).toSet();

      // Upsert cloud items
      for (var cat in cloudCategories) {
        final localCat = Category(
          id: cat.id,
          name: cat.name,
          updatedAt: cat.updatedAt,
          isSynced: true,
          isDeleted: false,
        );
        await _dbHelper.upsertCategory(localCat);
      }

      // Delete local synced items not in cloud (Handle server wipe)
      final localSyncedCats = await _dbHelper.getSyncedCategories();
      for (var local in localSyncedCats) {
        if (!cloudCategoryIds.contains(local.id)) {
          await _dbHelper.hardDeleteCategory(local.id);
        }
      }

      final cloudLyrics = await _supabaseService.fetchLyrics();
      final cloudLyricIds = cloudLyrics.map((l) => l.id).toSet();

      // Upsert cloud items
      for (var lyric in cloudLyrics) {
        // Check if we already have this lyric and preserve local path if exists
        // Actually, dbHelper.upsertLyric replaces. We should check if we need to preserve something or if the cloud one has new data.
        // For audio path, the Cloud doesn't know about local paths. So we should probably merge or handle path persistence.
        // Since we added local_audio_path to the model and toMap/fromMap, if we create a Lyric from Cloud map, local_audio_path is NULL.
        // If we upsert, we overwrite local path with null! BAD.
        // FIX: Read existing local lyric first.

        // Read existing local lyric first.
        // Optimization: In real app we should have a more efficient query.
        final allLocal = await _dbHelper.readAllLyrics();
        final existing = allLocal.where((l) => l.id == lyric.id).firstOrNull;

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
        );
        await _dbHelper.upsertLyric(localLyric);
      }

      // Delete local synced items not in cloud
      final localSyncedLyrics = await _dbHelper.getSyncedLyrics();
      for (var local in localSyncedLyrics) {
        if (!cloudLyricIds.contains(local.id)) {
          // Also delete local audio file if exists?
          // Yes, good practice to clean up style.
          if (local.localAudioPath != null) {
            final file = File(local.localAudioPath!);
            if (await file.exists()) {
              await file.delete();
            }
          }
          await _dbHelper.hardDeleteLyric(local.id);
        }
      }

      // 3. Download Missing Audios
      await _downloadMissingAudios();
    } catch (e) {
      debugPrint("Sync Error: $e");
    } finally {
      _isSyncing = false;
      notifyListeners();
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
    // We need to know if there's audio to delete it from cloud storage
    // But we only have ID. Let's try to find it in local DB first.
    // Helper doesn't have getById.
    // Let's implement a quick query here or assume we can ignore if not found?
    // Better to be safe. I'll add getLyricById to DatabaseHelper.
    // Wait, I can't modify DatabaseHelper in this step easily unless I do another tool call.
    // I can do a raw query via dbHelper.database if exposed? No, it's a getter Future<Database>.

    // Workaround: We will use `_dbHelper.readAllLyrics` and find? Too slow.
    // Optimal: Add `getLyricById` to `DatabaseHelper`. I'll do that in next step.
    // For now, let's just add the call to delete audio logic assuming we have the URL or can get it?
    // Actually, I will pause this and update DatabaseHelper first.
    // Wait, I am in a tool call for `sync_repository.dart`.
    // I will try to implement the logic to delete audio IF I can get the URL.
    // Since I cannot get the URL easily without a DB query, I will chain the tasks.

    // Let's assume for this step I'm just adding the call to delete from supabase DB.
    // The user wants audio deleted from storage.
    // I need the lyric text/url.

    // Strategy:
    // 1. Fetch lyric from local DB.
    // 2. If present and has audioUrl, delete from storage.
    // 3. Delete from cloud DB (or soft delete).

    // Since I can't read by ID yet, I will use `readAllLyrics` (inefficient but works for now as dataset is small-ish) OR I modify DB helper first.
    // I will modify DB helper first. This tool call will be invalid if I don't write.
    // I will make NO changes to this file in this step and switch to DB helper.
    // Actually, I can just write the improved version now assuming `getLyricById` exists and then ADD it to db_helper in the NEXT step.
    // No, that will cause analysis error until next step.

    // Okay, I will use `_supabaseService.client` to select it from cloud before deleting?
    // Yes, that works for online deletions!

    await _dbHelper.softDeleteLyric(id);
    notifyListeners();
    if (!_isOffline) {
      try {
        // Fetch lyric from cloud to get audio_url before deleting
        final data = await _supabaseService.client
            .from('lyrics')
            .select('audio_url')
            .eq('id', id)
            .maybeSingle();

        if (data != null && data['audio_url'] != null) {
          await _supabaseService.deleteAudioByUrl(data['audio_url']);
        }

        await _supabaseService.client.from('lyrics').delete().eq('id', id);

        await _dbHelper.hardDeleteLyric(id);
      } catch (e) {
        debugPrint("Failed to delete lyric cloud: $e");
      }
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

  Future<List<Category>> getCategories() => _dbHelper.readAllCategories();
  Future<List<Lyric>> getLyrics(String categoryId) =>
      _dbHelper.readLyricsByCategory(categoryId);
  Future<List<Lyric>> searchLyrics(String query) =>
      _dbHelper.searchLyrics(query);
  Future<Lyric?> getLyric(String id) => _dbHelper.getLyricById(id);

  Future<int> getLyricsCount(String categoryId) async {
    final lyrics = await _dbHelper.readLyricsByCategory(categoryId);
    return lyrics.length;
  }
}
