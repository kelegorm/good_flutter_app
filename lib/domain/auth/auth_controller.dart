import 'dart:async';

/// Holds the current authentication state and provides sign-in / sign-out operations.
class AuthController {
  bool _isAuthenticated = false;
  final _changesController = StreamController<void>.broadcast();

  bool get isAuthenticated => _isAuthenticated;
  Stream<void> get changes => _changesController.stream;

  void signIn() {
    if (_isAuthenticated) return;
    _isAuthenticated = true;
    _changesController.add(null);
  }

  void signOut() {
    if (!_isAuthenticated) return;
    _isAuthenticated = false;
    _changesController.add(null);
  }

  void dispose() {
    _changesController.close();
  }
}
