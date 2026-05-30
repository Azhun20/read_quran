import '../../../core/di/service_locator.dart';
import '../../../utils/services/api_service.dart';
import '../data/datasources/quran_search_remote_datasource.dart';
import '../data/repositories/quran_search_repository_impl.dart';
import '../domain/repositories/quran_search_repository.dart';
import '../domain/usecases/get_quran_search_list_usecase.dart';
import '../presentation/cubit/quran_search_cubit.dart';

class QuranSearchDI {
  static void inject() {
    if (sl.isRegistered<QuranSearchRepository>()) return;

    sl
      ..registerLazySingleton<QuranSearchRemoteDataSource>(
        () => QuranSearchRemoteDataSource(sl<ApiService>()),
      )
      ..registerLazySingleton<QuranSearchRepository>(
        () => QuranSearchRepositoryImpl(sl<QuranSearchRemoteDataSource>()),
      )
      ..registerLazySingleton<GetQuranSearchListUseCase>(
        () => GetQuranSearchListUseCase(sl<QuranSearchRepository>()),
      )
      ..registerFactory<QuranSearchCubit>(
        () => QuranSearchCubit(sl<GetQuranSearchListUseCase>()),
      );
  }
}
