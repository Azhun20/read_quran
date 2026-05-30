part of 'quran_search_cubit.dart';

@freezed
abstract class QuranSearchState with _$QuranSearchState {
  const factory QuranSearchState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(0) int value,
  }) = _QuranSearchState;
}
