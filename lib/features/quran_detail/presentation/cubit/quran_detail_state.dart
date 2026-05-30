part of 'quran_detail_cubit.dart';

@freezed
abstract class QuranDetailState with _$QuranDetailState {
  const factory QuranDetailState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(0) int value,
  }) = _QuranDetailState;
}
