import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lyric_form_screen.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';
import '../services/auth_service.dart';
import '../services/favorites_service.dart';
import '../utils/snackbar_utils.dart';

class LyricViewScreen extends StatefulWidget {
  final Lyric lyric;

  const LyricViewScreen({super.key, required this.lyric});

  @override
  State<LyricViewScreen> createState() => _LyricViewScreenState();
}

class _LyricViewScreenState extends State<LyricViewScreen> {
  late Lyric _lyric;
  @override
  void initState() {
    super.initState();
    _lyric = widget.lyric;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_lyric.audioUrl == null && _lyric.localAudioPath == null) return;

    final audioService = Provider.of<AudioPlayerService>(
      context,
      listen: false,
    );
    await audioService.play(_lyric);
  }

  void _edit(BuildContext context) async {
    // Pause audio if editing (optional, strictly speaking we might want to keep it playing, but usually pausing is good UX when editing)
    // _audioPlayer.pause(); // We can remove this for now or use service to pause if desired. Let's keep it playing as per request "keep playing".

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            LyricFormScreen(categoryId: _lyric.categoryId, lyric: _lyric),
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context); // Pop LyricViewScreen if lyric was deleted
    } else if (context.mounted) {
      // Refresh local data after edit
      final repo = Provider.of<SyncRepository>(context, listen: false);
      final updated = await repo.getLyric(_lyric.id);
      if (updated != null) {
        setState(() {
          _lyric = updated;
        });
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir Letra?"),
        content: const Text("Esta ação não pode ser desfeita."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = Provider.of<SyncRepository>(context, listen: false);
              await repo.deleteLyric(_lyric.id);
              if (mounted) {
                Navigator.pop(context);
                final updated = await repo.getLyric(_lyric.id);
                if (updated == null && mounted) {
                  // Verifica se foi realmente deletado ou se precisa de feedback
                  // Mas o código original apenas fazia pop e snackbar.
                  // Vamos manter original, mas usando SnackbarUtils que eu introduzi anteriormente
                  // Ah, espera, no Step 20 eu já tinha mudado para SnackbarUtils!
                  // Mas a leitura do arquivo no Step 100 mostrou ScaffoldMessenger!?
                  // VAMOS INVESTIGAR ISSO.
                  SnackbarUtils.show(
                    context,
                    message: 'Letra excluída com sucesso.',
                  );
                }
              }
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _lyric.title.toUpperCase(),
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
          Consumer<AuthService>(
            builder: (context, authService, child) {
              final canEdit = authService.canEditLyrics;
              final canDelete = authService.canDeleteLyrics;

              if (!canEdit && !canDelete) return const SizedBox.shrink();

              // Se só puder editar (Moderator)
              if (canEdit && !canDelete) {
                return IconButton(
                  onPressed: () => _edit(context),
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Editar',
                );
              }

              // Se puder deletar (Admin)
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (canEdit)
                    IconButton(
                      onPressed: () => _edit(context),
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Editar',
                    ),
                  if (canDelete)
                    IconButton(
                      onPressed: () => _confirmDelete(), // fix argument count
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Excluir',
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final repo = Provider.of<SyncRepository>(context, listen: false);
          await repo.syncData();
          final updated = await repo.getLyric(_lyric.id);
          if (updated != null && mounted) {
            setState(() {
              _lyric = updated;
            });
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Consumer<AudioPlayerService>(
                builder: (context, audioService, child) {
                  final isCurrentLyric =
                      audioService.currentLyric?.id == _lyric.id;
                  final isPlaying = isCurrentLyric && audioService.isPlaying;
                  final duration = isCurrentLyric
                      ? audioService.duration
                      : Duration.zero;
                  final position = isCurrentLyric
                      ? audioService.position
                      : Duration.zero;

                  return Column(
                    children: [
                      if (_lyric.audioUrl != null ||
                          _lyric.localAudioPath != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _togglePlay,
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause_circle_filled
                                          : Icons.play_circle_filled,
                                    ),
                                    iconSize: 48,
                                    color: colorScheme.primary,
                                  ),
                                  // Botão de favoritar
                                  Consumer<FavoritesService>(
                                    builder: (context, favService, child) {
                                      final isFav = favService.isFavorite(
                                        _lyric.id,
                                      );
                                      return IconButton(
                                        onPressed: () async {
                                          final wasFav = favService.isFavorite(
                                            _lyric.id,
                                          );
                                          // Capturar messenger antes do await
                                          final messenger =
                                              ScaffoldMessenger.of(context);
                                          await favService.toggleFavorite(
                                            _lyric.id,
                                          );
                                          if (!mounted) return;
                                          messenger.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                wasFav
                                                    ? 'Removido dos favoritos'
                                                    : 'Adicionado aos favoritos',
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                        ),
                                        iconSize: 28,
                                        color: isFav
                                            ? colorScheme.error
                                            : colorScheme.onSurfaceVariant,
                                        tooltip: isFav
                                            ? 'Remover dos favoritos'
                                            : 'Adicionar aos favoritos',
                                      );
                                    },
                                  ),
                                  Expanded(
                                    child: Slider(
                                      min: 0,
                                      max: duration.inSeconds.toDouble() > 0
                                          ? duration.inSeconds.toDouble()
                                          : 1.0,
                                      value: position.inSeconds
                                          .toDouble()
                                          .clamp(
                                            0,
                                            duration.inSeconds.toDouble() > 0
                                                ? duration.inSeconds.toDouble()
                                                : 1.0,
                                          ),
                                      onChanged: (value) async {
                                        if (isCurrentLyric) {
                                          final newPosition = Duration(
                                            seconds: value.toInt(),
                                          );
                                          await audioService.seek(newPosition);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_formatDuration(position)),
                                    Text(_formatDuration(duration)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 40.0,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: colorScheme.outlineVariant),
                        ),
                        child: Text(
                          _lyric.content,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            height: 1.8,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
