import 'dart:async';

import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/domain/auth/auth_state.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

/// Reacts to authentication state changes and navigates between auth / main flows.
class SessionController {
  final AuthController _authController;
  final AppNavigator _navigator;

  StreamSubscription<AuthState>? _subscription;

  SessionController({
    required AuthController authController,
    required AppNavigator navigator,
  })  : _authController = authController,
        _navigator = navigator;

  /// Starts listening to auth changes. Call once after bootstrap is complete.
  void start() {
    if (_subscription != null) return;
    _subscription = _authController.changes.listen(_onAuthChanged);
  }

  void _onAuthChanged(AuthState state) {
    switch (state) {
      case AuthAuthenticated():
        // Future: check onboarding, agreements, first launch, etc.
        _navigator.openHome();
      case AuthUnauthenticated():
        _navigator.openLogin();
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
