import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_available_reciters_usecase.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_surah_list_usecase.dart';
import 'package:read_quran/features/quran_list/presentation/cubit/quran_list_cubit.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

class _FakeQuranListRepository implements QuranListRepository {
  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    return const Right([]);
  }
}

class MockGetSurahListUseCase implements GetSurahListUseCase {
  final bool shouldFail;

  MockGetSurahListUseCase({this.shouldFail = false});

  @override
  QuranListRepository get repository => _FakeQuranListRepository();

  @override
  Future<Either<Failure, List<SurahEntity>>> call() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Failed to load surahs'));
    }

    return Right([
      SurahEntity(
        number: 1,
        name: 'الفاتحة',
        englishName: 'Al-Fatihah',
        englishNameTranslation: 'The Opener',
        numberOfAyahs: 7,
        revelationType: 'Meccan',
      ),
      SurahEntity(
        number: 2,
        name: 'البقرة',
        englishName: 'Al-Baqarah',
        englishNameTranslation: 'The Cow',
        numberOfAyahs: 286,
        revelationType: 'Medinan',
      ),
      SurahEntity(
        number: 55,
        name: 'الرحمن',
        englishName: 'Ar-Rahman',
        englishNameTranslation: 'The Beneficent',
        numberOfAyahs: 78,
        revelationType: 'Medinan',
      ),
    ]);
  }
}

class MockGetAvailableRecitersUseCase implements GetAvailableRecitersUseCase {
  final bool shouldFail;

  MockGetAvailableRecitersUseCase({this.shouldFail = false});

  @override
  QuranListRepository get repository => _FakeQuranListRepository();

  @override
  Future<Either<Failure, List<ReciterEntity>>> call() async {
    if (shouldFail) {
      return const Left(ServerFailure(message: 'Failed to load reciters'));
    }

    return const Right([
      ReciterEntity(
        identifier: 'ar.alafasy',
        name: 'مشاري العفاسي',
        englishName: 'Mishari Rashid Alafasy',
        format: 'audio',
        type: 'versebyverse',
        bitrate: '128',
      ),
      ReciterEntity(
        identifier: 'ar.abdulbasitmurattal',
        name: 'عبد الباسط عبد الصمد',
        englishName: 'AbdulBaset AbdulSamad',
        format: 'audio',
        type: 'versebyverse',
        bitrate: '64',
      ),
    ]);
  }
}

void main() {
  late QuranListCubit cubit;
  late MockGetSurahListUseCase mockGetSurahListUseCase;
  late MockGetAvailableRecitersUseCase mockGetAvailableRecitersUseCase;

  setUp(() {
    mockGetSurahListUseCase = MockGetSurahListUseCase();
    mockGetAvailableRecitersUseCase = MockGetAvailableRecitersUseCase();
    cubit = QuranListCubit(
      getSurahListUseCase: mockGetSurahListUseCase,
      getAvailableRecitersUseCase: mockGetAvailableRecitersUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('QuranListCubit', () {
    test('initial state should have default values', () {
      expect(cubit.state.surahs, isEmpty);
      expect(cubit.state.filteredSurahs, isEmpty);
      expect(cubit.state.reciters, isEmpty);
      expect(cubit.state.selectedReciter, isNull);
      expect(cubit.state.searchQuery, isEmpty);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.isLoadingReciters, false);
      expect(cubit.state.errorMessage, isNull);
    });

    blocTest<QuranListCubit, QuranListState>(
      'emits loading and success states when loadSurahList succeeds',
      build: () => cubit,
      act: (cubit) => cubit.loadSurahList(),
      expect: () => [
        const QuranListState(isLoading: true, errorMessage: null),
        QuranListState(
          isLoading: false,
          surahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
            SurahEntity(
              number: 2,
              name: 'البقرة',
              englishName: 'Al-Baqarah',
              englishNameTranslation: 'The Cow',
              numberOfAyahs: 286,
              revelationType: 'Medinan',
            ),
            SurahEntity(
              number: 55,
              name: 'الرحمن',
              englishName: 'Ar-Rahman',
              englishNameTranslation: 'The Beneficent',
              numberOfAyahs: 78,
              revelationType: 'Medinan',
            ),
          ],
          filteredSurahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
            SurahEntity(
              number: 2,
              name: 'البقرة',
              englishName: 'Al-Baqarah',
              englishNameTranslation: 'The Cow',
              numberOfAyahs: 286,
              revelationType: 'Medinan',
            ),
            SurahEntity(
              number: 55,
              name: 'الرحمن',
              englishName: 'Ar-Rahman',
              englishNameTranslation: 'The Beneficent',
              numberOfAyahs: 78,
              revelationType: 'Medinan',
            ),
          ],
          errorMessage: null,
        ),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'emits loading and error states when loadSurahList fails',
      build: () => QuranListCubit(
        getSurahListUseCase: MockGetSurahListUseCase(shouldFail: true),
        getAvailableRecitersUseCase: mockGetAvailableRecitersUseCase,
      ),
      act: (cubit) => cubit.loadSurahList(),
      expect: () => [
        const QuranListState(isLoading: true, errorMessage: null),
        const QuranListState(
          isLoading: false,
          errorMessage: 'Failed to load surahs',
        ),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'emits loading and success states when loadReciters succeeds',
      build: () => cubit,
      act: (cubit) => cubit.loadReciters(),
      expect: () => [
        const QuranListState(isLoadingReciters: true),
        const QuranListState(
          isLoadingReciters: false,
          reciters: [
            ReciterEntity(
              identifier: 'ar.alafasy',
              name: 'مشاري العفاسي',
              englishName: 'Mishari Rashid Alafasy',
              format: 'audio',
              type: 'versebyverse',
              bitrate: '128',
            ),
            ReciterEntity(
              identifier: 'ar.abdulbasitmurattal',
              name: 'عبد الباسط عبد الصمد',
              englishName: 'AbdulBaset AbdulSamad',
              format: 'audio',
              type: 'versebyverse',
              bitrate: '64',
            ),
          ],
          selectedReciter: ReciterEntity(
            identifier: 'ar.alafasy',
            name: 'مشاري العفاسي',
            englishName: 'Mishari Rashid Alafasy',
            format: 'audio',
            type: 'versebyverse',
            bitrate: '128',
          ),
        ),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'emits loading and error states when loadReciters fails',
      build: () => QuranListCubit(
        getSurahListUseCase: mockGetSurahListUseCase,
        getAvailableRecitersUseCase: MockGetAvailableRecitersUseCase(shouldFail: true),
      ),
      act: (cubit) => cubit.loadReciters(),
      expect: () => [
        const QuranListState(isLoadingReciters: true),
        const QuranListState(isLoadingReciters: false),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'filters surahs by number',
      build: () => cubit,
      seed: () => QuranListState(
        surahs: [
          SurahEntity(
            number: 1,
            name: 'الفاتحة',
            englishName: 'Al-Fatihah',
            englishNameTranslation: 'The Opener',
            numberOfAyahs: 7,
            revelationType: 'Meccan',
          ),
          SurahEntity(
            number: 2,
            name: 'البقرة',
            englishName: 'Al-Baqarah',
            englishNameTranslation: 'The Cow',
            numberOfAyahs: 286,
            revelationType: 'Medinan',
          ),
        ],
        filteredSurahs: [
          SurahEntity(
            number: 1,
            name: 'الفاتحة',
            englishName: 'Al-Fatihah',
            englishNameTranslation: 'The Opener',
            numberOfAyahs: 7,
            revelationType: 'Meccan',
          ),
          SurahEntity(
            number: 2,
            name: 'البقرة',
            englishName: 'Al-Baqarah',
            englishNameTranslation: 'The Cow',
            numberOfAyahs: 286,
            revelationType: 'Medinan',
          ),
        ],
      ),
      act: (cubit) => cubit.searchSurahs('1'),
      expect: () => [
        QuranListState(
          searchQuery: '1',
          surahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
            SurahEntity(
              number: 2,
              name: 'البقرة',
              englishName: 'Al-Baqarah',
              englishNameTranslation: 'The Cow',
              numberOfAyahs: 286,
              revelationType: 'Medinan',
            ),
          ],
          filteredSurahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
            SurahEntity(
              number: 2,
              name: 'البقرة',
              englishName: 'Al-Baqarah',
              englishNameTranslation: 'The Cow',
              numberOfAyahs: 286,
              revelationType: 'Medinan',
            ),
          ],
        ),
        QuranListState(
          searchQuery: '1',
          surahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
            SurahEntity(
              number: 2,
              name: 'البقرة',
              englishName: 'Al-Baqarah',
              englishNameTranslation: 'The Cow',
              numberOfAyahs: 286,
              revelationType: 'Medinan',
            ),
          ],
          filteredSurahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
          ],
        ),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'clears search and restores all surahs',
      build: () => cubit,
      seed: () => QuranListState(
        searchQuery: 'test',
        surahs: [
          SurahEntity(
            number: 1,
            name: 'الفاتحة',
            englishName: 'Al-Fatihah',
            englishNameTranslation: 'The Opener',
            numberOfAyahs: 7,
            revelationType: 'Meccan',
          ),
        ],
        filteredSurahs: [],
      ),
      act: (cubit) => cubit.clearSearch(),
      expect: () => [
        QuranListState(
          searchQuery: '',
          surahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
          ],
          filteredSurahs: [
            SurahEntity(
              number: 1,
              name: 'الفاتحة',
              englishName: 'Al-Fatihah',
              englishNameTranslation: 'The Opener',
              numberOfAyahs: 7,
              revelationType: 'Meccan',
            ),
          ],
        ),
      ],
    );

    blocTest<QuranListCubit, QuranListState>(
      'selects a reciter',
      build: () => cubit,
      act: (cubit) => cubit.selectReciter(
        const ReciterEntity(
          identifier: 'ar.abdulbasitmurattal',
          englishName: 'AbdulBaset AbdulSamad',
        ),
      ),
      expect: () => [
        const QuranListState(
          selectedReciter: ReciterEntity(
            identifier: 'ar.abdulbasitmurattal',
            englishName: 'AbdulBaset AbdulSamad',
          ),
        ),
      ],
    );
  });
}
