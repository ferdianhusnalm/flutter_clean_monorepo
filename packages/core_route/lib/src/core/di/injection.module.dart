//@GeneratedMicroModule;CoreRoutePackageModule;package:core_route/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core_route/src/core/route/app_router.dart' as _i504;
import 'package:injectable/injectable.dart' as _i526;

class CoreRoutePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.singleton<_i504.AppRouter>(() => _i504.AppRouter());
  }
}
