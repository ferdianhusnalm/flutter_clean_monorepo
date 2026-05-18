//@GeneratedMicroModule;FeatureHomePackageModule;package:feature_home/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:feature_home/src/core/route/home_router.dart' as _i856;
import 'package:feature_home/src/presentation/bloc/home/home_bloc.dart'
    as _i833;
import 'package:injectable/injectable.dart' as _i526;

class FeatureHomePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i833.HomeBloc>(() => _i833.HomeBloc());
    gh.singleton<_i856.HomeRouter>(() => _i856.HomeRouter());
  }
}
