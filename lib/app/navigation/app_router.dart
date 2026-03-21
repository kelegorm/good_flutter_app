import 'package:auto_route/auto_route.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/auth/login_screen.dart';
import 'package:good_example/ui/home/home_screen.dart';

part 'app_router.gr.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const login = '/login';
  static const home = '/home';
}

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._authController);

  final AuthController _authController;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: AppRoutePaths.login,
          initial: true,
          guards: [GuestOnlyGuard(_authController)],
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: AppRoutePaths.home,
          guards: [AuthenticatedGuard(_authController)],
        ),
        RedirectRoute(path: '*', redirectTo: AppRoutePaths.login),
      ];
}

class GuestOnlyGuard extends AutoRouteGuard {
  GuestOnlyGuard(this._authController);

  final AuthController _authController;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authController.isAuthenticated) {
      resolver.redirectUntil(NamedRoute(HomeRoute.name));
      return;
    }
    resolver.next();
  }
}

class AuthenticatedGuard extends AutoRouteGuard {
  AuthenticatedGuard(this._authController);

  final AuthController _authController;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!_authController.isAuthenticated) {
      resolver.redirectUntil(NamedRoute(LoginRoute.name));
      return;
    }
    resolver.next();
  }
}
