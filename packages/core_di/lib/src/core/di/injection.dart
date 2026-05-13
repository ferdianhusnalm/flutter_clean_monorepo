// lib/core/di/injection.dart
import 'package:core_network/core_network.dart';
import 'package:core_storage/core_storage.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:core_route/core_route.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  externalPackageModulesBefore: [
    ExternalModule(CoreStoragePackageModule),
    ExternalModule(CoreNetworkPackageModule),
    ExternalModule(FeatureAuthPackageModule),
    ExternalModule(FeatureHomePackageModule),
    ExternalModule(CoreRoutePackageModule),
  ],
)
Future<void> configureDependencies() async {
  final gh = GetItHelper(getIt);
  await CoreStoragePackageModule().init(gh);
  await CoreNetworkPackageModule().init(gh);
  await FeatureAuthPackageModule().init(gh);
  await FeatureHomePackageModule().init(gh);
  await CoreRoutePackageModule().init(gh);
  getIt.init();
}
