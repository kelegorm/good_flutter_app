import 'dart:async';

import 'package:good_example/domain/auth/auth_repository.dart';
import 'package:good_example/domain/auth/auth_state.dart';
import 'package:good_example/domain/auth/auth_token.dart';
import 'package:good_example/domain/storage/token_storage.dart';

/// Orchestrates authentication flow: sign-in, sign-out, session restore.
class AuthController {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;
  final _changesController = StreamController<AuthState>.broadcast();

  bool _isAuthenticated = false;

  AuthController({
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorage;

  bool get isAuthenticated => _isAuthenticated;
  Stream<AuthState> get changes => _changesController.stream;

  /// Validates a saved token with the server and restores the session.
  Future<void> restoreSession(AuthToken token) async {
    try {
      final freshToken = await _authRepository.refresh(token.refreshToken);
      await _tokenStorage.write(freshToken);
      _isAuthenticated = true;
    } on Exception {
      await _tokenStorage.clear();
      _isAuthenticated = false;
    }
    _changesController.add(_currentState());
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
    _changesController.add(_currentState());
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    await _tokenStorage.clear();
    _isAuthenticated = false;
    _changesController.add(_currentState());
  }

  void dispose() {
    _changesController.close();
  }

  AuthState _currentState() =>
      _isAuthenticated ? AuthAuthenticated() : AuthUnauthenticated();
}
