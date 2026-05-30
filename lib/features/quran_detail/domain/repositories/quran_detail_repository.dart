import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

/// Repository interface for QuranDetail feature
abstract class QuranDetailRepository {
  /// Get complete surah with all ayahs and audio
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  });
}

/// Entity for Surah detail with ayahs
class SurahDetailEntity {
  const SurahDetailEntity({
    this.surah,
    this.ayahs,
    this.edition,
  });

  final SurahEntity? surah;
  final List<AyahEntity>? ayahs;
  final String? edition;
}
