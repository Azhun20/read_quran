import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/surah_entity.dart';

/// Use case to get list of all Surahs
class GetSurahListUseCase {
  final QuranListRepository repository;

  GetSurahListUseCase(this.repository);

  Future<Either<Failure, List<SurahEntity>>> call() async {
    return await repository.getSurahList();
  }
}