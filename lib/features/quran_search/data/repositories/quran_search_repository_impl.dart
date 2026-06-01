import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/quran_search/data/datasources/quran_search_remote_datasource.dart';
import 'package:read_quran/features/quran_search/data/models/search_result_model.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class QuranSearchRepositoryImpl implements QuranSearchRepository {
  QuranSearchRepositoryImpl(this._remoteDataSource);

  final QuranSearchRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<AyahEntity>>> searchQuran({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    try {
      final response = await _remoteDataSource.searchQuran(
        keyword: keyword,
        surahNumber: surahNumber,
        edition: edition,
      );

      // Parse the response data
      final data = response['data'] as Map<String, dynamic>;
      final searchResult = SearchResultModel.fromJson(data);

      // Convert to entities
      final ayahs = searchResult.toEntities();

      AppLogger.info(
        'Search completed: ${ayahs.length} results',
        'QuranSearchRepository',
      );

      return Right(ayahs);
    } catch (e) {
      AppLogger.error(
        'Error in repository: $e',
        e,
        null,
        'QuranSearchRepository',
      );
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
