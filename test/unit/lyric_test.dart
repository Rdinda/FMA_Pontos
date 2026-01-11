import 'package:flutter_test/flutter_test.dart';
import 'package:pontos/models/lyric.dart';

void main() {
  group('Lyric Model Tests', () {
    test('should correctly serialize and deserialize with youtubeLink', () {
      final now = DateTime.now();
      final lyric = Lyric(
        id: '1',
        categoryId: 'cat1',
        title: 'Test Lyric',
        content: 'Content',
        updatedAt: now,
        youtubeLink: 'https://youtu.be/12345',
      );

      final map = lyric.toMap();
      expect(map['youtube_link'], 'https://youtu.be/12345');

      final newLyric = Lyric.fromMap(map);
      expect(newLyric.youtubeLink, 'https://youtu.be/12345');
    });

    test('should handle null youtubeLink', () {
      final now = DateTime.now();
      final lyric = Lyric(
        id: '1',
        categoryId: 'cat1',
        title: 'Test Lyric',
        content: 'Content',
        updatedAt: now,
      );

      final map = lyric.toMap();
      expect(map.containsKey('youtube_link'), true);
      expect(map['youtube_link'], null);

      final newLyric = Lyric.fromMap(map);
      expect(newLyric.youtubeLink, null);
    });

    test('toSupabaseMap should include youtube_link', () {
      final now = DateTime.now();
      final lyric = Lyric(
        id: '1',
        categoryId: 'cat1',
        title: 'Test Lyric',
        content: 'Content',
        updatedAt: now,
        youtubeLink: 'https://youtu.be/12345',
      );

      final map = lyric.toSupabaseMap();
      expect(map['youtube_link'], 'https://youtu.be/12345');
    });
  });
}
