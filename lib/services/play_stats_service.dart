import 'package:connectivity_plus/connectivity_plus.dart';
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

/// Regra RF-C02: só autenticados não anônimos enfileiram/contam acesso global.
bool shouldEnqueueAccessForSession({bool? isAnonymous}) {
  if (isAnonymous == null) return false;
  return !isAnonymous;
}

/// Serviço para estatísticas de acesso a pontos (visualização da letra).
class PlayStatsService {
  PlayStatsService._();
  static final PlayStatsService instance = PlayStatsService._();
  factory PlayStatsService() => instance;

  final SupabaseClient _client = Supabase.instance.client;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<bool> _isOffline() async {
    final results = await Connectivity().checkConnectivity();
    return results.contains(ConnectivityResult.none);
  }

  bool _canRecordAccess() {
    return shouldEnqueueAccessForSession(
      isAnonymous: _client.auth.currentUser?.isAnonymous,
    );
  }

  /// Incrementa o contador de acessos quando o usuário abre a letra.
  Future<void> incrementAccessCount(String lyricId) async {
    if (!_canRecordAccess()) {
      debugPrint(
        '[PlayStatsService] Skip access count (anonymous or no session)',
      );
      return;
    }

    if (await _isOffline()) {
      await _dbHelper.enqueuePendingAccessEvent(lyricId);
      debugPrint('[PlayStatsService] Queued offline access for: $lyricId');
      return;
    }

    final sent = await _rpcIncrement(lyricId);
    if (!sent) {
      await _dbHelper.enqueuePendingAccessEvent(lyricId);
      debugPrint(
        '[PlayStatsService] RPC failed; queued access for: $lyricId',
      );
    }
  }

  Future<bool> _rpcIncrement(String lyricId) async {
    try {
      await _client.rpc(
        'increment_play_count',
        params: {'p_lyric_id': lyricId},
      );
      debugPrint('[PlayStatsService] Access count incremented for: $lyricId');
      return true;
    } catch (e) {
      debugPrint('[PlayStatsService] RPC increment failed: $e');
      return false;
    }
  }

  /// Flush da fila local: N RPCs individuais (RF-C04, RF-C05).
  Future<int> flushPendingAccessEvents() async {
    if (!_canRecordAccess()) return 0;
    if (await _isOffline()) return 0;

    final pending = await _dbHelper.getUnflushedAccessEvents();
    var flushed = 0;

    for (final row in pending) {
      final id = row['id'] as int;
      final lyricId = row['lyric_id'] as String;
      final ok = await _rpcIncrement(lyricId);
      if (ok) {
        await _dbHelper.markAccessEventFlushed(id);
        flushed++;
      } else {
        break;
      }
    }

    if (flushed > 0) {
      debugPrint('[PlayStatsService] Flushed $flushed pending access event(s)');
    }
    return flushed;
  }

  Future<int> pendingAccessEventsCount() =>
      _dbHelper.countPendingAccessEvents();

  /// Retorna os pontos mais acessados com informações completas.
  Future<List<LyricWithStats>> getTopPlayed({int limit = 20}) async {
    try {
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
