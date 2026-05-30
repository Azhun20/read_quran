import 'package:dartz/dartz.dart';
import 'package:read_quran/core/error/failure.dart';
import 'package:read_quran/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:read_quran/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:read_quran/features/auth/data/models/user_model.dart';
import 'package:read_quran/features/auth/domain/entities/user_entity.dart';
import 'package:read_quran/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await remoteDataSource.login(email, password);
      final user = UserModel.fromJson(response['user']);
      final token = response['token'] as String;
      final refreshToken = response['refresh_token'] as String;

      await localDataSource.saveUser(response['user']);
      await localDataSource.saveTokens(token, refreshToken);

      return Right(user.toEntity());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearAuth();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> checkAuthStatus() async {
    try {
      final token = localDataSource.getToken();
      if (token == null) {
        return const Right(null);
      }

      final userData = localDataSource.getUser();
      if (userData == null) {
        return const Right(null);
      }

      final user = UserModel.fromJson(userData);
      return Right(user.toEntity());
    } catch (e, stackTrace) {
      return Left(mapExceptionToFailure(e, stackTrace));
    }
  }
}
