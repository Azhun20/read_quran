import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';

/// Use case to get complete surah detail with ayahs and audio
class GetSurahDetailUseCase {
  final QuranDetailRepository repository;

  GetSurahDetailUseCase(this.repository);

  Future<Either<Failure, SurahDetailEntity>> call({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    return await repository.getSurahDetail(
      surahNumber: surahNumber,
      reciterIdentifier: reciterIdentifier,
    );
  }
}
