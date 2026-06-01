import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_available_reciters_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

class MockQuranListRepository implements QuranListRepository {
  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    // Return mock reciters list
    return Right([
      const ReciterEntity(
        identifier: 'ar.alafasy',
        name: 'مشاري العفاسي',
        englishName: 'Mishari Rashid Alafasy',
        format: 'audio',
        type: 'versebyverse',
        bitrate: '128',
      ),
      const ReciterEntity(
        identifier: 'ar.abdulbasitmurattal',
        name: 'عبد الباسط عبد الصمد',
        englishName: 'AbdulBaset AbdulSamad (Murattal)',
        format: 'audio',
        type: 'versebyverse',
        bitrate: '64',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    return Right([]);
  }
}

class MockQuranListRepositoryWithError implements QuranListRepository {
  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    return const Left(ServerFailure(message: 'Failed to load reciters'));
  }

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    return const Left(ServerFailure(message: 'Failed to load surah list'));
  }
}

void main() {
  late GetAvailableRecitersUseCase useCase;
  late MockQuranListRepository mockRepository;
  late MockQuranListRepositoryWithError mockRepositoryWithError;

  setUp(() {
    mockRepository = MockQuranListRepository();
    mockRepositoryWithError = MockQuranListRepositoryWithError();
  });

  group('GetAvailableRecitersUseCase', () {
    test('should return list of reciters when call is successful', () async {
      // Arrange
      useCase = GetAvailableRecitersUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (reciters) {
          expect(reciters, isA<List<ReciterEntity>>());
          expect(reciters.length, 2);
          expect(reciters.first.identifier, 'ar.alafasy');
          expect(reciters.first.englishName, 'Mishari Rashid Alafasy');
          expect(reciters.first.bitrate, '128');
        },
      );
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      useCase = GetAvailableRecitersUseCase(mockRepositoryWithError);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Failed to load reciters');
        },
        (reciters) => fail('Expected Left but got Right'),
      );
    });

    test('should return reciters with correct format and type', () async {
      // Arrange
      useCase = GetAvailableRecitersUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (reciters) {
          expect(reciters.every((r) => r.format == 'audio'), true);
          expect(reciters.every((r) => r.type == 'versebyverse'), true);
        },
      );
    });

    test('should return reciters with different bitrates', () async {
      // Arrange
      useCase = GetAvailableRecitersUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (reciters) {
          final bitrates = reciters.map((r) => r.bitrate).toSet();
          expect(bitrates.contains('128'), true);
          expect(bitrates.contains('64'), true);
        },
      );
    });
  });
}
