import '../../../core/di/service_locator.dart';
import '../../../shared/services/audio_player_service.dart';
import '../data/datasources/quran_detail_remote_datasource.dart';
import '../data/repositories/quran_detail_repository_impl.dart';
import '../domain/repositories/quran_detail_repository.dart';
import '../domain/usecases/get_surah_detail_usecase.dart';
import '../presentation/cubit/quran_detail_cubit.dart';

class QuranDetailDI {
  static void inject() {
    if (sl.isRegistered<QuranDetailRepository>()) return;

    // Data sources
    sl.registerLazySingleton<QuranDetailRemoteDataSource>(
      () => QuranDetailRemoteDataSourceImpl(),
    );

    // Repository
    sl.registerLazySingleton<QuranDetailRepository>(
      () => QuranDetailRepositoryImpl(sl<QuranDetailRemoteDataSource>()),
    );

    // Use cases
    sl.registerLazySingleton<GetSurahDetailUseCase>(
      () => GetSurahDetailUseCase(sl<QuranDetailRepository>()),
    );

    // Audio service (singleton to persist across pages)
    if (!sl.isRegistered<AudioPlayerService>()) {
      sl.registerLazySingleton<AudioPlayerService>(
        () => AudioPlayerService(),
      );
    }

    // Cubit
    sl.registerFactory<QuranDetailCubit>(
      () => QuranDetailCubit(
        getSurahDetailUseCase: sl<GetSurahDetailUseCase>(),
        audioPlayerService: sl<AudioPlayerService>(),
      ),
    );
  }
}
