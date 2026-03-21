import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:good_example/ui/design_system/app_theme.dart';
import 'package:good_example/app/bootstrap/bootstrap_controller.dart';
import 'package:good_example/app/bootstrap/bootstrap_state.dart';
import 'package:good_example/app/di/app_di.dart';
import 'package:good_example/app/navigation/app_router.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/bootstrap/bootstrap_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final BootstrapController _bootstrapController;
  late final AppRouter _appRouter;
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    configureDependencies();

    _bootstrapController = BootstrapController(); // Don't need to keep it inside DI
    _appRouter = GetIt.instance<AppRouter>();
    _authController = GetIt.instance<AuthController>();

    _bootstrapController.bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Good Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _appRouter.config(
        reevaluateListenable: _authController,
      ),
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
        }
      },
    );
  }
}
