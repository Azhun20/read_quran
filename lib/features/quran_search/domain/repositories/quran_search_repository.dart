import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

abstract class QuranSearchRepository {
  Future<Either<Failure, List<AyahEntity>>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  });
}
