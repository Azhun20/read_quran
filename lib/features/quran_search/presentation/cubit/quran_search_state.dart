part of 'quran_search_cubit.dart';

@freezed
abstract class QuranSearchState with _$QuranSearchState {
  const factory QuranSearchState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<AyahEntity> searchResults,
    @Default('') String searchKeyword,
    int? selectedSurahNumber,
    @Default(0) int resultCount,
  }) = _QuranSearchState;
}
