import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_detail/domain/usecases/get_surah_detail_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';
import 'package:read_quran/shared/services/audio_player_service.dart';

part 'quran_detail_state.dart';
part 'quran_detail_cubit.freezed.dart';

class QuranDetailCubit extends Cubit<QuranDetailState> {
  QuranDetailCubit({
    required GetSurahDetailUseCase getSurahDetailUseCase,
    required AudioPlayerService audioPlayerService,
  })  : _getSurahDetailUseCase = getSurahDetailUseCase,
        _audioPlayerService = audioPlayerService,
        super(const QuranDetailState()) {
    _initAudioListeners();
  }

  final GetSurahDetailUseCase _getSurahDetailUseCase;
  final AudioPlayerService _audioPlayerService;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playingSubscription;
  StreamSubscription? _currentIndexSubscription;

  void _initAudioListeners() {
    // Listen to position changes
    _positionSubscription = _audioPlayerService.positionStream.listen((position) {
      emit(state.copyWith(currentPosition: position));
    });

    // Listen to duration changes
    _durationSubscription = _audioPlayerService.durationStream.listen((duration) {
      emit(state.copyWith(totalDuration: duration));
    });

    // Listen to playing state changes
    _playingSubscription = _audioPlayerService.playingStream.listen((isPlaying) {
      emit(state.copyWith(
        isPlaying: isPlaying,
        currentAyahIndex: _audioPlayerService.currentIndex,
      ));
    });

    // Listen to current ayah index changes
    _currentIndexSubscription = _audioPlayerService.currentIndexStream.listen((index) {
      emit(state.copyWith(currentAyahIndex: index));
    });
  }

  /// Load surah detail with ayahs
  Future<void> loadSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getSurahDetailUseCase(
      surahNumber: surahNumber,
      reciterIdentifier: reciterIdentifier,
    );

    result.fold(
      (failure) {
        AppLogger.error('Failed to load surah detail', failure.message);
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      (surahDetail) {
        AppLogger.info(
          'Loaded surah ${surahDetail.surah?.number} with ${surahDetail.ayahs?.length ?? 0} ayahs',
        );

        emit(state.copyWith(
          isLoading: false,
          surah: surahDetail.surah,
          ayahs: surahDetail.ayahs ?? [],
          errorMessage: null,
        ));

        // Load audio playlist
        if (surahDetail.ayahs != null && surahDetail.ayahs!.isNotEmpty) {
          _audioPlayerService.loadPlaylist(surahDetail.ayahs!);
        }
      },
    );
  }

  /// Play or pause audio
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _audioPlayerService.pause();
    } else {
      await _audioPlayerService.play();
    }
  }

  /// Play audio
  Future<void> play() async {
    await _audioPlayerService.play();
  }

  /// Pause audio
  Future<void> pause() async {
    await _audioPlayerService.pause();
  }

  /// Stop audio
  Future<void> stop() async {
    await _audioPlayerService.stop();
    emit(state.copyWith(
      isPlaying: false,
      currentPosition: Duration.zero,
    ));
  }

  /// Play next ayah
  Future<void> playNext() async {
    await _audioPlayerService.playNext();
  }

  /// Play previous ayah
  Future<void> playPrevious() async {
    await _audioPlayerService.playPrevious();
  }

  /// Seek to a position
  Future<void> seek(Duration position) async {
    await _audioPlayerService.seek(position);
  }

  /// Play specific ayah by index
  Future<void> playAyahAt(int index) async {
    await _audioPlayerService.playAyahAt(index);
  }

  /// Set playback speed
  Future<void> setPlaybackSpeed(double speed) async {
    await _audioPlayerService.setSpeed(speed);
    emit(state.copyWith(playbackSpeed: speed));
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    await _audioPlayerService.setVolume(volume);
    emit(state.copyWith(volume: volume));
  }

  @override
  Future<void> close() async {
    await _positionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _playingSubscription?.cancel();
    await _currentIndexSubscription?.cancel();
    await _audioPlayerService.stop();
    return super.close();
  }
}
