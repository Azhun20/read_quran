import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/features/quran_search/data/datasources/quran_search_remote_datasource.dart';
import 'package:read_quran/features/quran_search/data/repositories/quran_search_repository_impl.dart';
import 'package:read_quran/features/quran_search/domain/repositories/quran_search_repository.dart';
import 'package:read_quran/features/quran_search/domain/usecases/get_quran_search_list_usecase.dart';
import 'package:read_quran/features/quran_search/presentation/cubit/quran_search_cubit.dart';

class QuranSearchDI {
  static void inject() {
    if (sl.isRegistered<QuranSearchRepository>()) return;

    // Data sources
    sl.registerLazySingleton<QuranSearchRemoteDataSource>(
      () => QuranSearchRemoteDataSourceImpl(),
    );

    // Repository
    sl.registerLazySingleton<QuranSearchRepository>(
      () => QuranSearchRepositoryImpl(sl<QuranSearchRemoteDataSource>()),
    );

    // Use cases
    sl.registerLazySingleton<SearchQuranUseCase>(
      () => SearchQuranUseCase(sl<QuranSearchRepository>()),
    );

    // Cubit
    sl.registerFactory<QuranSearchCubit>(
      () => QuranSearchCubit(
        searchQuranUseCase: sl<SearchQuranUseCase>(),
      ),
    );
  }
}
