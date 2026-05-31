/// Sincronização de linhas de letra com a posição de reprodução (sem timestamps).
abstract final class LyricSync {
  /// Linhas não vazias, na ordem do texto.
  static List<String> parseLines(String content) {
    return content
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
  }

  /// Índice da linha ativa: reparte a duração igualmente entre as linhas.
  static int activeLineIndex({
    required Duration position,
    required Duration duration,
    required int lineCount,
  }) {
    if (lineCount <= 0) return 0;
    if (duration.inMilliseconds <= 0) return 0;

    final progress =
        (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
    final index = (progress * lineCount).floor();
    return index.clamp(0, lineCount - 1);
  }

  static String? activeLine({
    required String content,
    required Duration position,
    required Duration duration,
  }) {
    final lines = parseLines(content);
    if (lines.isEmpty) return null;
    final index = activeLineIndex(
      position: position,
      duration: duration,
      lineCount: lines.length,
    );
    return lines[index];
  }
}
