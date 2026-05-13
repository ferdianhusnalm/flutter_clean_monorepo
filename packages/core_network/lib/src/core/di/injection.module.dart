//@GeneratedMicroModule;CoreNetworkPackageModule;package:core_network/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:core_network/src/dio_client.dart' as _i820;
import 'package:core_network/src/interceptors/auth_interceptor.dart' as _i267;
import 'package:core_network/src/interceptors/connectivity_interceptor.dart'
    as _i809;
import 'package:core_network/src/interceptors/error_interceptor.dart' as _i776;
import 'package:core_network/src/network_info.dart' as _i56;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;

class CoreNetworkPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final connectivityModule = _$ConnectivityModule();
    final dioModule = _$DioModule();
    gh.singleton<_i776.ErrorInterceptor>(() => _i776.ErrorInterceptor());
    gh.singleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.singleton<_i56.NetworkInfo>(
        () => _i56.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.singleton<_i267.AuthInterceptor>(
        () => _i267.AuthInterceptor(gh<_i558.FlutterSecureStorage>()));
    gh.singleton<_i809.ConnectivityInterceptor>(
        () => _i809.ConnectivityInterceptor(gh<_i895.Connectivity>()));
    gh.singleton<_i361.Dio>(() => dioModule.dio(
          gh<_i267.AuthInterceptor>(),
          gh<_i809.ConnectivityInterceptor>(),
          gh<_i776.ErrorInterceptor>(),
        ));
  }
}

class _$ConnectivityModule extends _i809.ConnectivityModule {}

class _$DioModule extends _i820.DioModule {}
