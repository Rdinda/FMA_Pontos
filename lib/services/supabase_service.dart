import 'dart:io';
import 'package:flutter/foundation.dart' hide Category;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';
import '../models/lyric.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  // --- Categories ---

  Future<List<Category>> fetchCategories() async {
    final response = await client.from('categories').select();
    return (response as List).map((json) => Category.fromMap(json)).toList();
  }

  Future<void> upsertCategory(Category category) async {
    await client.from('categories').upsert(category.toSupabaseMap());
  }

  Future<void> deleteCategory(String id) async {
    // Delete related songs first to avoid FK issues (if any, though schema didn't explicit FK on songs)
    // Delete playlists pointing to this category?
    try {
      await client.from('categories').delete().eq('id', id);
    } catch (e) {
      // If delete fails, it might be due to FK constraints (like playlists)
      // We log it but locally we might still have issues
      rethrow;
    }
  }

  // --- Lyrics ---

  Future<List<Lyric>> fetchLyrics() async {
    final response = await client.from('lyrics').select();
    return (response as List).map((json) => Lyric.fromMap(json)).toList();
  }

  Future<void> upsertLyric(Lyric lyric) async {
    await client.from('lyrics').upsert(lyric.toSupabaseMap());
  }

  Future<void> deleteLyric(String id) async {
    await client.from('lyrics').delete().eq('id', id);
  }

  // --- Storage ---
  Future<String?> uploadAudio(
    String filePath,
    String fileName, {
    String bucketName = 'audio',
  }) async {
    try {
      final file = File(filePath);
      // Sanitize filename: replace spaces with _ and remove non-ASCII/unsafe characters
      final sanitizedFileName = fileName
          .replaceAll(' ', '_')
          .replaceAll(RegExp(r'[^\x20-\x7E]'), '') // Keep only printable ASCII
          .replaceAll(
            RegExp(r'[^\w.-]'),
            '',
          ); // Keep only alphanumeric, ., -, _

      final path = 'lyrics/$sanitizedFileName';

      // Upload file to Supabase Storage
      await client.storage
          .from(bucketName)
          .upload(
            path,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      // Get public URL
      final publicUrl = client.storage.from(bucketName).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      // Rethrow to handle in UI
      rethrow;
    }
  }

  Future<void> deleteAudio(
    String fileName, {
    String bucketName = 'audio',
  }) async {
    try {
      final path = 'lyrics/$fileName';
      await client.storage.from(bucketName).remove([path]);
    } catch (e) {
      debugPrint('Error deleting audio: $e');
    }
  }

  Future<void> deleteAudioByUrl(String url) async {
    try {
      // Extract file name from URL
      // URL format: .../storage/v1/object/public/audio/lyrics/filename.mp3
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      // pathSegments will be like ['storage', 'v1', 'object', 'public', 'audio', 'lyrics', 'filename.mp3']
      // We want 'filename.mp3'
      final fileName = pathSegments.last;

      await deleteAudio(fileName);
    } catch (e) {
      debugPrint('Error deleting audio by URL: $e');
    }
  }
}
