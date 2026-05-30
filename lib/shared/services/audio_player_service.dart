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

  // Streams
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;
  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;

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
      if (state.processingState == ProcessingState.completed) {
        AppLogger.info('Audio playback completed');
        playNext();
      }
    });
  }

  /// Load a playlist of ayahs
  Future<void> loadPlaylist(List<AyahEntity> ayahs,
      {int startIndex = 0}) async {
    try {
      _playlist = ayahs;
      _currentIndex = startIndex;

      if (ayahs.isEmpty) {
        AppLogger.warning('Attempted to load empty playlist');
        return;
      }

      final firstAyah = ayahs[startIndex];
      if (firstAyah.audioUrl == null || firstAyah.audioUrl!.isEmpty) {
        AppLogger.error('No audio URL for ayah', firstAyah.number);
        return;
      }

      await _player.setUrl(firstAyah.audioUrl!);
      AppLogger.info('Loaded playlist with ${ayahs.length} ayahs');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load playlist', e, stackTrace);
      rethrow;
    }
  }

  /// Play or resume audio
  Future<void> play() async {
    try {
      await _player.play();
      AppLogger.info('Playing ayah ${_currentIndex + 1}');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to play audio', e, stackTrace);
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
      final nextAyah = _playlist![_currentIndex];

      if (nextAyah.audioUrl != null && nextAyah.audioUrl!.isNotEmpty) {
        try {
          await _player.setUrl(nextAyah.audioUrl!);
          await play();
          AppLogger.info('Playing next ayah: ${_currentIndex + 1}');
        } catch (e, stackTrace) {
          AppLogger.error('Failed to play next ayah', e, stackTrace);
        }
      }
    } else {
      AppLogger.info('Reached end of playlist');
      await stop();
    }
  }

  /// Play previous ayah in playlist
  Future<void> playPrevious() async {
    if (_playlist == null || _playlist!.isEmpty) return;

    if (_currentIndex > 0) {
      _currentIndex--;
      final prevAyah = _playlist![_currentIndex];

      if (prevAyah.audioUrl != null && prevAyah.audioUrl!.isNotEmpty) {
        try {
          await _player.setUrl(prevAyah.audioUrl!);
          await play();
          AppLogger.info('Playing previous ayah: ${_currentIndex + 1}');
        } catch (e, stackTrace) {
          AppLogger.error('Failed to play previous ayah', e, stackTrace);
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
      return;
    }

    _currentIndex = index;
    final ayah = _playlist![index];

    if (ayah.audioUrl != null && ayah.audioUrl!.isNotEmpty) {
      try {
        await _player.setUrl(ayah.audioUrl!);
        await play();
        AppLogger.info('Playing ayah at index: $index');
      } catch (e, stackTrace) {
        AppLogger.error('Failed to play ayah at index', e, stackTrace);
      }
    }
  }

  /// Dispose the audio player
  Future<void> dispose() async {
    try {
      await _player.dispose();
      _playlist = null;
      AppLogger.info('Audio player disposed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to dispose audio player', e, stackTrace);
    }
  }
}
