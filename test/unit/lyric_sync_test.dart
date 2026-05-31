import 'package:flutter_test/flutter_test.dart';
import 'package:pontos/utils/lyric_sync.dart';

void main() {
  group('LyricSync', () {
    test('parseLines removes empty lines', () {
      expect(
        LyricSync.parseLines('A\n\n B \n'),
        ['A', 'B'],
      );
    });

    test('activeLineIndex splits duration evenly', () {
      const duration = Duration(seconds: 100);
      const lines = 4;

      expect(
        LyricSync.activeLineIndex(
          position: Duration.zero,
          duration: duration,
          lineCount: lines,
        ),
        0,
      );
      expect(
        LyricSync.activeLineIndex(
          position: const Duration(seconds: 50),
          duration: duration,
          lineCount: lines,
        ),
        2,
      );
      expect(
        LyricSync.activeLineIndex(
          position: duration,
          duration: duration,
          lineCount: lines,
        ),
        3,
      );
    });

    test('activeLine returns line at computed index', () {
      final line = LyricSync.activeLine(
        content: 'Um\nDois\nTres',
        position: const Duration(seconds: 2),
        duration: const Duration(seconds: 3),
        );
      expect(line, 'Tres');
    });
  });
}
