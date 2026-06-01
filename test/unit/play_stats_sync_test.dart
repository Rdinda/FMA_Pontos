import 'package:flutter_test/flutter_test.dart';
import 'package:pontos/services/play_stats_service.dart';

void main() {
  group('shouldEnqueueAccessForSession', () {
    test('anonymous session does not enqueue', () {
      expect(
        shouldEnqueueAccessForSession(isAnonymous: true),
        isFalse,
      );
    });

    test('null session does not enqueue', () {
      expect(shouldEnqueueAccessForSession(), isFalse);
    });

    test('authenticated non-anonymous user enqueues', () {
      expect(
        shouldEnqueueAccessForSession(isAnonymous: false),
        isTrue,
      );
    });
  });
}
