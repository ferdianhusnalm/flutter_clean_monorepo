// packages/feature_auth/lib/src/data/repositories/auth_repository_impl.dart
import 'package:core_network/core_network.dart';
import 'package:core_storage/core_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;
  final AuthInterceptor _authInterceptor;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._secureStorage,
    this._authInterceptor,
  );

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      await _authInterceptor.saveToken(result.token);
      await _authInterceptor.saveRefreshToken(result.refreshToken);
      return Right(result.user.toEntity());
    } on DioException catch (e) {
      return Left(e.error is Failure ? e.error as Failure : UnknownFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      await _authInterceptor.saveToken(result.token);
      await _authInterceptor.saveRefreshToken(result.refreshToken);
      return Right(result.user.toEntity());
    } on DioException catch (e) {
      return Left(e.error is Failure ? e.error as Failure : UnknownFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _secureStorage.deleteAll();
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.error is Failure ? e.error as Failure : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final model = await _remoteDataSource.getMe();
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(e.error is Failure ? e.error as Failure : UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    // Delegated to AuthInterceptor
    return const Left(UnknownFailure());
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }
}
