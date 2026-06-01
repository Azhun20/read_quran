import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class SearchQuranUseCase {
  SearchQuranUseCase(this._repository);

  final QuranSearchRepository _repository;

  Future<Either<Failure, List<AyahEntity>>> call({
    required String keyword,
    int? surahNumber,
    String? edition,
  }) async {
    return await _repository.searchQuran(
      keyword: keyword,
      surahNumber: surahNumber,
      edition: edition,
    );
  }
}
