import '../../../core/di/service_locator.dart';
import '../../../utils/services/api_service.dart';
import '../data/datasources/quran_detail_remote_datasource.dart';
import '../data/repositories/quran_detail_repository_impl.dart';
import '../domain/repositories/quran_detail_repository.dart';
import '../domain/usecases/get_quran_detail_list_usecase.dart';
import '../presentation/cubit/quran_detail_cubit.dart';

class QuranDetailDI {
  static void inject() {
    if (sl.isRegistered<QuranDetailRepository>()) return;

    sl
      ..registerLazySingleton<QuranDetailRemoteDataSource>(
        () => QuranDetailRemoteDataSource(sl<ApiService>()),
      )
      ..registerLazySingleton<QuranDetailRepository>(
        () => QuranDetailRepositoryImpl(sl<QuranDetailRemoteDataSource>()),
      )
      ..registerLazySingleton<GetQuranDetailListUseCase>(
        () => GetQuranDetailListUseCase(sl<QuranDetailRepository>()),
      )
      ..registerFactory<QuranDetailCubit>(
        () => QuranDetailCubit(sl<GetQuranDetailListUseCase>()),
      );
  }
}
