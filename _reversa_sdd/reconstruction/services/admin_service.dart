import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_info.dart';
import '../models/audit_log.dart';

/// Serviço administrativo para gerenciar permissões de usuários e logs de auditoria.
class AdminService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Busca todos os usuários cadastrados e seus respectivos papéis.
  Future<List<UserInfo>> fetchAllUsers() async {
    final response = await _client
        .from('user_roles')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => UserInfo.fromMap(json)).toList();
  }

  /// Atualiza o papel (role) de um usuário no sistema.
  Future<void> updateUserRole(String userId, String role) async {
    await _client.from('user_roles').update({
      'role': role,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  /// Ativa ou desativa um usuário no sistema.
  Future<void> setUserActive(String userId, bool isActive) async {
    await _client.from('user_roles').update({
      'is_active': isActive,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  /// Busca os logs de auditoria filtrados por tabela, data inicial e final.
  Future<List<AuditLog>> fetchAuditLogs({
    String? tableName,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) async {
    var query = _client.from('audit_logs').select();

    if (tableName != null && tableName.isNotEmpty) {
      query = query.eq('table_name', tableName);
    }

    if (startDate != null) {
      query = query.gte('created_at', startDate.toIso8601String());
    }

    if (endDate != null) {
      // Adiciona 1 dia à data de fim para englobar as últimas 24 horas daquele dia
      final endLimit = endDate.add(const Duration(days: 1));
      query = query.lt('created_at', endLimit.toIso8601String());
    }

    final response = await query.order('created_at', ascending: false).limit(limit);

    return (response as List).map((json) => AuditLog.fromMap(json)).toList();
  }

  /// Busca um log de auditoria específico pelo ID.
  Future<AuditLog?> fetchAuditLogById(String id) async {
    try {
      final response = await _client
          .from('audit_logs')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (response == null) return null;
      return AuditLog.fromMap(response);
    } catch (_) {
      return null;
    }
  }

  /// Retorna as estatísticas de auditoria agregadas por tabela.
  Future<Map<String, int>> getAuditStats() async {
    try {
      final categoriesCount = await _client
          .from('audit_logs')
          .select('id')
          .eq('table_name', 'categories');

      final lyricsCount = await _client
          .from('audit_logs')
          .select('id')
          .eq('table_name', 'lyrics');

      return {
        'categories': (categoriesCount as List).length,
        'lyrics': (lyricsCount as List).length,
      };
    } catch (_) {
      return {'categories': 0, 'lyrics': 0};
    }
  }
}
