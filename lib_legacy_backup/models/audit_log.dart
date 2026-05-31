/// Modelo para logs de auditoria de operações CRUD.
class AuditLog {
  final String id;
  final String tableName;
  final String recordId;
  final String action;
  final Map<String, dynamic>? oldData;
  final Map<String, dynamic>? newData;
  final String? userId;
  final String? userEmail;
  final DateTime createdAt;

  AuditLog({
    required this.id,
    required this.tableName,
    required this.recordId,
    required this.action,
    this.oldData,
    this.newData,
    this.userId,
    this.userEmail,
    required this.createdAt,
  });

  factory AuditLog.fromMap(Map<String, dynamic> map) {
    return AuditLog(
      id: map['id']?.toString() ?? '',
      tableName: map['table_name']?.toString() ?? '',
      recordId: map['record_id']?.toString() ?? '',
      action: map['action']?.toString() ?? '',
      oldData: map['old_data'] as Map<String, dynamic>?,
      newData: map['new_data'] as Map<String, dynamic>?,
      userId: map['user_id']?.toString(),
      userEmail: map['user_email']?.toString(),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  /// Retorna um rótulo amigável para a ação.
  String get actionLabel {
    switch (action) {
      case 'INSERT':
        return 'Criação';
      case 'UPDATE':
        return 'Edição';
      case 'DELETE':
        return 'Exclusão';
      default:
        return action;
    }
  }

  /// Retorna um rótulo amigável para a tabela.
  String get tableLabel {
    switch (tableName) {
      case 'categories':
        return 'Categoria';
      case 'lyrics':
        return 'Letra';
      default:
        return tableName;
    }
  }

  /// Retorna o nome do registro afetado (se disponível).
  String get recordName {
    if (action == 'DELETE' && oldData != null) {
      return oldData!['name']?.toString() ??
          oldData!['title']?.toString() ??
          recordId;
    }
    if (newData != null) {
      return newData!['name']?.toString() ??
          newData!['title']?.toString() ??
          recordId;
    }
    return recordId;
  }
}
