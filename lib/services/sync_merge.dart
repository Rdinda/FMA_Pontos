import '../models/category.dart';
import '../models/lyric.dart';

/// LWW (last-write-wins) no registro inteiro via [updatedAt].
class SyncMerge {
  static Category mergeCategory(Category local, Category remote) {
    final winner = remote.updatedAt.isAfter(local.updatedAt) ? remote : local;
    return Category(
      id: local.id,
      name: winner.name,
      code: winner.code,
      updatedAt: winner.updatedAt,
      isSynced: false,
      isDeleted: winner.isDeleted,
    );
  }

  static Lyric mergeLyric(
    Lyric local,
    Lyric remote, {
    String? preservedLocalAudioPath,
  }) {
    final remoteWins = remote.updatedAt.isAfter(local.updatedAt);
    if (!remoteWins) {
      return Lyric(
        id: local.id,
        categoryId: local.categoryId,
        title: local.title,
        content: local.content,
        updatedAt: local.updatedAt,
        isSynced: false,
        isDeleted: local.isDeleted,
        audioUrl: local.audioUrl,
        localAudioPath: preservedLocalAudioPath ?? local.localAudioPath,
        youtubeLink: local.youtubeLink,
        sequenceNumber: local.sequenceNumber,
      );
    }

    String? audioPath = preservedLocalAudioPath ?? local.localAudioPath;
    if (remote.audioUrl != local.audioUrl) {
      if (remote.audioUrl == null) {
        audioPath = null;
      } else if (local.audioUrl != remote.audioUrl) {
        audioPath = null;
      }
    }

    return Lyric(
      id: local.id,
      categoryId: remote.categoryId,
      title: remote.title,
      content: remote.content,
      updatedAt: remote.updatedAt,
      isSynced: false,
      isDeleted: remote.isDeleted,
      audioUrl: remote.audioUrl,
      localAudioPath: audioPath,
      youtubeLink: remote.youtubeLink,
      sequenceNumber: remote.sequenceNumber,
    );
  }
}
