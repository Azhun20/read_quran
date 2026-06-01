import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_surah_list_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

class MockQuranListRepository implements QuranListRepository {
  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    // Return mock surah list
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
    ]);
  }

  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    return const Right([
      ReciterEntity(identifier: 'ar.alafasy', name: 'Mishari Rashid Alafasy'),
    ]);
  }
}

class MockQuranListRepositoryWithError implements QuranListRepository {
  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    return const Left(ServerFailure(message: 'Failed to load surah list'));
  }

  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    return const Left(ServerFailure(message: 'Failed to load reciters'));
  }
}

void main() {
  late GetSurahListUseCase useCase;
  late MockQuranListRepository mockRepository;
  late MockQuranListRepositoryWithError mockRepositoryWithError;

  setUp(() {
    mockRepository = MockQuranListRepository();
    mockRepositoryWithError = MockQuranListRepositoryWithError();
  });

  group('GetSurahListUseCase', () {
    test('should return list of surahs when call is successful', () async {
      // Arrange
      useCase = GetSurahListUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (surahs) {
          expect(surahs, isA<List<SurahEntity>>());
          expect(surahs.length, 2);
          expect(surahs.first.number, 1);
          expect(surahs.first.englishName, 'Al-Fatihah');
          expect(surahs.first.numberOfAyahs, 7);
          expect(surahs.last.number, 2);
          expect(surahs.last.englishName, 'Al-Baqarah');
        },
      );
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      useCase = GetSurahListUseCase(mockRepositoryWithError);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Failed to load surah list');
        },
        (surahs) => fail('Expected Left but got Right'),
      );
    });

    test('should return surahs with correct revelation types', () async {
      // Arrange
      useCase = GetSurahListUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (surahs) {
          expect(surahs.first.revelationType, 'Meccan');
          expect(surahs.last.revelationType, 'Medinan');
        },
      );
    });
  });
}
