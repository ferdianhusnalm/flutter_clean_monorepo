// lib/core/router/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@singleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.material();
}
 
// lib/core/router/app_router.gr.dart is generated — placeholder below:
// Run: dart run build_runner build