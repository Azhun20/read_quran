import '../../domain/repositories/quran_detail_repository.dart';
import '../datasources/quran_detail_remote_datasource.dart';

/// Implementasi repository untuk QuranDetail.
/// Hubungkan data source dengan layer domain di dalam kelas ini.
class QuranDetailRepositoryImpl implements QuranDetailRepository {
  QuranDetailRepositoryImpl(this._remoteDataSource);

  final QuranDetailRemoteDataSource _remoteDataSource;
}
