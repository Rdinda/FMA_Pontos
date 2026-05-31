import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_info.dart';
import '../models/audit_log.dart';

/// Serviço para operações administrativas.
///
/// Permite gerenciar usuários (roles, status) e consultar logs de auditoria.
class AdminService {
  final SupabaseClient _client = Supabase.instance.client;

  // ========================
  // GERENCIAMENTO DE USUÁRIOS
  // ========================

  /// Busca todos os usuários com suas roles.
  Future<List<UserInfo>> fetchAllUsers() async {
    try {
      final response = await _client
          .from('user_roles')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => UserInfo.fromMap(json)).toList();
    } catch (e) {
      debugPrint('[AdminService] Error fetching users: $e');
      rethrow;
    }
  }

  /// Atualiza a role de um usuário.
  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      await _client
          .from('user_roles')
          .update({
            'role': newRole,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);

      debugPrint('[AdminService] Updated role for $userId to $newRole');
    } catch (e) {
      debugPrint('[AdminService] Error updating role: $e');
      rethrow;
    }
  }

  /// Ativa ou desativa um usuário.
  Future<void> setUserActive(String userId, bool isActive) async {
    try {
      await _client
          .from('user_roles')
          .update({
            'is_active': isActive,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);

      debugPrint('[AdminService] Set user $userId active: $isActive');
    } catch (e) {
      debugPrint('[AdminService] Error setting user active: $e');
      rethrow;
    }
  }

  // ========================
  // LOGS DE AUDITORIA
  // ========================

  /// Busca logs de auditoria com filtros opcionais.
  Future<List<AuditLog>> fetchAuditLogs({
    String? tableName,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) async {
    try {
      var query = _client.from('audit_logs').select();

      // Aplicar filtros
      if (tableName != null && tableName.isNotEmpty) {
        query = query.eq('table_name', tableName);
      }

      if (startDate != null) {
        query = query.gte('created_at', startDate.toIso8601String());
      }

      if (endDate != null) {
        // Adicionar 1 dia para incluir o dia final completo
        final endOfDay = endDate.add(const Duration(days: 1));
        query = query.lt('created_at', endOfDay.toIso8601String());
      }

      final response = await query
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List).map((json) => AuditLog.fromMap(json)).toList();
    } catch (e) {
      debugPrint('[AdminService] Error fetching audit logs: $e');
      rethrow;
    }
  }

  /// Busca um log específico por ID.
  Future<AuditLog?> fetchAuditLogById(String id) async {
    try {
      final response = await _client
          .from('audit_logs')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response != null) {
        return AuditLog.fromMap(response);
      }
      return null;
    } catch (e) {
      debugPrint('[AdminService] Error fetching audit log: $e');
      return null;
    }
  }

  /// Conta total de logs (para estatísticas).
  Future<Map<String, int>> getAuditStats() async {
    try {
      final categoriesCount = await _client
          .from('audit_logs')
          .select()
          .eq('table_name', 'categories')
          .count(CountOption.exact);

      final lyricsCount = await _client
          .from('audit_logs')
          .select()
          .eq('table_name', 'lyrics')
          .count(CountOption.exact);

      return {'categories': categoriesCount.count, 'lyrics': lyricsCount.count};
    } catch (e) {
      debugPrint('[AdminService] Error getting stats: $e');
      return {'categories': 0, 'lyrics': 0};
    }
  }
}
