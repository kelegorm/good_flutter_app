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

  AuthState _state = const AuthUnauthenticated();

  AuthController({
    required AuthRepository authRepository,
    required TokenStorage tokenStorage,
  })  : _authRepository = authRepository,
        _tokenStorage = tokenStorage;

  AuthState get currentState => _state;
  Stream<AuthState> get changes => _changesController.stream;

  /// Validates a saved token with the server and restores the session.
  Future<void> restoreSession(AuthToken token) async {
    try {
      final freshToken = await _authRepository.refresh(token.refreshToken);
      await _tokenStorage.write(freshToken);
      _state = const AuthAuthenticated();
    } on Exception {
      await _tokenStorage.clear();
      _state = const AuthUnauthenticated();
    }
    _changesController.add(_state);
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
    _state = const AuthAuthenticated();
    _changesController.add(_state);
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    await _tokenStorage.clear();
    _state = const AuthUnauthenticated();
    _changesController.add(_state);
  }

  void dispose() {
    _changesController.close();
  }
}
