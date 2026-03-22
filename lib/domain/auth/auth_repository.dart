import 'package:good_example/domain/auth/auth_token.dart';

/// Remote authentication provider: exchanges credentials for tokens and manages server sessions.
abstract interface class AuthRepository {
  Future<AuthToken> login({
    required String username,
    required String password,
  });

  /// Refreshes the session using a stored refresh token. Throws on failure.
  Future<AuthToken> refresh(String refreshToken);

  Future<void> logout();
}
