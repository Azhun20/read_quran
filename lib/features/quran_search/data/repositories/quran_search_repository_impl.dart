import '../../domain/repositories/quran_search_repository.dart';
import '../datasources/quran_search_remote_datasource.dart';

/// Implementasi repository untuk QuranSearch.
/// Hubungkan data source dengan layer domain di dalam kelas ini.
class QuranSearchRepositoryImpl implements QuranSearchRepository {
  QuranSearchRepositoryImpl(this._remoteDataSource);

  final QuranSearchRemoteDataSource _remoteDataSource;
}
