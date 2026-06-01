import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_available_reciters_usecase.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_surah_list_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

part 'quran_list_state.dart';
part 'quran_list_cubit.freezed.dart';

/// A Cubit responsible for managing the Quran surah list and reciter selection.
///
/// This cubit handles the presentation layer logic for displaying the list of
/// all 114 surahs in the Quran, managing available reciters, and providing
/// search/filter functionality. It follows the BLoC (Business Logic Component)
/// pattern using the Cubit variant for simplified state management.
///
/// **Architecture Layer**: Presentation Layer
///
/// **State Management Pattern**: Cubit (simplified BLoC)
///
/// **States Managed**:
/// - [QuranListState] containing:
///   - `isLoading`: Loading indicator for surah list fetching
///   - `isLoadingReciters`: Loading indicator for reciters fetching
///   - `errorMessage`: Error messages from failed operations
///   - `surahs`: Complete list of all [SurahEntity] (114 surahs)
///   - `filteredSurahs`: Filtered list based on search query
///   - `reciters`: List of available [ReciterEntity] for audio playback
///   - `selectedReciter`: Currently selected reciter
///   - `searchQuery`: Current search/filter query
///
/// **Dependencies**:
/// - [GetSurahListUseCase]: Domain use case for fetching all surahs
/// - [GetAvailableRecitersUseCase]: Domain use case for fetching reciters
///
/// **Usage Example**:
/// ```dart
/// final cubit = QuranListCubit(
///   getSurahListUseCase: getIt<GetSurahListUseCase>(),
///   getAvailableRecitersUseCase: getIt<GetAvailableRecitersUseCase>(),
/// );
///
/// // Initialize by loading both surahs and reciters
/// await cubit.initialize();
///
/// // Search for surahs
/// cubit.searchSurahs('Baqarah');
///
/// // Select a different reciter
/// cubit.selectReciter(reciterEntity);
/// ```
///
/// **State Flow**:
/// ```
/// Initial State (empty)
///   |
///   v
/// initialize() -> Parallel Loading (isLoading: true, isLoadingReciters: true)
///   |
///   v
/// Success: Loaded State (surahs and reciters populated)
/// Failure: Error State (errorMessage set)
///   |
///   v
/// searchSurahs() -> Filtered State (filteredSurahs updated)
/// ```
class QuranListCubit extends Cubit<QuranListState> {
  QuranListCubit({
    required GetSurahListUseCase getSurahListUseCase,
    required GetAvailableRecitersUseCase getAvailableRecitersUseCase,
  })  : _getSurahListUseCase = getSurahListUseCase,
        _getAvailableRecitersUseCase = getAvailableRecitersUseCase,
        super(const QuranListState());

  final GetSurahListUseCase _getSurahListUseCase;
  final GetAvailableRecitersUseCase _getAvailableRecitersUseCase;

  /// Loads the complete list of all 114 surahs from the Quran.
  ///
  /// This method fetches the entire list of surahs including their metadata
  /// such as Arabic names, English translations, revelation type (Meccan/Medinan),
  /// and verse counts. The fetched data populates both the full list and
  /// filtered list initially.
  ///
  /// **State Transitions**:
  /// 1. **Loading state**: Before API call
  ///    - `isLoading`: true
  ///    - `errorMessage`: null (clears previous errors)
  ///
  /// 2. **Success state**: After successful fetch
  ///    - `isLoading`: false
  ///    - `surahs`: Complete list of all [SurahEntity] (114 surahs)
  ///    - `filteredSurahs`: Initially set to all surahs
  ///    - `errorMessage`: null
  ///
  /// 3. **Error state**: After failed fetch
  ///    - `isLoading`: false
  ///    - `errorMessage`: Failure message describing the error
  ///
  /// **Side Effects**:
  /// - Logs error if loading fails via [AppLogger]
  /// - Logs success with count of loaded surahs
  ///
  /// **Error Handling**:
  /// - Network failures are caught and error message is set
  /// - Previous surah data is preserved on failure
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Load all surahs
  /// await cubit.loadSurahList();
  ///
  /// // Access loaded surahs
  /// final surahs = cubit.state.surahs; // 114 surahs
  /// ```
  Future<void> loadSurahList() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getSurahListUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Failed to load surah list', failure.message);
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      (surahs) {
        AppLogger.info('Loaded ${surahs.length} surahs');
        emit(state.copyWith(
          isLoading: false,
          surahs: surahs,
          filteredSurahs: surahs,
          errorMessage: null,
        ));
      },
    );
  }

  /// Loads the list of available Quran reciters for audio playback.
  ///
  /// This method fetches all available reciters who have recorded complete
  /// Quran recitations. It automatically selects a default reciter, preferring
  /// "ar.alafasy" (Mishary Rashid Alafasy) if available, otherwise selecting
  /// the first reciter in the list.
  ///
  /// **State Transitions**:
  /// 1. **Loading state**: Before API call
  ///    - `isLoadingReciters`: true
  ///
  /// 2. **Success state**: After successful fetch
  ///    - `isLoadingReciters`: false
  ///    - `reciters`: List of available [ReciterEntity]
  ///    - `selectedReciter`: Auto-selected default reciter
  ///      (Alafasy if available, otherwise first in list)
  ///
  /// 3. **Error state**: After failed fetch
  ///    - `isLoadingReciters`: false
  ///    - Reciters list remains unchanged
  ///
  /// **Default Reciter Selection Logic**:
  /// - Priority 1: Mishary Rashid Alafasy (identifier: 'ar.alafasy')
  /// - Priority 2: First reciter in the list
  /// - If no reciters available: selectedReciter remains null
  ///
  /// **Side Effects**:
  /// - Logs error if loading fails via [AppLogger]
  /// - Logs success with count of loaded reciters
  ///
  /// **Error Handling**:
  /// - Network failures are caught and logged
  /// - Previous reciter data is preserved on failure
  ///
  /// **Usage Example**:
  /// ```dart
  /// // Load available reciters
  /// await cubit.loadReciters();
  ///
  /// // Check selected reciter
  /// final reciter = cubit.state.selectedReciter;
  /// print(reciter?.englishName); // e.g., "Mishary Rashid Alafasy"
  /// ```
  Future<void> loadReciters() async {
    emit(state.copyWith(isLoadingReciters: true));

    final result = await _getAvailableRecitersUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Failed to load reciters', failure.message);
        emit(state.copyWith(isLoadingReciters: false));
      },
      (reciters) {
        AppLogger.info('Loaded ${reciters.length} reciters');

        // Set default reciter if available
        ReciterEntity? defaultReciter;
        if (reciters.isNotEmpty) {
          // Try to find Alafasy as default, otherwise use first
          defaultReciter = reciters.firstWhere(
            (r) => r.identifier == 'ar.alafasy',
            orElse: () => reciters.first,
          );
        }

        emit(state.copyWith(
          isLoadingReciters: false,
          reciters: reciters,
          selectedReciter: defaultReciter,
        ));
      },
    );
  }

  /// Search/filter surahs by name or number
  void searchSurahs(String query) {
    emit(state.copyWith(searchQuery: query));

    if (query.isEmpty) {
      emit(state.copyWith(filteredSurahs: state.surahs));
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filteredSurahs = state.surahs.where((surah) {
      // Search by number
      if (surah.number?.toString() == query) {
        return true;
      }

      // Search by Arabic name
      if (surah.name?.toLowerCase().contains(lowercaseQuery) ?? false) {
        return true;
      }

      // Search by English name
      if (surah.englishName?.toLowerCase().contains(lowercaseQuery) ?? false) {
        return true;
      }

      // Search by English translation
      if (surah.englishNameTranslation
              ?.toLowerCase()
              .contains(lowercaseQuery) ??
          false) {
        return true;
      }

      return false;
    }).toList();

    emit(state.copyWith(filteredSurahs: filteredSurahs));
  }

  /// Select a reciter
  void selectReciter(ReciterEntity reciter) {
    emit(state.copyWith(selectedReciter: reciter));
    AppLogger.info('Selected reciter: ${reciter.englishName}');
  }

  /// Clear search
  void clearSearch() {
    emit(state.copyWith(
      searchQuery: '',
      filteredSurahs: state.surahs,
    ));
  }

  /// Initialize the page by loading both surahs and reciters
  Future<void> initialize() async {
    await Future.wait([
      loadSurahList(),
      loadReciters(),
    ]);
  }
}
