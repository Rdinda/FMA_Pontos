import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../models/lyric.dart';
import '../services/audio_player_service.dart';
import '../services/play_stats_service.dart';
import '../services/sync_repository.dart';
import '../widgets/category_player_widget.dart';
import 'lyric_view_screen.dart';
import '../utils/string_extensions.dart';

class TopPlayedScreen extends StatefulWidget {
  const TopPlayedScreen({super.key});

  @override
  State<TopPlayedScreen> createState() => _TopPlayedScreenState();
}

class _TopPlayedScreenState extends State<TopPlayedScreen> {
  final PlayStatsService _playStatsService = PlayStatsService();
  bool _isLoading = true;
  String? _errorMessage;
  List<LyricWithStats> _topPlayedList = [];
  Map<String, Category> _categoryMap = {};

  @override
  void initState() {
    super.initState();
    _fetchTopPlayed();
  }

  Future<void> _fetchTopPlayed() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = Provider.of<SyncRepository>(context, listen: false);
      
      // Carrega estatísticas globais
      final stats = await _playStatsService.getTopPlayed(limit: 50);
      
      // Carrega categorias locais para mapeamento completo
      final categories = await repo.getCategories();
      final catMap = {for (var c in categories) c.id: c};

      if (mounted) {
        setState(() {
          _topPlayedList = stats;
          _categoryMap = catMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[TopPlayedScreen] Error fetching data: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Não foi possível carregar as estatísticas.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Filtra letras jogáveis (com áudio válido)
    final playableLyrics = _topPlayedList
        .map((e) => e.lyric)
        .where((l) =>
            (l.audioUrl?.isNotEmpty ?? false) ||
            (l.localAudioPath?.isNotEmpty ?? false))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mais Tocados",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: colorScheme.onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actions: [
          if (!_isLoading && _errorMessage == null && playableLyrics.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              tooltip: 'Tocar Todas',
              onPressed: () async {
                final audioService = Provider.of<AudioPlayerService>(
                  context,
                  listen: false,
                );
                await audioService.playAll(playableLyrics);
              },
            ),
        ],
      ),
      body: _buildBody(context, playableLyrics),
      bottomSheet: const CategoryPlayerWidget(),
    );
  }

  Widget _buildBody(BuildContext context, List<Lyric> playableLyrics) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                "Ops, algo deu errado",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _fetchTopPlayed,
                icon: const Icon(Icons.refresh),
                label: const Text("Tentar novamente"),
              ),
            ],
          ),
        ),
      );
    }

    if (_topPlayedList.isEmpty) {
      return RefreshIndicator(
        onRefresh: _fetchTopPlayed,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.playlist_play,
                  size: 64,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  "Nenhum ponto tocado ainda",
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "As estatísticas de reprodução global aparecerão aqui assim que as músicas começarem a tocar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchTopPlayed,
      child: Consumer<AudioPlayerService>(
        builder: (context, audioService, child) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: _topPlayedList.length,
            itemBuilder: (ctx, i) {
              final statsItem = _topPlayedList[i];
              final lyric = statsItem.lyric;
              final category = _categoryMap[lyric.categoryId];

              return _buildRankingTile(
                context,
                i + 1,
                lyric,
                category,
                statsItem.playCount,
                audioService,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRankingTile(
    BuildContext context,
    int rank,
    Lyric lyric,
    Category? category,
    int playCount,
    AudioPlayerService audioService,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaying =
        audioService.currentLyric?.id == lyric.id && audioService.isPlaying;
    final isCurrent = audioService.currentLyric?.id == lyric.id;
    final hasAudio =
        (lyric.audioUrl?.isNotEmpty ?? false) ||
        (lyric.localAudioPath?.isNotEmpty ?? false);

    // Destaque visual e cores para o Top 3
    Color leadingBgColor;
    Widget leadingWidget;

    if (isCurrent && isPlaying) {
      leadingBgColor = colorScheme.primary;
      leadingWidget = Icon(Icons.graphic_eq, color: colorScheme.onPrimary);
    } else {
      switch (rank) {
        case 1:
          leadingBgColor = Colors.amber.shade700;
          leadingWidget = const Icon(Icons.emoji_events, color: Colors.white, size: 22);
          break;
        case 2:
          leadingBgColor = Colors.grey.shade600;
          leadingWidget = const Icon(Icons.emoji_events, color: Colors.white, size: 22);
          break;
        case 3:
          leadingBgColor = Colors.brown.shade600;
          leadingWidget = const Icon(Icons.emoji_events, color: Colors.white, size: 22);
          break;
        default:
          leadingBgColor = colorScheme.surfaceContainerHighest;
          leadingWidget = Text(
            rank.toString(),
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          );
      }
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
            color: leadingBgColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (isCurrent || rank <= 3)
                BoxShadow(
                  color: leadingBgColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(child: leadingWidget),
        ),
        title: Text(
          lyric.title.capitalize(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
            color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        subtitle: Row(
          children: [
            if (hasAudio) ...[
              Icon(Icons.music_note, size: 14, color: colorScheme.secondary),
              const SizedBox(width: 4),
            ],
            if (category != null) ...[
              Text(
                "${category.code}${lyric.sequenceNumber.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              "$playCount ${playCount == 1 ? 'tocada' : 'tocadas'}",
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.secondary,
                fontWeight: FontWeight.w600,
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
                  size: 28,
                ),
                onPressed: () {
                  if (isCurrent && isPlaying) {
                    audioService.pause();
                  } else {
                    audioService.play(lyric);
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
            MaterialPageRoute(builder: (_) => LyricViewScreen(lyric: lyric)),
          );
        },
      ),
    );
  }
}
