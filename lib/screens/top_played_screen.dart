import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/play_stats_service.dart';
import '../services/audio_player_service.dart';
import '../widgets/category_player_widget.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';
import '../utils/snackbar_utils.dart';

/// Tela para exibir os pontos mais tocados da aplicação
class TopPlayedScreen extends StatefulWidget {
  const TopPlayedScreen({super.key});

  @override
  State<TopPlayedScreen> createState() => _TopPlayedScreenState();
}

class _TopPlayedScreenState extends State<TopPlayedScreen> {
  final PlayStatsService _statsService = PlayStatsService();
  List<LyricWithStats> _topPlayed = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTopPlayed();
  }

  Future<void> _loadTopPlayed() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final topPlayed = await _statsService.getTopPlayed(limit: 50);
      setState(() {
        _topPlayed = topPlayed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar: $e';
        _isLoading = false;
      });
    }
  }

  void _playAllTopPlayed() {
    if (_topPlayed.isEmpty) return;

    // Filtrar apenas os que têm áudio
    final lyricsWithAudio = _topPlayed
        .where(
          (item) =>
              (item.lyric.audioUrl != null &&
                  item.lyric.audioUrl!.isNotEmpty) ||
              (item.lyric.localAudioPath != null &&
                  item.lyric.localAudioPath!.isNotEmpty),
        )
        .map((item) => item.lyric)
        .toList();

    if (lyricsWithAudio.isEmpty) {
      SnackbarUtils.show(
        context,
        message: 'Nenhum ponto com áudio disponível',
        isError: true,
      );
      return;
    }

    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );
    audioService.playAll(lyricsWithAudio);

    SnackbarUtils.show(
      context,
      message: 'Reproduzindo ${lyricsWithAudio.length} pontos mais tocados',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais Tocados'),
        actions: [
          if (_topPlayed.isNotEmpty)
            IconButton(
              onPressed: _playAllTopPlayed,
              icon: const Icon(Icons.play_arrow_rounded),
              tooltip: 'Tocar todos',
            ),
          IconButton(
            onPressed: _loadTopPlayed,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: Column(
        children: [
          // Lista
          Expanded(child: _buildContent()),
          // Player no rodapé
          const CategoryPlayerWidget(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: _loadTopPlayed,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_topPlayed.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_off_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum ponto tocado ainda',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Explore as categorias e toque alguns pontos!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTopPlayed,
      child: Consumer<AudioPlayerService>(
        builder: (context, audioService, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _topPlayed.length,
            itemBuilder: (context, index) {
              final item = _topPlayed[index];
              return _buildLyricTile(item, index + 1, audioService);
            },
          );
        },
      ),
    );
  }

  Widget _buildLyricTile(
    LyricWithStats item,
    int rank,
    AudioPlayerService audioService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaying =
        audioService.currentLyric?.id == item.lyric.id &&
        audioService.isPlaying;
    final isCurrent = audioService.currentLyric?.id == item.lyric.id;
    final hasAudio =
        (item.lyric.audioUrl != null && item.lyric.audioUrl!.isNotEmpty) ||
        (item.lyric.localAudioPath != null &&
            item.lyric.localAudioPath!.isNotEmpty);

    // Cores especiais para top 3
    Color? rankColor;
    IconData? rankIcon;
    if (rank == 1) {
      rankColor = Colors.amber;
      rankIcon = Icons.emoji_events_rounded;
    } else if (rank == 2) {
      rankColor = Colors.grey.shade400;
      rankIcon = Icons.emoji_events_rounded;
    } else if (rank == 3) {
      rankColor = Colors.brown.shade300;
      rankIcon = Icons.emoji_events_rounded;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrent
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color:
                rankColor?.withValues(alpha: 0.2) ??
                (isCurrent
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (isCurrent)
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: isPlaying
                ? Icon(
                    Icons.graphic_eq,
                    color: rankColor ?? colorScheme.onPrimary,
                  )
                : (rankIcon != null
                      ? Icon(rankIcon, color: rankColor, size: 24)
                      : Text(
                          '$rank',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isCurrent
                                ? colorScheme.onPrimary
                                : colorScheme.onSurfaceVariant,
                          ),
                        )),
          ),
        ),
        title: Text(
          item.lyric.title.capitalize(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
            color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        subtitle: Row(
          children: [
            if (item.categoryName != null) ...[
              Icon(
                Icons.folder_outlined,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  item.categoryName!.capitalize(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.play_circle_outline,
              size: 14,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              '${item.playCount}',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasAudio)
              IconButton(
                icon: Icon(
                  isCurrent && isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  if (isCurrent && isPlaying) {
                    audioService.pause();
                  } else {
                    audioService.play(item.lyric);
                  }
                },
              ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LyricViewScreen(lyric: item.lyric),
            ),
          );
        },
      ),
    );
  }
}
