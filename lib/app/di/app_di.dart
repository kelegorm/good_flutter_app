import 'package:get_it/get_it.dart';
import 'package:good_example/app/navigation/app_router.dart';
import 'package:good_example/app/navigation/auto_route_app_navigator.dart';
import 'package:good_example/app/session/session_controller.dart';
import 'package:good_example/ex_systems/auth/mock_auth_repository.dart';
import 'package:good_example/ex_systems/storage/secure_token_storage.dart';
import 'package:good_example/ex_systems/storage/shared_app_preferences.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/domain/auth/auth_repository.dart';
import 'package:good_example/domain/storage/app_preferences.dart';
import 'package:good_example/domain/storage/token_storage.dart';
import 'package:good_example/ui/auth/bloc/login_bloc.dart';
import 'package:good_example/ui/home/bloc/home_bloc.dart';
import 'package:good_example/app_ports/navigation/app_navigator.dart';

/// Registers all application dependencies. Accepts optional overrides for testing.
/// Calling this multiple times is safe — subsequent calls are ignored.
void configureDependencies({
  TokenStorage? tokenStorage,
  AppPreferences? appPreferences,
  AuthRepository? authRepository,
}) {
  final getIt = GetIt.instance;
  if (getIt.isRegistered<AuthController>()) return;

  getIt
    // Storage
    ..registerLazySingleton<TokenStorage>(
      () => tokenStorage ?? SecureTokenStorage(),
    )
    ..registerLazySingleton<AppPreferences>(
      () => appPreferences ?? SharedAppPreferences(),
    )
    // Domain
    ..registerLazySingleton<AuthRepository>(
      () => authRepository ?? MockAuthRepository(),
    )
    ..registerLazySingleton<AuthController>(
      () => AuthController(
        authRepository: getIt<AuthRepository>(),
        tokenStorage: getIt<TokenStorage>(),
      ),
    )
    // Navigation
    ..registerLazySingleton<AppRouter>(
      () => AppRouter(getIt<AuthController>()),
    )
    ..registerLazySingleton<AppNavigator>(
      () => AutoRouteAppNavigator(getIt<AppRouter>()),
    )
    ..registerLazySingleton<SessionController>(
      () => SessionController(
        authController: getIt<AuthController>(),
        navigator: getIt<AppNavigator>(),
      ),
    )
    // Screen blocs
    ..registerFactory<LoginBloc>(
      () => LoginBloc(authController: getIt<AuthController>()),
    )
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        authController: getIt<AuthController>(),
        navigator: getIt<AppNavigator>(),
      ),
    );
}
