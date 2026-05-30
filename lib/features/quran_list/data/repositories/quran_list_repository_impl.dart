import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_list/data/models/reciter_model.dart';
import 'package:read_quran/features/quran_list/data/models/surah_model.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';
import '../../domain/repositories/quran_list_repository.dart';
import '../datasources/quran_list_remote_datasource.dart';

/// Implementation of QuranList repository
class QuranListRepositoryImpl implements QuranListRepository {
  QuranListRepositoryImpl(this._remoteDataSource);

  final QuranListRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahList() async {
    try {
      final result = await _remoteDataSource.getSurahList();

      final surahs = result.map((json) {
        final model = SurahModel.fromJson(json);
        return model.toEntity();
      }).toList();

      AppLogger.info('Successfully fetched ${surahs.length} surahs');
      return Right(surahs);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get surah list', e, stackTrace);
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<ReciterEntity>>> getAvailableReciters() async {
    try {
      final result = await _remoteDataSource.getAvailableReciters();

      final reciters = result.map((json) {
        final model = ReciterModel.fromJson(json);
        return model.toEntity();
      }).toList();

      AppLogger.info('Successfully fetched ${reciters.length} reciters');
      return Right(reciters);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get available reciters', e, stackTrace);
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
