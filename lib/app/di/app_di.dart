import 'package:get_it/get_it.dart';
import 'package:good_example/app/navigation/app_router.dart';
import 'package:good_example/app/navigation/auto_route_app_navigator.dart';
import 'package:good_example/app/session/session_controller.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/auth/bloc/login_bloc.dart';
import 'package:good_example/ui/home/bloc/home_bloc.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

void configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<AuthController>(() => AuthController());

  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<AuthController>()),
  );

  getIt.registerLazySingleton<AppNavigator>(
    () => AutoRouteAppNavigator(getIt<AppRouter>()),
  );

  getIt.registerLazySingleton<SessionController>(
    () => SessionController(
      authController: getIt<AuthController>(),
      navigator: getIt<AppNavigator>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(authController: getIt<AuthController>()),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      authController: getIt<AuthController>(),
      navigator: getIt<AppNavigator>(),
    ),
  );
}
