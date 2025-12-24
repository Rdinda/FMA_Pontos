import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import '../models/lyric.dart';

/// Singleton late instance set from main.dart
late AudioPlayerService audioPlayerServiceInstance;

class AudioPlayerService extends ChangeNotifier {
  final AudioHandler _audioHandler;
  final MyAudioHandler _myHandler;

  Lyric? _currentLyric;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // Playlist support
  List<Lyric> _playlist = [];
  int _currentIndex = -1;
  bool _isRepeatEnabled = false;

  // StreamSubscriptions
  StreamSubscription? _playbackStateSubscription;
  StreamSubscription? _mediaItemSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;

  Lyric? get currentLyric => _currentLyric;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;

  // Playlist getters
  List<Lyric> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get hasPlaylist => _playlist.isNotEmpty;
  bool get hasNext => _isRepeatEnabled || _currentIndex < _playlist.length - 1;
  bool get hasPrevious => _isRepeatEnabled || _currentIndex > 0;
  bool get isRepeatEnabled => _isRepeatEnabled;

  AudioPlayerService._(this._audioHandler, this._myHandler) {
    _setupListeners();
  }

  /// Factory method to create and initialize the service
  static Future<AudioPlayerService> create() async {
    final handler = MyAudioHandler();

    final audioHandler = await AudioService.init(
      builder: () => handler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.fmapontos.channel.audio',
        androidNotificationChannelName: 'FMA Pontos Audio',
        androidNotificationIcon: 'mipmap/ic_launcher',
        androidShowNotificationBadge: true,
        androidStopForegroundOnPause: false, // Keep notification when paused
      ),
    );

    final service = AudioPlayerService._(audioHandler, handler);
    return service;
  }

  void _setupListeners() {
    _durationSubscription = _myHandler.durationStream.listen((d) {
      _duration = d;
      notifyListeners();
    });

    _positionSubscription = _myHandler.positionStream.listen((p) {
      _position = p;
      notifyListeners();
    });

    _playbackStateSubscription = _audioHandler.playbackState.listen((state) {
      final playing = state.playing;
      if (_isPlaying != playing) {
        _isPlaying = playing;
        notifyListeners();
      }
    });

    _mediaItemSubscription = _audioHandler.mediaItem.listen((item) {
      if (item == null) {
        // _currentLyric = null; // Don't reset, we manage it ourselves
      }
      notifyListeners();
    });
  }

  Future<void> play(Lyric lyric) async {
    debugPrint('[AudioPlayerService] play() called for: ${lyric.title}');
    debugPrint('[AudioPlayerService] audioUrl: ${lyric.audioUrl}');
    debugPrint('[AudioPlayerService] localAudioPath: ${lyric.localAudioPath}');

    // If different lyric, prepare it
    if (_currentLyric?.id != lyric.id) {
      _currentLyric = lyric;
      notifyListeners();

      // Convert Lyric to MediaItem
      final mediaItem = MediaItem(
        id: lyric.id,
        album: 'Pontos',
        title: lyric.title,
        artist: 'FMA Pontos',
        artUri: null,
        extras: {'url': lyric.audioUrl, 'localPath': lyric.localAudioPath},
      );

      debugPrint('[AudioPlayerService] Calling playMediaItem...');
      await _audioHandler.playMediaItem(mediaItem);
    } else {
      // Toggle
      if (_isPlaying) {
        debugPrint('[AudioPlayerService] Pausing...');
        await _audioHandler.pause();
      } else {
        debugPrint('[AudioPlayerService] Resuming...');
        await _audioHandler.play();
      }
    }
  }

  Future<void> seek(Duration position) async {
    await _audioHandler.seek(position);
  }

  /// Play all lyrics as a playlist
  Future<void> playAll(List<Lyric> lyrics) async {
    if (lyrics.isEmpty) return;

    // Filter only lyrics with audio
    final lyricsWithAudio = lyrics
        .where(
          (l) =>
              (l.audioUrl != null && l.audioUrl!.isNotEmpty) ||
              (l.localAudioPath != null && l.localAudioPath!.isNotEmpty),
        )
        .toList();

    if (lyricsWithAudio.isEmpty) return;

    _playlist = lyricsWithAudio;
    _currentIndex = 0;

    // Set callbacks for playlist control
    _myHandler.onTrackComplete = _onTrackComplete;
    _myHandler.onSkipNext = () => skipNext();
    _myHandler.onSkipPrevious = () => skipPrevious();
    _myHandler.onToggleRepeat = () => toggleRepeat();

    debugPrint(
      '[AudioPlayerService] playAll() - Starting playlist with ${_playlist.length} tracks',
    );
    await _playCurrentTrack();
  }

  void _onTrackComplete() {
    debugPrint(
      '[AudioPlayerService] Track complete, hasNext: $hasNext, repeat: $_isRepeatEnabled',
    );
    if (_currentIndex < _playlist.length - 1) {
      // Has more tracks, go to next
      skipNext();
    } else if (_isRepeatEnabled) {
      // End of playlist but repeat is on, go back to first
      _currentIndex = 0;
      _playCurrentTrack();
    } else {
      // Playlist finished
      debugPrint('[AudioPlayerService] Playlist finished');
      clearPlaylist();
    }
  }

  Future<void> _playCurrentTrack() async {
    if (_currentIndex < 0 || _currentIndex >= _playlist.length) return;

    final lyric = _playlist[_currentIndex];
    _currentLyric = lyric;
    notifyListeners();

    final mediaItem = MediaItem(
      id: lyric.id,
      album: 'Pontos',
      title: lyric.title,
      artist: 'FMA Pontos',
      artUri: null,
      extras: {'url': lyric.audioUrl, 'localPath': lyric.localAudioPath},
    );

    debugPrint(
      '[AudioPlayerService] Playing track ${_currentIndex + 1}/${_playlist.length}: ${lyric.title}',
    );
    await _audioHandler.playMediaItem(mediaItem);
  }

  Future<void> skipNext() async {
    if (_playlist.isEmpty) return;
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
    } else if (_isRepeatEnabled) {
      _currentIndex = 0; // Loop back to first
    } else {
      return;
    }
    debugPrint('[AudioPlayerService] skipNext() - now at index $_currentIndex');
    await _playCurrentTrack();
  }

  Future<void> skipPrevious() async {
    if (_playlist.isEmpty) return;

    // Standard player behavior: if more than 3 seconds into the song, restart it
    // Otherwise, go to previous track
    if (_position.inSeconds > 3) {
      debugPrint(
        '[AudioPlayerService] skipPrevious() - restarting current track',
      );
      await seek(Duration.zero);
      return;
    }

    if (_currentIndex > 0) {
      _currentIndex--;
    } else if (_isRepeatEnabled) {
      _currentIndex = _playlist.length - 1; // Loop to last
    } else {
      // At start of playlist, just restart current track
      debugPrint(
        '[AudioPlayerService] skipPrevious() - at start, restarting track',
      );
      await seek(Duration.zero);
      return;
    }
    debugPrint(
      '[AudioPlayerService] skipPrevious() - now at index $_currentIndex',
    );
    await _playCurrentTrack();
  }

  void toggleRepeat() {
    _isRepeatEnabled = !_isRepeatEnabled;
    debugPrint(
      '[AudioPlayerService] toggleRepeat() - repeat: $_isRepeatEnabled',
    );
    notifyListeners();
  }

  Future<void> clearPlaylist() async {
    debugPrint('[AudioPlayerService] clearPlaylist()');
    _playlist = [];
    _currentIndex = -1;
    _myHandler.onTrackComplete = null;
    _myHandler.onSkipNext = null;
    _myHandler.onSkipPrevious = null;
    _myHandler.onToggleRepeat = null;
    await _audioHandler.stop(); // Await to ensure notification is cleared
    _currentLyric = null;
    _isPlaying = false;
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _audioHandler.pause();
    } else {
      await _audioHandler.play();
    }
  }

  @override
  void dispose() {
    _playbackStateSubscription?.cancel();
    _mediaItemSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _myHandler.onTrackComplete = null;
    _myHandler.onSkipNext = null;
    _myHandler.onSkipPrevious = null;
    _myHandler.onToggleRepeat = null;
    super.dispose();
  }
}

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();
  Duration _currentPosition = Duration.zero;

  // Callbacks for playlist control
  VoidCallback? onTrackComplete;
  VoidCallback? onSkipNext;
  VoidCallback? onSkipPrevious;
  VoidCallback? onToggleRepeat;

  // Repeat mode state
  AudioServiceRepeatMode _repeatMode = AudioServiceRepeatMode.none;

  // Custom streams to forward to UI
  Stream<Duration> get durationStream => _player.onDurationChanged;
  Stream<Duration> get positionStream => _player.onPositionChanged;

  MyAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    _player.onPositionChanged.listen((p) => _currentPosition = p);

    await _player.setAudioContext(
      AudioContext(
        android: const AudioContextAndroid(
          isSpeakerphoneOn: false,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.gain,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: const {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );

    // Initial state broadcast
    _broadcastState(playing: false, processingState: AudioProcessingState.idle);

    _player.onPlayerStateChanged.listen((state) {
      debugPrint('[MyAudioHandler] Player state changed: $state');
      _broadcastState(playing: state == PlayerState.playing);
    });

    _player.onPlayerComplete.listen((event) {
      debugPrint('[MyAudioHandler] Player completed');
      _broadcastState(
        playing: false,
        processingState: AudioProcessingState.completed,
      );
      // Call the callback to auto-advance to next track
      onTrackComplete?.call();
    });
  }

  void _broadcastState({bool? playing, AudioProcessingState? processingState}) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing ?? playbackState.value.playing)
            MediaControl.pause
          else
            MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.skipToPrevious,
          MediaAction.skipToNext,
          MediaAction.setRepeatMode,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState:
            processingState ??
            ((playing ?? playbackState.value.playing)
                ? AudioProcessingState.ready
                : AudioProcessingState.idle),
        playing: playing ?? playbackState.value.playing,
        updatePosition: _currentPosition,
        bufferedPosition: Duration.zero,
        speed: 1.0,
        queueIndex: 0,
        repeatMode: _repeatMode,
      ),
    );
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    debugPrint('[MyAudioHandler] playMediaItem called: ${mediaItem.title}');
    this.mediaItem.add(mediaItem);

    final localPath = mediaItem.extras?['localPath'] as String?;
    final url = mediaItem.extras?['url'] as String?;

    debugPrint('[MyAudioHandler] localPath: $localPath');
    debugPrint('[MyAudioHandler] url: $url');

    try {
      await _player.stop();

      if (localPath != null && localPath.isNotEmpty) {
        debugPrint('[MyAudioHandler] Playing from local file...');
        await _player.play(DeviceFileSource(localPath));
      } else if (url != null && url.isNotEmpty) {
        debugPrint('[MyAudioHandler] Playing from URL...');
        await _player.play(UrlSource(url));
      } else {
        debugPrint('[MyAudioHandler] ERROR: No audio source available!');
        _broadcastState(
          playing: false,
          processingState: AudioProcessingState.error,
        );
        return;
      }

      debugPrint('[MyAudioHandler] Play command sent successfully');
      _broadcastState(
        playing: true,
        processingState: AudioProcessingState.ready,
      );
    } catch (e, stack) {
      debugPrint('[MyAudioHandler] ERROR playing audio: $e');
      debugPrint('[MyAudioHandler] Stack trace: $stack');
      _broadcastState(
        playing: false,
        processingState: AudioProcessingState.error,
      );
    }
  }

  @override
  Future<void> play() async {
    debugPrint('[MyAudioHandler] play() - checking player state');

    // If the player was stopped (not just paused), we need to reload the media
    // resume() only works after pause(), not after stop()
    if (_player.state == PlayerState.stopped ||
        _player.state == PlayerState.completed) {
      debugPrint(
        '[MyAudioHandler] Player is stopped/completed, reloading media...',
      );
      final currentMediaItem = mediaItem.value;
      if (currentMediaItem != null) {
        await playMediaItem(currentMediaItem);
        return;
      }
    }

    debugPrint('[MyAudioHandler] Resuming playback...');
    await _player.resume();
  }

  @override
  Future<void> pause() async {
    debugPrint('[MyAudioHandler] pause()');
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> stop() async {
    debugPrint('[MyAudioHandler] stop() - stopping and clearing notification');
    await _player.stop();
    // Clear the media item to remove the notification
    mediaItem.add(null);
    _broadcastState(playing: false, processingState: AudioProcessingState.idle);
  }

  @override
  Future<void> skipToNext() async {
    debugPrint('[MyAudioHandler] skipToNext()');
    onSkipNext?.call();
  }

  @override
  Future<void> skipToPrevious() async {
    debugPrint('[MyAudioHandler] skipToPrevious()');
    onSkipPrevious?.call();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    debugPrint('[MyAudioHandler] setRepeatMode($repeatMode)');
    // Toggle between none and all
    _repeatMode = _repeatMode == AudioServiceRepeatMode.none
        ? AudioServiceRepeatMode.all
        : AudioServiceRepeatMode.none;
    _broadcastState();
    onToggleRepeat?.call();
  }
}
