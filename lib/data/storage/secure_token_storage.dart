import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_example/domain/auth/auth_token.dart';
import 'package:good_example/domain/storage/token_storage.dart';

/// Stores authentication tokens in platform-encrypted secure storage.
class SecureTokenStorage implements TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  SecureTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<AuthToken?> read() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);

    if (accessToken == null || refreshToken == null) return null;

    return AuthToken(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> write(AuthToken token) async {
    await _storage.write(key: _accessTokenKey, value: token.accessToken);
    await _storage.write(key: _refreshTokenKey, value: token.refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
