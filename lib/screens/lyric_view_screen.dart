import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lyric_form_screen.dart';
import '../models/lyric.dart';
import '../services/sync_repository.dart';

class LyricViewScreen extends StatefulWidget {
  final Lyric lyric;

  const LyricViewScreen({super.key, required this.lyric});

  @override
  State<LyricViewScreen> createState() => _LyricViewScreenState();
}

class _LyricViewScreenState extends State<LyricViewScreen> {
  late Lyric _lyric;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _lyric = widget.lyric;

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          _duration = newDuration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          _position = newPosition;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_lyric.audioUrl == null) return;

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      // Use locally downloaded path if available for offline playback support preference
      // But _lyric.audioUrl is the HTTP URL.
      // Wait, the audio player might need local file path if offline.
      // SyncRepository downloads to local path.
      // We should prefer local path if available!
      // But _lyric.localAudioPath might be null if not synced yet?
      // Let's check.
      if (_lyric.localAudioPath != null) {
        await _audioPlayer.play(DeviceFileSource(_lyric.localAudioPath!));
      } else {
        await _audioPlayer.play(UrlSource(_lyric.audioUrl!));
      }
    }
  }

  void _edit(BuildContext context) async {
    // Pause audio if editing
    _audioPlayer.pause();

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
              child: Column(
                children: [
                  if (_lyric.audioUrl != null) ...[
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
                                  _isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_filled,
                                ),
                                iconSize: 48,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: _duration.inSeconds.toDouble(),
                                  value: _position.inSeconds.toDouble().clamp(
                                    0,
                                    _duration.inSeconds.toDouble(),
                                  ),
                                  onChanged: (value) async {
                                    final position = Duration(
                                      seconds: value.toInt(),
                                    );
                                    await _audioPlayer.seek(position);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(_position)),
                                Text(_formatDuration(_duration)),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
