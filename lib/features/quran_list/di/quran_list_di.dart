import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/features/quran_list/data/datasources/quran_list_remote_datasource.dart';
import 'package:read_quran/features/quran_list/data/repositories/quran_list_repository_impl.dart';
import 'package:read_quran/features/quran_list/domain/repositories/quran_list_repository.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_available_reciters_usecase.dart';
import 'package:read_quran/features/quran_list/domain/usecases/get_surah_list_usecase.dart';
import 'package:read_quran/features/quran_list/presentation/cubit/quran_list_cubit.dart';

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
