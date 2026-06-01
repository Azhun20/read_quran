import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_search/domain/usecases/get_quran_search_list_usecase.dart';
import 'package:read_quran/features/quran_search/presentation/cubit/quran_search_cubit.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class MockSearchQuranUseCase implements SearchQuranUseCase {
  @override
  Future<Either<Failure, List<AyahEntity>>> call({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    if (keyword == 'error') {
      return const Left(ServerFailure(message: 'Search failed'));
    }

    if (keyword.isEmpty) {
      return const Right([]);
    }

    // Return mock results
    return Right([
      AyahEntity(
        number: 1,
        text: 'Mock ayah containing $keyword',
        numberInSurah: 1,
        juz: 1,
        page: 1,
        surahNumber: surahNumber ?? 1,
        surahName: 'Al-Fatihah',
        surahEnglishName: 'The Opener',
      ),
      AyahEntity(
        number: 2,
        text: 'Another ayah with $keyword',
        numberInSurah: 2,
        juz: 1,
        page: 1,
        surahNumber: surahNumber ?? 1,
        surahName: 'Al-Fatihah',
        surahEnglishName: 'The Opener',
      ),
    ]);
  }
}

void main() {
  late QuranSearchCubit cubit;
  late MockSearchQuranUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSearchQuranUseCase();
    cubit = QuranSearchCubit(searchQuranUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('QuranSearchCubit', () {
    test('initial state should be QuranSearchState with empty values', () {
      expect(cubit.state.searchResults, isEmpty);
      expect(cubit.state.searchKeyword, isEmpty);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.resultCount, 0);
      expect(cubit.state.errorMessage, isNull);
    });

    blocTest<QuranSearchCubit, QuranSearchState>(
      'emits loading and success states when search is successful',
      build: () => cubit,
      act: (cubit) => cubit.searchQuran(keyword: 'Allah'),
      expect: () => [
        const QuranSearchState(
          isLoading: true,
          errorMessage: null,
          searchKeyword: 'Allah',
          selectedSurahNumber: null,
        ),
        QuranSearchState(
          isLoading: false,
          searchKeyword: 'Allah',
          searchResults: [
            AyahEntity(
              number: 1,
              text: 'Mock ayah containing Allah',
              numberInSurah: 1,
              juz: 1,
              page: 1,
              surahNumber: 1,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
            AyahEntity(
              number: 2,
              text: 'Another ayah with Allah',
              numberInSurah: 2,
              juz: 1,
              page: 1,
              surahNumber: 1,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
          ],
          resultCount: 2,
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'emits loading and error states when search fails',
      build: () => cubit,
      act: (cubit) => cubit.searchQuran(keyword: 'error'),
      expect: () => [
        const QuranSearchState(
          isLoading: true,
          errorMessage: null,
          searchKeyword: 'error',
          selectedSurahNumber: null,
        ),
        const QuranSearchState(
          isLoading: false,
          searchKeyword: 'error',
          errorMessage: 'Search failed',
          searchResults: [],
          resultCount: 0,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'emits empty results when keyword is empty',
      build: () => cubit,
      act: (cubit) => cubit.searchQuran(keyword: '   '),
      expect: () => [
        const QuranSearchState(
          searchResults: [],
          searchKeyword: '',
          resultCount: 0,
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'filters search by surah number',
      build: () => cubit,
      act: (cubit) => cubit.searchQuran(keyword: 'Rahman', surahNumber: 55),
      expect: () => [
        const QuranSearchState(
          isLoading: true,
          errorMessage: null,
          searchKeyword: 'Rahman',
          selectedSurahNumber: 55,
        ),
        QuranSearchState(
          isLoading: false,
          searchKeyword: 'Rahman',
          selectedSurahNumber: 55,
          searchResults: [
            AyahEntity(
              number: 1,
              text: 'Mock ayah containing Rahman',
              numberInSurah: 1,
              juz: 1,
              page: 1,
              surahNumber: 55,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
            AyahEntity(
              number: 2,
              text: 'Another ayah with Rahman',
              numberInSurah: 2,
              juz: 1,
              page: 1,
              surahNumber: 55,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
          ],
          resultCount: 2,
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'clears search results',
      build: () => cubit,
      seed: () => QuranSearchState(
        searchKeyword: 'test',
        searchResults: [
          AyahEntity(
            number: 1,
            text: 'Test ayah',
            numberInSurah: 1,
            juz: 1,
            page: 1,
          ),
        ],
        resultCount: 1,
      ),
      act: (cubit) => cubit.clearSearch(),
      expect: () => [
        const QuranSearchState(
          searchResults: [],
          searchKeyword: '',
          selectedSurahNumber: null,
          resultCount: 0,
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'filterBySurah triggers new search when keyword exists',
      build: () => cubit,
      seed: () => const QuranSearchState(searchKeyword: 'Allah'),
      act: (cubit) => cubit.filterBySurah(2),
      expect: () => [
        const QuranSearchState(
          isLoading: true,
          errorMessage: null,
          searchKeyword: 'Allah',
          selectedSurahNumber: 2,
        ),
        QuranSearchState(
          isLoading: false,
          searchKeyword: 'Allah',
          selectedSurahNumber: 2,
          searchResults: [
            AyahEntity(
              number: 1,
              text: 'Mock ayah containing Allah',
              numberInSurah: 1,
              juz: 1,
              page: 1,
              surahNumber: 2,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
            AyahEntity(
              number: 2,
              text: 'Another ayah with Allah',
              numberInSurah: 2,
              juz: 1,
              page: 1,
              surahNumber: 2,
              surahName: 'Al-Fatihah',
              surahEnglishName: 'The Opener',
            ),
          ],
          resultCount: 2,
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranSearchCubit, QuranSearchState>(
      'filterBySurah only updates state when keyword is empty',
      build: () => cubit,
      act: (cubit) => cubit.filterBySurah(3),
      expect: () => [
        const QuranSearchState(selectedSurahNumber: 3),
      ],
    );
  });
}
