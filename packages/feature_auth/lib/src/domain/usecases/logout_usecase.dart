// packages/feature_auth/lib/src/domain/usecases/logout_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:core_network/core_network.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

@injectable
class LogoutUseCase implements NoParamsUseCase<void> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call() => _repository.logout();
}
