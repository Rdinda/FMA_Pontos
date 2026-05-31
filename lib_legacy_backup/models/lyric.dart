class Lyric {
  final String id;
  final String categoryId;
  final String title;
  final String content;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isDeleted;
  final String? audioUrl;
  final String? localAudioPath;
  final String? youtubeLink;
  final int sequenceNumber;

  Lyric({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.updatedAt,
    this.isSynced = false,
    this.isDeleted = false,
    this.audioUrl,
    this.localAudioPath,
    this.youtubeLink,
    this.sequenceNumber = 0,
  });

  // For Local DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'content': content,
      'updated_at': updatedAt.toIso8601String(),
      'is_synced': isSynced ? 1 : 0,
      'is_deleted': isDeleted ? 1 : 0,
      'audio_url': audioUrl,
      'local_audio_path': localAudioPath,
      'youtube_link': youtubeLink,
      'sequence_number': sequenceNumber,
    };
  }

  // For Supabase
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'content': content,
      'updated_at': updatedAt.toIso8601String(),
      'audio_url': audioUrl,
      'youtube_link': youtubeLink,
      'sequence_number': sequenceNumber,
    };
  }

  factory Lyric.fromMap(Map<String, dynamic> map) {
    return Lyric(
      id: map['id']?.toString() ?? '',
      categoryId: map['category_id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(), // Fallback
      isSynced: (map['is_synced'] ?? 1) == 1,
      isDeleted: (map['is_deleted'] ?? 0) == 1,
      audioUrl: map['audio_url']?.toString(),
      localAudioPath: map['local_audio_path']?.toString(),
      youtubeLink: (map['youtube_link'] ?? map['youtube_url'])?.toString(),
      sequenceNumber: map['sequence_number'] is int
          ? map['sequence_number']
          : int.tryParse(map['sequence_number']?.toString() ?? '0') ?? 0,
    );
  }
}
