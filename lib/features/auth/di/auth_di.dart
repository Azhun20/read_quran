import 'package:get_it/get_it.dart';
import 'package:read_quran/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:read_quran/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:read_quran/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:read_quran/features/auth/domain/repositories/auth_repository.dart';
import 'package:read_quran/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:read_quran/features/auth/domain/usecases/login_usecase.dart';
import 'package:read_quran/features/auth/domain/usecases/logout_usecase.dart';
import 'package:read_quran/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:read_quran/utils/services/api_service.dart';
import 'package:read_quran/utils/services/hive_service.dart';

class AuthDI {
  static void inject(GetIt sl) {
    // Data sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<ApiService>()),
    );
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<HiveService>()),
    );

    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        sl<AuthRemoteDataSource>(),
        sl<AuthLocalDataSource>(),
      ),
    );

    // Use cases
    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    );
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl<AuthRepository>()),
    );
    sl.registerLazySingleton<CheckAuthStatusUseCase>(
      () => CheckAuthStatusUseCase(sl<AuthRepository>()),
    );

    // Cubit
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        loginUseCase: sl<LoginUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(),
      ),
      dispose: (cubit) => cubit.close(),
    );
  }
}
