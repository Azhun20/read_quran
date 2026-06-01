import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_search/domain/usecases/get_quran_search_list_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

part 'quran_search_state.dart';
part 'quran_search_cubit.freezed.dart';

/// A Cubit responsible for managing Quran search functionality.
///
/// This cubit handles the presentation layer logic for searching Quran verses
/// by keywords and filtering results by specific surahs. It follows the BLoC
/// (Business Logic Component) pattern using the Cubit variant for simpler
/// state management.
///
/// **Architecture Layer**: Presentation Layer
///
/// **State Management Pattern**: Cubit (simplified BLoC)
///
/// **States Managed**:
/// - [QuranSearchState] containing:
///   - `isLoading`: Loading indicator for search operations
///   - `errorMessage`: Error messages from failed searches
///   - `searchResults`: List of [AyahEntity] matching the search
///   - `searchKeyword`: Current search keyword
///   - `selectedSurahNumber`: Optional filter for specific surah
///   - `resultCount`: Number of search results found
///
/// **Dependencies**:
/// - [SearchQuranUseCase]: Domain use case for searching Quran verses
///
/// **Usage Example**:
/// ```dart
/// final cubit = QuranSearchCubit(
///   searchQuranUseCase: getIt<SearchQuranUseCase>(),
/// );
///
/// // Search for verses containing "mercy"
/// await cubit.searchQuran(keyword: 'mercy');
///
/// // Filter by specific surah
/// cubit.filterBySurah(2); // Al-Baqarah
///
/// // Clear search results
/// cubit.clearSearch();
/// ```
///
/// **State Flow**:
/// ```
/// Initial State (empty search)
///   |
///   v
/// searchQuran() -> Loading State (isLoading: true)
///   |
///   v
/// Success: Results State (searchResults populated)
/// Failure: Error State (errorMessage set)
///   |
///   v
/// clearSearch() -> Initial State
/// ```
class QuranSearchCubit extends Cubit<QuranSearchState> {
  QuranSearchCubit({required SearchQuranUseCase searchQuranUseCase})
      : _searchQuranUseCase = searchQuranUseCase,
        super(const QuranSearchState());

  final SearchQuranUseCase _searchQuranUseCase;

  /// Searches for Quran verses containing the specified keyword.
  ///
  /// This method performs a full-text search across Quran verses, with an
  /// optional filter to limit results to a specific surah. It handles empty
  /// queries, loading states, and error conditions gracefully.
  ///
  /// **Parameters**:
  /// - [keyword]: The search term to look for in Quran verses (required).
  ///   Leading and trailing whitespace is trimmed automatically.
  /// - [surahNumber]: Optional surah number to filter results (1-114).
  ///   If null, searches across all surahs.
  ///
  /// **State Transitions**:
  /// 1. **Empty keyword**: Immediately emits empty results state
  ///    - `searchResults`: []
  ///    - `searchKeyword`: ''
  ///    - `resultCount`: 0
  ///    - `errorMessage`: null
  ///
  /// 2. **Loading state**: Before API call
  ///    - `isLoading`: true
  ///    - `errorMessage`: null (clears previous errors)
  ///    - `searchKeyword`: Updated to current keyword
  ///    - `selectedSurahNumber`: Updated to filter value
  ///
  /// 3. **Success state**: After successful search
  ///    - `isLoading`: false
  ///    - `searchResults`: List of matching [AyahEntity]
  ///    - `resultCount`: Number of results found
  ///    - `errorMessage`: null
  ///
  /// 4. **Error state**: After failed search
  ///    - `isLoading`: false
  ///    - `searchResults`: []
  ///    - `resultCount`: 0
  ///    - `errorMessage`: Failure message
  ///
  /// **Side Effects**:
  /// - Logs search attempt with keyword and surah filter via [AppLogger]
  /// - Logs success with result count
  /// - Logs errors with failure details
  ///
  /// **Error Handling**:
  /// - Network failures are caught and error message is displayed
  /// - Empty results are treated as success with zero count
  /// - Previous results are cleared on new search
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Search all surahs
  /// await cubit.searchQuran(keyword: 'mercy');
  ///
  /// // Search within specific surah
  /// await cubit.searchQuran(keyword: 'mercy', surahNumber: 2);
  ///
  /// // Empty search clears results
  /// await cubit.searchQuran(keyword: '');
  /// ```
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

  /// Filters current search results by a specific surah.
  ///
  /// This method applies a surah filter to the current search. If a search
  /// keyword exists, it triggers a new search with the filter applied.
  /// Otherwise, it just updates the selected surah number in the state.
  ///
  /// **Parameters**:
  /// - [surahNumber]: The surah number to filter by (1-114), or null to
  ///   remove the filter and search all surahs.
  ///
  /// **Behavior**:
  /// - If a search keyword exists in state:
  ///   - Triggers a new search with [searchQuran] using the current keyword
  ///     and the new surah filter
  ///   - Results in a full loading/success/error cycle
  /// - If no search keyword exists:
  ///   - Simply updates `selectedSurahNumber` in state
  ///   - No API call is made
  ///
  /// **State Transitions**:
  /// - **With existing search**: Delegates to [searchQuran], see its documentation
  /// - **Without search**: Only updates `selectedSurahNumber` field
  ///
  /// **Usage Example**:
  /// ```dart
  /// // First search for a keyword
  /// await cubit.searchQuran(keyword: 'mercy');
  ///
  /// // Filter results to Al-Baqarah (Surah 2)
  /// cubit.filterBySurah(2);
  ///
  /// // Remove filter and search all surahs
  /// cubit.filterBySurah(null);
  /// ```
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

  /// Clears all search results and resets to initial state.
  ///
  /// This method resets the search state to its initial empty state,
  /// clearing all search results, keywords, filters, and errors.
  ///
  /// **State Transitions**:
  /// Emits a new state with all fields reset:
  /// - `searchResults`: [] (empty list)
  /// - `searchKeyword`: '' (empty string)
  /// - `selectedSurahNumber`: null (no filter)
  /// - `resultCount`: 0 (no results)
  /// - `errorMessage`: null (no errors)
  ///
  /// **Use Cases**:
  /// - User clears the search input
  /// - User navigates away from search screen
  /// - User wants to start a fresh search
  /// - Resetting UI to initial state
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Perform a search
  /// await cubit.searchQuran(keyword: 'mercy');
  ///
  /// // Later, clear everything
  /// cubit.clearSearch();
  ///
  /// // State is now back to initial with no results
  /// print(cubit.state.searchResults.isEmpty); // true
  /// print(cubit.state.searchKeyword); // ''
  /// ```
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
