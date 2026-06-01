import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';


/// Service to manage Quran audio playback
class AudioPlayerService {
  AudioPlayerService() {
    _init();
  }

  final AudioPlayer _player = AudioPlayer();
  List<AyahEntity>? _playlist;
  int _currentIndex = 0;
  final StreamController<int> _currentIndexController =
      StreamController<int>.broadcast();
  final StreamController<String?> _errorController =
      StreamController<String?>.broadcast();
  final StreamController<bool> _bufferingController =
      StreamController<bool>.broadcast();

  // Streams
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;
  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;
  Stream<int> get currentIndexStream => _currentIndexController.stream;
  Stream<String?> get errorStream => _errorController.stream;
  Stream<bool> get bufferingStream => _bufferingController.stream;

  // Getters
  AudioPlayer get player => _player;
  bool get isPlaying => _player.playing;
  Duration get position => _player.position;
  Duration? get duration => _player.duration;
  int get currentIndex => _currentIndex;
  AyahEntity? get currentAyah =>
      _playlist != null && _currentIndex < _playlist!.length
          ? _playlist![_currentIndex]
          : null;

  void _init() {
    // Listen to player state changes
    _player.playerStateStream.listen((state) {
      // Handle playback completion
      if (state.processingState == ProcessingState.completed) {
        AppLogger.info('Audio playback completed');
        playNext();
      }

      // Handle buffering
      final isBuffering = state.processingState == ProcessingState.buffering ||
          state.processingState == ProcessingState.loading;
      _bufferingController.add(isBuffering);

      if (isBuffering) {
        AppLogger.info('Audio buffering...');
      }
    });
  }

  /// Load a playlist of ayahs
  Future<void> loadPlaylist(List<AyahEntity> ayahs,
      {int startIndex = 0}) async {
    try {
      _playlist = ayahs;
      _currentIndex = startIndex;
      _currentIndexController.add(_currentIndex);

      if (ayahs.isEmpty) {
        AppLogger.warning('Attempted to load empty playlist');
        _errorController.add('No ayahs to play');
        return;
      }

      final firstAyah = ayahs[startIndex];
      if (firstAyah.audioUrl == null || firstAyah.audioUrl!.isEmpty) {
        AppLogger.error('No audio URL for ayah', firstAyah.number);
        _errorController.add('Audio not available for this ayah');
        return;
      }

      await _setAudioUrl(firstAyah.audioUrl!);
      AppLogger.info('Loaded playlist with ${ayahs.length} ayahs');
      _errorController.add(null); // Clear any previous errors
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load playlist', e, stackTrace);
      _errorController.add('Failed to load audio. Please check your connection.');
      rethrow;
    }
  }

  /// Set audio URL with retry logic
  Future<void> _setAudioUrl(String url, {int retryCount = 0}) async {
    const maxRetries = 3;
    try {
      await _player.setUrl(url);
    } catch (e) {
      if (retryCount < maxRetries) {
        AppLogger.warning('Failed to load audio, retrying... (${retryCount + 1}/$maxRetries)');
        await Future.delayed(Duration(seconds: retryCount + 1));
        return _setAudioUrl(url, retryCount: retryCount + 1);
      } else {
        AppLogger.error('Failed to load audio after $maxRetries retries', e);
        _errorController.add('Failed to load audio. Please check your connection.');
        rethrow;
      }
    }
  }

  /// Play or resume audio
  Future<void> play() async {
    try {
      await _player.play();
      AppLogger.info('Playing ayah ${_currentIndex + 1}');
      _errorController.add(null); // Clear any previous errors
    } catch (e, stackTrace) {
      AppLogger.error('Failed to play audio', e, stackTrace);
      _errorController.add('Failed to play audio. Please try again.');
      rethrow;
    }
  }

  /// Pause audio
  Future<void> pause() async {
    try {
      await _player.pause();
      AppLogger.info('Paused audio');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to pause audio', e, stackTrace);
    }
  }

  /// Stop audio and reset
  Future<void> stop() async {
    try {
      await _player.stop();
      await _player.seek(Duration.zero);
      AppLogger.info('Stopped audio');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stop audio', e, stackTrace);
    }
  }

  /// Play next ayah in playlist
  Future<void> playNext() async {
    if (_playlist == null || _playlist!.isEmpty) return;

    if (_currentIndex < _playlist!.length - 1) {
      _currentIndex++;
      _currentIndexController.add(_currentIndex);
      final nextAyah = _playlist![_currentIndex];

      if (nextAyah.audioUrl != null && nextAyah.audioUrl!.isNotEmpty) {
        try {
          await _setAudioUrl(nextAyah.audioUrl!);
          await play();
          AppLogger.info('Playing next ayah: ${_currentIndex + 1}');
        } catch (e, stackTrace) {
          AppLogger.error('Failed to play next ayah', e, stackTrace);
          _errorController.add('Failed to play next ayah. Please check your connection.');
        }
      }
    } else {
      // Reached end of playlist — reset to first ayah but stay paused
      _currentIndex = 0;
      _currentIndexController.add(_currentIndex);
      final firstAyah = _playlist![0];
      if (firstAyah.audioUrl != null && firstAyah.audioUrl!.isNotEmpty) {
        try {
          await _setAudioUrl(firstAyah.audioUrl!);
          await _player.pause();
          await _player.seek(Duration.zero);
        } catch (e, stackTrace) {
          AppLogger.error('Failed to reset to first ayah', e, stackTrace);
          _errorController.add('Failed to reset audio.');
        }
      }
      AppLogger.info('Reached end of playlist, reset to first ayah');
    }
  }

  /// Play previous ayah in playlist
  Future<void> playPrevious() async {
    if (_playlist == null || _playlist!.isEmpty) return;

    if (_currentIndex > 0) {
      _currentIndex--;
      _currentIndexController.add(_currentIndex);
      final prevAyah = _playlist![_currentIndex];

      if (prevAyah.audioUrl != null && prevAyah.audioUrl!.isNotEmpty) {
        try {
          await _setAudioUrl(prevAyah.audioUrl!);
          await play();
          AppLogger.info('Playing previous ayah: ${_currentIndex + 1}');
        } catch (e, stackTrace) {
          AppLogger.error('Failed to play previous ayah', e, stackTrace);
          _errorController.add('Failed to play previous ayah. Please check your connection.');
        }
      }
    } else {
      AppLogger.info('Already at first ayah');
    }
  }

  /// Seek to a specific position
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
      AppLogger.info('Seeked to ${position.inSeconds}s');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to seek', e, stackTrace);
    }
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      await _player.setSpeed(speed);
      AppLogger.info('Set playback speed to ${speed}x');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to set speed', e, stackTrace);
    }
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    try {
      await _player.setVolume(volume);
      AppLogger.info('Set volume to $volume');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to set volume', e, stackTrace);
    }
  }

  /// Play a specific ayah by index
  Future<void> playAyahAt(int index) async {
    if (_playlist == null || index < 0 || index >= _playlist!.length) {
      AppLogger.warning('Invalid ayah index: $index');
      _errorController.add('Invalid ayah selection');
      return;
    }

    _currentIndex = index;
    _currentIndexController.add(_currentIndex);
    final ayah = _playlist![index];

    if (ayah.audioUrl != null && ayah.audioUrl!.isNotEmpty) {
      try {
        await _setAudioUrl(ayah.audioUrl!);
        await play();
        AppLogger.info('Playing ayah at index: $index');
      } catch (e, stackTrace) {
        AppLogger.error('Failed to play ayah at index', e, stackTrace);
        _errorController.add('Failed to play ayah. Please check your connection.');
      }
    }
  }

  /// Dispose the audio player
  Future<void> dispose() async {
    try {
      await _currentIndexController.close();
      await _errorController.close();
      await _bufferingController.close();
      await _player.dispose();
      _playlist = null;
      AppLogger.info('Audio player disposed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to dispose audio player', e, stackTrace);
    }
  }
}
