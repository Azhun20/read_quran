import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:read_quran/core/logging/app_logger.dart';
import 'package:read_quran/features/auth/domain/entities/user_entity.dart';
import 'package:read_quran/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:read_quran/features/auth/domain/usecases/login_usecase.dart';
import 'package:read_quran/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    emit(state.copyWith(isLoading: true));

    final result = await checkAuthStatusUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Check auth status failed', failure.message);
        emit(
          state.copyWith(isLoading: false, isAuthenticated: false, user: null),
        );
      },
      (user) {
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: user != null,
            user: user,
          ),
        );
      },
    );
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await loginUseCase(email, password);

    result.fold(
      (failure) {
        AppLogger.error('Login failed', failure.message);
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (user) {
        AppLogger.auth('Login successful: ${user.email}');
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: user,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));

    final result = await logoutUseCase();

    result.fold(
      (failure) {
        AppLogger.error('Logout failed', failure.message);
        emit(state.copyWith(isLoading: false));
      },
      (_) {
        AppLogger.auth('Logout successful');
        emit(const AuthState(isAuthenticated: false));
      },
    );
  }
}
