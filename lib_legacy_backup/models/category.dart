class Category {
  final String id;
  final String name;
  final String code; // Added code field
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;

  Category({
    required this.id,
    required this.name,
    required this.code,
    required this.updatedAt,
    this.isSynced = false,
    this.isDeleted = false,
  });

  // For Local DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'updated_at': updatedAt.toIso8601String(),
      'is_synced': isSynced ? 1 : 0,
      'is_deleted': isDeleted ? 1 : 0,
    };
  }

  // For Supabase
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'updated_at': updatedAt.toIso8601String()
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      code: map['code']?.toString() ?? '', // Handle missing code gracefully
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(), // Fallback
      isSynced: (map['is_synced'] ?? 1) == 1,
      isDeleted: (map['is_deleted'] ?? 0) == 1,
    );
  }
}
