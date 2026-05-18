//@GeneratedMicroModule;FeatureAuthPackageModule;package:feature_auth/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core_network/core_network.dart' as _i309;
import 'package:core_storage/core_storage.dart' as _i78;
import 'package:dio/dio.dart' as _i361;
import 'package:feature_auth/src/core/route/auth_router.dart' as _i1020;
import 'package:feature_auth/src/data/datasources/auth_remote_datasource.dart'
    as _i337;
import 'package:feature_auth/src/data/respositories/auth_repository_impl.dart'
    as _i878;
import 'package:feature_auth/src/domain/repositories/auth_repository.dart'
    as _i1063;
import 'package:feature_auth/src/domain/usecases/login_usecase.dart' as _i823;
import 'package:feature_auth/src/domain/usecases/logout_usecase.dart' as _i798;
import 'package:feature_auth/src/domain/usecases/register_usecase.dart'
    as _i909;
import 'package:feature_auth/src/presentation/bloc/auth/auth_bloc.dart'
    as _i558;
import 'package:injectable/injectable.dart' as _i526;

class FeatureAuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i1020.AuthRouter>(() => _i1020.AuthRouter());
    gh.singleton<_i337.AuthRemoteDataSource>(
        () => _i337.AuthRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.singleton<_i1063.AuthRepository>(() => _i878.AuthRepositoryImpl(
          gh<_i337.AuthRemoteDataSource>(),
          gh<_i78.SecureStorageService>(),
          gh<_i309.AuthInterceptor>(),
        ));
    gh.factory<_i909.RegisterUseCase>(
        () => _i909.RegisterUseCase(gh<_i1063.AuthRepository>()));
    gh.factory<_i823.LoginUseCase>(
        () => _i823.LoginUseCase(gh<_i1063.AuthRepository>()));
    gh.factory<_i798.LogoutUseCase>(
        () => _i798.LogoutUseCase(gh<_i1063.AuthRepository>()));
    gh.factory<_i558.AuthBloc>(() => _i558.AuthBloc(
          gh<_i823.LoginUseCase>(),
          gh<_i798.LogoutUseCase>(),
          gh<_i909.RegisterUseCase>(),
        ));
  }
}
