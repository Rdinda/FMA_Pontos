import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lyric.dart';
import 'db_helper.dart';

/// Modelo para estatísticas de reprodução de um ponto
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

/// Serviço para gerenciar estatísticas de reprodução de pontos
class PlayStatsService {
  final SupabaseClient _client = Supabase.instance.client;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Incrementa o contador de reproduções para um ponto
  Future<void> incrementPlayCount(String lyricId) async {
    try {
      // Usar upsert para criar ou atualizar o registro
      await _client.rpc(
        'increment_play_count',
        params: {'p_lyric_id': lyricId},
      );
      debugPrint('[PlayStatsService] Play count incremented for: $lyricId');
    } catch (e) {
      // Se a função RPC não existir, usar fallback com upsert manual
      debugPrint('[PlayStatsService] RPC failed, using fallback: $e');
      await _incrementPlayCountFallback(lyricId);
    }
  }

  /// Fallback: incrementa contador manualmente se RPC não existir
  Future<void> _incrementPlayCountFallback(String lyricId) async {
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
      debugPrint('[PlayStatsService] Error incrementing play count: $e');
      // Não lançar erro para não interromper a reprodução
    }
  }

  /// Retorna os pontos mais tocados com informações completas
  Future<List<LyricWithStats>> getTopPlayed({int limit = 20}) async {
    try {
      // Buscar estatísticas ordenadas por play_count
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
      debugPrint('[PlayStatsService] Error fetching top played: $e');
      return [];
    }
  }

  /// Retorna as estatísticas de um ponto específico
  Future<int> getPlayCount(String lyricId) async {
    try {
      final response = await _client
          .from('lyric_play_stats')
          .select('play_count')
          .eq('lyric_id', lyricId)
          .maybeSingle();

      return response?['play_count'] ?? 0;
    } catch (e) {
      debugPrint('[PlayStatsService] Error getting play count: $e');
      return 0;
    }
  }
}
