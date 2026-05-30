part of 'quran_list_cubit.dart';

@freezed
abstract class QuranListState with _$QuranListState {
  const factory QuranListState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingReciters,
    String? errorMessage,
    @Default([]) List<SurahEntity> surahs,
    @Default([]) List<SurahEntity> filteredSurahs,
    @Default([]) List<ReciterEntity> reciters,
    ReciterEntity? selectedReciter,
    @Default('') String searchQuery,
  }) = _QuranListState;
}
