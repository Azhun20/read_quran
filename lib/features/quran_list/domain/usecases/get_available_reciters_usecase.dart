import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/shared/domain/entities/quran/reciter_entity.dart';

/// Use case to get list of available Quran reciters
class GetAvailableRecitersUseCase {
  final QuranListRepository repository;

  GetAvailableRecitersUseCase(this.repository);

  Future<Either<Failure, List<ReciterEntity>>> call() async {
    return await repository.getAvailableReciters();
  }
}
