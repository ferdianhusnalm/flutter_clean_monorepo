import 'package:auto_route/auto_route.dart';
import 'package:feature_auth/feature_auth.dart';

part 'auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login'),
  ];
}
