import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';

/// Repository interface for QuranList feature
abstract class QuranListRepository {
  /// Get list of all Surahs
  Future<Either<Failure, List<SurahEntity>>> getSurahList();

  /// Get list of available reciters
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters();
}
