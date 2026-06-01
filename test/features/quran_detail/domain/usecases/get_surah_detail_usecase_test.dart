import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';
import 'package:read_quran/features/quran_detail/domain/usecases/get_surah_detail_usecase.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

class MockQuranDetailRepository implements QuranDetailRepository {
  @override
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    if (surahNumber <= 0 || surahNumber > 114) {
      return const Left(ServerFailure(message: 'Invalid surah number'));
    }

    // Return mock surah detail
    return Right(
      SurahDetailEntity(
        surah: SurahEntity(
          number: surahNumber,
          name: 'الفاتحة',
          englishName: 'Al-Fatihah',
          englishNameTranslation: 'The Opener',
          numberOfAyahs: 7,
          revelationType: 'Meccan',
        ),
        ayahs: [
          AyahEntity(
            number: 1,
            text: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            audioUrl: 'https://example.com/audio/1.mp3',
            numberInSurah: 1,
            juz: 1,
            page: 1,
            surahNumber: surahNumber,
          ),
          AyahEntity(
            number: 2,
            text: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
            audioUrl: 'https://example.com/audio/2.mp3',
            numberInSurah: 2,
            juz: 1,
            page: 1,
            surahNumber: surahNumber,
          ),
        ],
        edition: reciterIdentifier,
      ),
    );
  }
}

void main() {
  late GetSurahDetailUseCase useCase;
  late MockQuranDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockQuranDetailRepository();
    useCase = GetSurahDetailUseCase(mockRepository);
  });

  group('GetSurahDetailUseCase', () {
    const tSurahNumber = 1;
    const tReciterIdentifier = 'ar.alafasy';

    test('should return surah detail with ayahs when call is successful', () async {
      // Act
      final result = await useCase(
        surahNumber: tSurahNumber,
        reciterIdentifier: tReciterIdentifier,
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (detail) {
          expect(detail, isA<SurahDetailEntity>());
          expect(detail.surah, isNotNull);
          expect(detail.ayahs, isNotNull);
          expect(detail.ayahs?.length, 2);
          expect(detail.surah?.number, tSurahNumber);
          expect(detail.edition, tReciterIdentifier);
        },
      );
    });

    test('should return failure for invalid surah number', () async {
      // Act
      final result = await useCase(
        surahNumber: 0,
        reciterIdentifier: tReciterIdentifier,
      );

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Invalid surah number');
        },
        (detail) => fail('Expected Left but got Right'),
      );
    });

    test('should return ayahs with audio URLs', () async {
      // Act
      final result = await useCase(
        surahNumber: tSurahNumber,
        reciterIdentifier: tReciterIdentifier,
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (detail) {
          expect(detail.ayahs, isNotNull);
          expect(
            detail.ayahs?.every((ayah) => ayah.audioUrl != null),
            true,
          );
        },
      );
    });

    test('should return correct reciter edition', () async {
      // Act
      final result = await useCase(
        surahNumber: tSurahNumber,
        reciterIdentifier: 'ar.abdulbasitmurattal',
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (detail) {
          expect(detail.edition, 'ar.abdulbasitmurattal');
        },
      );
    });

    test('should work with different surah numbers', () async {
      // Act
      final result1 = await useCase(
        surahNumber: 1,
        reciterIdentifier: tReciterIdentifier,
      );
      final result2 = await useCase(
        surahNumber: 114,
        reciterIdentifier: tReciterIdentifier,
      );

      // Assert
      expect(result1.isRight(), true);
      expect(result2.isRight(), true);
    });
  });
}
