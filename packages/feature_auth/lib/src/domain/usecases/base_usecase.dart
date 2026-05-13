// packages/feature_auth/lib/src/domain/usecases/base_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:core_network/core_network.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

class NoParams {}
