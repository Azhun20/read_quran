import '../../../core/di/service_locator.dart';
import '../data/datasources/quran_list_remote_datasource.dart';
import '../data/repositories/quran_list_repository_impl.dart';
import '../domain/repositories/quran_list_repository.dart';
import '../domain/usecases/get_surah_list_usecase.dart';
import '../domain/usecases/get_available_reciters_usecase.dart';
import '../presentation/cubit/quran_list_cubit.dart';

class QuranListDI {
  static void inject() {
    if (sl.isRegistered<QuranListRepository>()) return;

    // Data sources
    sl.registerLazySingleton<QuranListRemoteDataSource>(
      () => QuranListRemoteDataSourceImpl(),
    );

    // Repository
    sl.registerLazySingleton<QuranListRepository>(
      () => QuranListRepositoryImpl(sl<QuranListRemoteDataSource>()),
    );

    // Use cases
    sl.registerLazySingleton<GetSurahListUseCase>(
      () => GetSurahListUseCase(sl<QuranListRepository>()),
    );

    sl.registerLazySingleton<GetAvailableRecitersUseCase>(
      () => GetAvailableRecitersUseCase(sl<QuranListRepository>()),
    );

    // Cubit
    sl.registerFactory<QuranListCubit>(
      () => QuranListCubit(
        getSurahListUseCase: sl<GetSurahListUseCase>(),
        getAvailableRecitersUseCase: sl<GetAvailableRecitersUseCase>(),
      ),
    );
  }
}
