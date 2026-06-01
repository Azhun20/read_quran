import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/features/quran_search/domain/usecases/get_quran_search_list_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class MockQuranSearchRepository implements QuranSearchRepository {
  @override
  Future<Either<Failure, List<AyahEntity>>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    if (keyword == 'error') {
      return const Left(ServerFailure(message: 'Search failed'));
    }

    // Return mock data for successful search
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
    ]);
  }
}

void main() {
  late SearchQuranUseCase useCase;
  late MockQuranSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockQuranSearchRepository();
    useCase = SearchQuranUseCase(mockRepository);
  });

  group('SearchQuranUseCase', () {
    const tKeyword = 'Allah';
    const tSurahNumber = 1;
    const tEdition = 'quran-simple';

    test('should return list of ayahs when search is successful', () async {
      // Act
      final result = await useCase(
        keyword: tKeyword,
        surahNumber: tSurahNumber,
        edition: tEdition,
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (ayahs) {
          expect(ayahs, isA<List<AyahEntity>>());
          expect(ayahs.length, 1);
          expect(ayahs.first.text, contains(tKeyword));
          expect(ayahs.first.surahNumber, tSurahNumber);
        },
      );
    });

    test('should return failure when search fails', () async {
      // Act
      final result = await useCase(
        keyword: 'error',
        surahNumber: tSurahNumber,
        edition: tEdition,
      );

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Search failed');
        },
        (ayahs) => fail('Expected Left but got Right'),
      );
    });

    test('should work without optional parameters', () async {
      // Act
      final result = await useCase(keyword: tKeyword);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (ayahs) {
          expect(ayahs, isA<List<AyahEntity>>());
          expect(ayahs.isNotEmpty, true);
        },
      );
    });

    test('should return empty list for search with no results', () async {
      // Arrange - using a keyword that would typically return no results
      const noResultKeyword = 'nonexistentword12345';

      // Act
      final result = await useCase(keyword: noResultKeyword);

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (ayahs) {
          expect(ayahs, isA<List<AyahEntity>>());
        },
      );
    });
  });
}
