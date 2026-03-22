import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:good_example/app/bootstrap/bootstrap_controller.dart';
import 'package:good_example/app/bootstrap/bootstrap_state.dart';
import 'package:good_example/app/di/app_di.dart';
import 'package:good_example/app/navigation/app_router.dart';
import 'package:good_example/app/session/session_controller.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/domain/storage/app_preferences.dart';
import 'package:good_example/domain/storage/token_storage.dart';
import 'package:good_example/ui/bootstrap/bootstrap_screen.dart';
import 'package:good_example/ui/design_system/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final BootstrapController _bootstrapController;
  late final AppRouter _appRouter;
  late final SessionController _sessionController;

  @override
  void initState() {
    super.initState();
    configureDependencies();

    _bootstrapController = BootstrapController(
      tokenStorage: GetIt.instance<TokenStorage>(),
      appPreferences: GetIt.instance<AppPreferences>(),
      authController: GetIt.instance<AuthController>(),
    );
    _appRouter = GetIt.instance<AppRouter>();
    _sessionController = GetIt.instance<SessionController>();

    _runBootstrap();
  }

  Future<void> _runBootstrap() async {
    await _bootstrapController.bootstrap();

    if (_bootstrapController.state case BootstrapComplete()) {
      _sessionController.start();
    }
  }

  @override
  void dispose() {
    _sessionController.dispose();
    _bootstrapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Good Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _appRouter.config(),
      builder: _buildBootstrapSwitcher,
    );
  }

  /// Switches between [BootstrapScreen] and the router's [child]
  /// depending on the current [BootstrapState].
  Widget _buildBootstrapSwitcher(BuildContext context, Widget? child) {
    return ListenableBuilder(
      listenable: _bootstrapController,
      builder: (context, _) {
        switch (_bootstrapController.state) {
          case BootstrapLoading():
            return const BootstrapScreen();
          case BootstrapComplete():
            return child!;
          case BootstrapError(:final message):
            return BootstrapScreen(errorMessage: message);
        }
      },
    );
  }
}
