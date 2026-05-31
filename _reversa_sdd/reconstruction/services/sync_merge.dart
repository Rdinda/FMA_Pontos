import '../models/category.dart';
import '../models/lyric.dart';

/// Merge por campo entre cópia local (possivelmente não sincronizada) e remota.
class SyncMerge {
  static T _pickField<T>(
    T localValue,
    T remoteValue,
    DateTime localUpdatedAt,
    DateTime remoteUpdatedAt,
  ) {
    if (localValue == remoteValue) return localValue;
    if (remoteUpdatedAt.isAfter(localUpdatedAt)) return remoteValue;
    return localValue;
  }

  static DateTime _maxDateTime(DateTime a, DateTime b) =>
      a.isAfter(b) ? a : b;

  static Category mergeCategory(Category local, Category remote) {
    final mergedAt = _maxDateTime(local.updatedAt, remote.updatedAt);
    return Category(
      id: local.id,
      name: _pickField(
        local.name,
        remote.name,
        local.updatedAt,
        remote.updatedAt,
      ),
      code: _pickField(
        local.code,
        remote.code,
        local.updatedAt,
        remote.updatedAt,
      ),
      updatedAt: mergedAt,
      isSynced: false,
      isDeleted: local.isDeleted || remote.isDeleted,
    );
  }

  static Lyric mergeLyric(
    Lyric local,
    Lyric remote, {
    String? preservedLocalAudioPath,
  }) {
    final mergedAt = _maxDateTime(local.updatedAt, remote.updatedAt);
    final mergedAudioUrl = _pickField(
      local.audioUrl,
      remote.audioUrl,
      local.updatedAt,
      remote.updatedAt,
    );

    String? audioPath = preservedLocalAudioPath ?? local.localAudioPath;
    if (mergedAudioUrl != local.audioUrl && mergedAudioUrl != remote.audioUrl) {
      audioPath = preservedLocalAudioPath ?? local.localAudioPath;
    } else if (mergedAudioUrl != remote.audioUrl &&
        remote.updatedAt.isAfter(local.updatedAt)) {
      audioPath = null;
    }

    return Lyric(
      id: local.id,
      categoryId: _pickField(
        local.categoryId,
        remote.categoryId,
        local.updatedAt,
        remote.updatedAt,
      ),
      title: _pickField(
        local.title,
        remote.title,
        local.updatedAt,
        remote.updatedAt,
      ),
      content: _pickField(
        local.content,
        remote.content,
        local.updatedAt,
        remote.updatedAt,
      ),
      updatedAt: mergedAt,
      isSynced: false,
      isDeleted: local.isDeleted || remote.isDeleted,
      audioUrl: mergedAudioUrl,
      localAudioPath: audioPath,
      youtubeLink: _pickField(
        local.youtubeLink,
        remote.youtubeLink,
        local.updatedAt,
        remote.updatedAt,
      ),
      sequenceNumber: _pickField(
        local.sequenceNumber,
        remote.sequenceNumber,
        local.updatedAt,
        remote.updatedAt,
      ),
    );
  }
}
