import 'dart:async';

import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/domain/auth/auth_state.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

enum _SessionFlowTarget { login, home }

/// Owns app-level auth flow navigation.
///
/// Contract:
/// - during initialization it syncs navigation with the current auth state
/// - after initialization it reacts only to future auth changes
/// - duplicate transitions to the same flow are ignored
class SessionController {
  final AuthController _authController;
  final AppNavigator _navigator;

  StreamSubscription<AuthState>? _subscription;
  _SessionFlowTarget? _appliedTarget;

  SessionController({
    required AuthController authController,
    required AppNavigator navigator,
  }) : _authController = authController,
       _navigator = navigator;

  /// Initializes session flow after bootstrap:
  /// subscribes to future auth changes and applies the current auth state once.
  void initialize() {
    if (_subscription != null) return;
    _subscription = _authController.changes.listen(_onAuthChanged);
    _applyState(_authController.currentState);
  }

  void _onAuthChanged(AuthState state) {
    _applyState(state);
  }

  void _applyState(AuthState state) {
    final target = switch (state) {
      AuthAuthenticated() => _SessionFlowTarget.home,
      AuthUnauthenticated() => _SessionFlowTarget.login,
    };

    if (_appliedTarget == target) {
      return;
    }

    _appliedTarget = target;

    switch (target) {
      case _SessionFlowTarget.home:
        unawaited(_navigator.openHome());
      case _SessionFlowTarget.login:
        unawaited(_navigator.openLogin());
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
