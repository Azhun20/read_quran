import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_detail/data/datasources/quran_detail_remote_datasource.dart';
import 'package:read_quran/features/quran_detail/data/models/surah_detail_model.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';

/// Implementation of QuranDetail repository
class QuranDetailRepositoryImpl implements QuranDetailRepository {
  QuranDetailRepositoryImpl(this._remoteDataSource);

  final QuranDetailRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, SurahDetailEntity>> getSurahDetail({
    required int surahNumber,
    required String reciterIdentifier,
  }) async {
    try {
      final result = await _remoteDataSource.getSurahDetail(
        surahNumber: surahNumber,
        reciterIdentifier: reciterIdentifier,
      );

      final model = SurahDetailModel.fromJson(result);
      final entity = model.toEntity();

      AppLogger.info(
        'Successfully fetched surah $surahNumber with ${entity.ayahs?.length ?? 0} ayahs',
      );

      return Right(entity);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get surah detail', e, stackTrace);
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}

