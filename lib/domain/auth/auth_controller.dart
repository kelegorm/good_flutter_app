import 'dart:async';

import 'package:good_example/domain/auth/auth_repository.dart';
import 'package:good_example/domain/auth/auth_token.dart';
import 'package:good_example/domain/storage/token_storage.dart';

/// Orchestrates authentication flow: sign-in, sign-out, session restore.
class AuthController {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;
  final _changesController = StreamController<void>.broadcast();

  bool _isAuthenticated = false;

  AuthController({
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorage;

  bool get isAuthenticated => _isAuthenticated;
  Stream<void> get changes => _changesController.stream;

  /// Restores a previously saved session without notifying listeners.
  /// Used during bootstrap to set initial auth state silently.
  void restoreSession(AuthToken token) {
    _isAuthenticated = true;
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    final token = await _authRepository.login(
      username: username,
      password: password,
    );
    await _tokenStorage.write(token);
    _isAuthenticated = true;
    _changesController.add(null);
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    await _tokenStorage.clear();
    _isAuthenticated = false;
    _changesController.add(null);
  }

  void dispose() {
    _changesController.close();
  }
}
