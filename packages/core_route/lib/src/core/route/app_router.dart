// lib/core/router/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:core_di/core_di.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@singleton
class AppRouter extends RootStackRouter {
  final homeRouter = getIt<HomeRouter>();
  final authRouter = getIt<AuthRouter>();

  @override
  List<AutoRoute> get routes => [...authRouter.routes, ...homeRouter.routes];

  @override
  RouteType get defaultRouteType => const RouteType.material();
}
 
// lib/core/router/app_router.gr.dart is generated — placeholder below:
// Run: dart run build_runner build