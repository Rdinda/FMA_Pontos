import 'package:flutter/foundation.dart' hide Category;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../database/db_helper.dart';

/// Modelo para estatísticas de acesso a um ponto.
/// [playCount] mapeia a coluna `play_count` (contador de visualizações).
class LyricPlayStats {
  final String lyricId;
  final int playCount;
  final DateTime? lastPlayedAt;

  LyricPlayStats({
    required this.lyricId,
    required this.playCount,
    this.lastPlayedAt,
  });

  factory LyricPlayStats.fromMap(Map<String, dynamic> map) {
    return LyricPlayStats(
      lyricId: map['lyric_id']?.toString() ?? '',
      playCount: map['play_count'] ?? 0,
      lastPlayedAt: map['last_played_at'] != null
          ? DateTime.parse(map['last_played_at'])
          : null,
    );
  }
}

/// Modelo combinando Lyric com suas estatísticas
class LyricWithStats {
  final Lyric lyric;
  final int playCount;
  final String? categoryName;

  LyricWithStats({
    required this.lyric,
    required this.playCount,
    this.categoryName,
  });
}

/// Serviço para estatísticas de acesso a pontos (visualização da letra).
class PlayStatsService {
  final SupabaseClient _client = Supabase.instance.client;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Incrementa o contador de acessos quando o usuário abre a letra.
  /// Usa `play_count` / RPC `increment_play_count` no Supabase (semântica de acesso).
  Future<void> incrementAccessCount(String lyricId) async {
    try {
      await _client.rpc(
        'increment_play_count',
        params: {'p_lyric_id': lyricId},
      );
      debugPrint('[PlayStatsService] Access count incremented for: $lyricId');
    } catch (e) {
      debugPrint('[PlayStatsService] RPC failed, using fallback: $e');
      await _incrementAccessCountFallback(lyricId);
    }
  }

  /// Fallback: incrementa contador manualmente se RPC não existir.
  Future<void> _incrementAccessCountFallback(String lyricId) async {
    try {
      // Primeiro, tenta buscar o registro existente
      final existing = await _client
          .from('lyric_play_stats')
          .select()
          .eq('lyric_id', lyricId)
          .maybeSingle();

      if (existing != null) {
        // Atualiza o contador
        await _client
            .from('lyric_play_stats')
            .update({
              'play_count': (existing['play_count'] ?? 0) + 1,
              'last_played_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('lyric_id', lyricId);
      } else {
        // Insere novo registro
        await _client.from('lyric_play_stats').insert({
          'lyric_id': lyricId,
          'play_count': 1,
          'last_played_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
      debugPrint(
        '[PlayStatsService] Fallback increment successful for: $lyricId',
      );
    } catch (e) {
      debugPrint('[PlayStatsService] Error incrementing access count: $e');
    }
  }

  /// Retorna os pontos mais acessados com informações completas.
  Future<List<LyricWithStats>> getTopPlayed({int limit = 20}) async {
    try {
      // Buscar estatísticas ordenadas por play_count (contador de acessos)
      final statsResponse = await _client
          .from('lyric_play_stats')
          .select()
          .order('play_count', ascending: false)
          .limit(limit);

      final statsList = (statsResponse as List)
          .map((json) => LyricPlayStats.fromMap(json))
          .toList();

      if (statsList.isEmpty) {
        return [];
      }

      // Buscar os lyrics correspondentes do banco local
      final List<LyricWithStats> result = [];
      final categories = await _dbHelper.readAllCategories();
      final categoryMap = {for (var c in categories) c.id: c.name};

      for (final stats in statsList) {
        final lyric = await _dbHelper.getLyricById(stats.lyricId);
        if (lyric != null) {
          result.add(
            LyricWithStats(
              lyric: lyric,
              playCount: stats.playCount,
              categoryName: categoryMap[lyric.categoryId],
            ),
          );
        }
      }

      return result;
    } catch (e) {
      debugPrint('[PlayStatsService] Error fetching top accessed: $e');
      return [];
    }
  }

  /// Agrega acessos por categoria (via lyric_play_stats + lyrics locais).
  Future<Map<String, int>> getPlayCountByCategory() async {
    try {
      final statsResponse = await _client
          .from('lyric_play_stats')
          .select('lyric_id, play_count');

      final statsList = statsResponse as List;
      if (statsList.isEmpty) return {};

      final byCategory = <String, int>{};
      for (final row in statsList) {
        final lyricId = row['lyric_id']?.toString() ?? '';
        final count = (row['play_count'] as num?)?.toInt() ?? 0;
        if (lyricId.isEmpty || count <= 0) continue;

        final lyric = await _dbHelper.getLyricById(lyricId);
        if (lyric != null) {
          byCategory[lyric.categoryId] =
              (byCategory[lyric.categoryId] ?? 0) + count;
        }
      }
      return byCategory;
    } catch (e) {
      debugPrint('[PlayStatsService] Error aggregating category access: $e');
      return {};
    }
  }

  /// Categorias mais acessadas para a Home.
  ///
  /// Primário: soma de acessos ([lyric_play_stats.play_count]) por category_id.
  /// Fallback: total de pontos por categoria quando não há dados de acesso.
  Future<List<Category>> rankCategoriesByAccess(
    List<Category> categories, {
    required Future<int> Function(String categoryId) lyricsCountFor,
    int limit = 4,
  }) async {
    if (categories.isEmpty) return [];

    final accessByCategory = await getPlayCountByCategory();
    final hasAccessData = accessByCategory.values.any((v) => v > 0);

    final sorted = List<Category>.from(categories);
    if (hasAccessData) {
      sorted.sort(
        (a, b) => (accessByCategory[b.id] ?? 0).compareTo(
          accessByCategory[a.id] ?? 0,
        ),
      );
    } else {
      final counts = <String, int>{};
      for (final cat in categories) {
        counts[cat.id] = await lyricsCountFor(cat.id);
      }
      sorted.sort(
        (a, b) => (counts[b.id] ?? 0).compareTo(counts[a.id] ?? 0),
      );
    }

    return sorted.take(limit).toList();
  }

  /// Retorna quantidade de acessos de um ponto específico.
  Future<int> getPlayCount(String lyricId) async {
    try {
      final response = await _client
          .from('lyric_play_stats')
          .select('play_count')
          .eq('lyric_id', lyricId)
          .maybeSingle();

      return response?['play_count'] ?? 0;
    } catch (e) {
      debugPrint('[PlayStatsService] Error getting access count: $e');
      return 0;
    }
  }
}
