import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lyric_form_screen.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';
import '../services/audio_player_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Slightly off-white for contrast
      appBar: AppBar(
        centerTitle: true, // Requested: Center title
        title: Text(
          _lyric.title
              .toUpperCase(), // Capitalize (Upper case for title style?) or Title Case
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            onPressed: () => _edit(context),
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
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
                                    color: Colors.blue,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ), // Requested: Borders
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          _lyric.content,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            height: 1.8,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.left, // Requested: Left aligned
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
