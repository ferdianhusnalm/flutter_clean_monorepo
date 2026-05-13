//@GeneratedMicroModule;CoreStoragePackageModule;package:core_storage/src/core/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core_storage/src/core/di/injection.dart' as _i267;
import 'package:core_storage/src/database/app_database.dart' as _i533;
import 'package:core_storage/src/hive_storage_service.dart' as _i429;
import 'package:core_storage/src/secure_storage_service.dart' as _i68;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;

class CoreStoragePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final thirdPartyModule = _$ThirdPartyModule();
    gh.singleton<_i533.AppDatabase>(() => _i533.AppDatabase());
    gh.singleton<_i429.HiveStorageService>(() => _i429.HiveStorageService());
    gh.singleton<_i68.SecureStorageService>(() => _i68.SecureStorageService());
    gh.singleton<_i558.FlutterSecureStorage>(
        () => thirdPartyModule.flutterSecureStorage);
  }
}

class _$ThirdPartyModule extends _i267.ThirdPartyModule {}
