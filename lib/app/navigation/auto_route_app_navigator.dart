import 'package:auto_route/auto_route.dart';
import 'package:good_example/app/navigation/app_router.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

class AutoRouteAppNavigator implements AppNavigator {
  AutoRouteAppNavigator(this._router);

  final RootStackRouter _router;

  @override
  Future<void> openHome() => _router.replace(const HomeRoute());

  @override
  Future<void> openLogin() => _router.replace(const LoginRoute());

  @override
  void back() {
    if (_router.canPop()) {
      _router.pop();
    }
  }
}
