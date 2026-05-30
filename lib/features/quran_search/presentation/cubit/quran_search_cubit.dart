import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';
import 'package:read_quran/features/quran_search/domain/usecases/get_quran_search_list_usecase.dart';

part 'quran_search_state.dart';
part 'quran_search_cubit.freezed.dart';

class QuranSearchCubit extends Cubit<QuranSearchState> {
  QuranSearchCubit({required SearchQuranUseCase searchQuranUseCase})
      : _searchQuranUseCase = searchQuranUseCase,
        super(const QuranSearchState());

  final SearchQuranUseCase _searchQuranUseCase;

  /// Search Quran verses by keyword
  Future<void> searchQuran({
    required String keyword,
    int? surahNumber,
  }) async {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        searchKeyword: '',
        resultCount: 0,
        errorMessage: null,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      searchKeyword: keyword,
      selectedSurahNumber: surahNumber,
    ));

    AppLogger.info(
      'Searching for: $keyword in surah: ${surahNumber ?? "all"}',
      'QuranSearchCubit',
    );

    final result = await _searchQuranUseCase(
      keyword: keyword,
      surahNumber: surahNumber,
      edition: 'quran-simple',
    );

    result.fold(
      (failure) {
        AppLogger.error(
          'Search failed: ${failure.message}',
          failure,
          null,
          'QuranSearchCubit',
        );
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          searchResults: [],
          resultCount: 0,
        ));
      },
      (ayahs) {
        AppLogger.info(
          'Search successful: ${ayahs.length} results',
          'QuranSearchCubit',
        );
        emit(state.copyWith(
          isLoading: false,
          searchResults: ayahs,
          resultCount: ayahs.length,
          errorMessage: null,
        ));
      },
    );
  }

  /// Filter search by specific surah
  void filterBySurah(int? surahNumber) {
    if (state.searchKeyword.isNotEmpty) {
      searchQuran(
        keyword: state.searchKeyword,
        surahNumber: surahNumber,
      );
    } else {
      emit(state.copyWith(selectedSurahNumber: surahNumber));
    }
  }

  /// Clear search results
  void clearSearch() {
    emit(state.copyWith(
      searchResults: [],
      searchKeyword: '',
      selectedSurahNumber: null,
      resultCount: 0,
      errorMessage: null,
    ));
  }
}
