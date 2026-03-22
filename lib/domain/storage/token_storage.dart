import 'package:good_example/domain/auth/auth_token.dart';

/// Persistent secure storage for authentication tokens.
abstract interface class TokenStorage {
  Future<AuthToken?> read();
  Future<void> write(AuthToken token);
  Future<void> clear();
}
