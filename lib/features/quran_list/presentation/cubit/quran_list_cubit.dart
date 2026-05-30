import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_available_reciters_usecase.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_surah_list_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

part 'quran_list_state.dart';
part 'quran_list_cubit.freezed.dart';

class QuranListCubit extends Cubit<QuranListState> {
  QuranListCubit({
    required GetSurahListUseCase getSurahListUseCase,
    required GetAvailableRecitersUseCase getAvailableRecitersUseCase,
  })  : _getSurahListUseCase = getSurahListUseCase,
        _getAvailableRecitersUseCase = getAvailableRecitersUseCase,
        super(const QuranListState());

  final GetSurahListUseCase _getSurahListUseCase;
  final GetAvailableRecitersUseCase _getAvailableRecitersUseCase;

  /// Load the list of all Surahs
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

  /// Load available reciters
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
      if (surah.name?.toLowerCase().contains(lowercaseQuery) == true) {
        return true;
      }

      // Search by English name
      if (surah.englishName?.toLowerCase().contains(lowercaseQuery) == true) {
        return true;
      }

      // Search by English translation
      if (surah.englishNameTranslation
              ?.toLowerCase()
              .contains(lowercaseQuery) ==
          true) {
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
