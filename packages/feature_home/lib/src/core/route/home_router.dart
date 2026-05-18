import 'package:auto_route/auto_route.dart';

import 'package:feature_home/feature_home.dart';
import 'package:injectable/injectable.dart';

part 'home_router.gr.dart';

@AutoRouterConfig()
@singleton
class HomeRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home'),
  ];
}
