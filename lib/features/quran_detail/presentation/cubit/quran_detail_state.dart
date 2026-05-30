part of 'quran_detail_cubit.dart';

@freezed
abstract class QuranDetailState with _$QuranDetailState {
  const factory QuranDetailState({
    @Default(false) bool isLoading,
    String? errorMessage,
    SurahEntity? surah,
    @Default([]) List<AyahEntity> ayahs,
    @Default(false) bool isPlaying,
    @Default(0) int currentAyahIndex,
    Duration? currentPosition,
    Duration? totalDuration,
    @Default(1.0) double playbackSpeed,
    @Default(1.0) double volume,
  }) = _QuranDetailState;
}
