import 'package:read_quran/core/di/service_locator.dart';
import 'package:read_quran/features/quran_detail/data/datasources/quran_detail_remote_datasource.dart';
import 'package:read_quran/features/quran_detail/data/repositories/quran_detail_repository_impl.dart';
import 'package:read_quran/features/quran_detail/domain/repositories/quran_detail_repository.dart';
import 'package:read_quran/features/quran_detail/domain/usecases/get_surah_detail_usecase.dart';
import 'package:read_quran/features/quran_detail/presentation/cubit/quran_detail_cubit.dart';
import 'package:read_quran/shared/services/audio_player_service.dart';

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
