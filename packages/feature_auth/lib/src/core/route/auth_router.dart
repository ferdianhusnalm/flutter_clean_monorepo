import 'package:auto_route/auto_route.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:injectable/injectable.dart';

part 'auth_router.gr.dart';

@AutoRouterConfig()
@singleton
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
  ];
}
