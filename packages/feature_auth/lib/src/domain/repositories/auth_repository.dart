// packages/feature_auth/lib/src/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:core_network/core_network.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, String>> refreshToken();

  Future<bool> isLoggedIn();
}
