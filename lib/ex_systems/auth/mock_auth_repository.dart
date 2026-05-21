import 'package:good_example/domain/auth/auth_repository.dart';
import 'package:good_example/domain/auth/auth_token.dart';

/// Simulates a remote authentication provider with an artificial delay.
class MockAuthRepository implements AuthRepository {
  @override
  Future<AuthToken> login({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return AuthToken(
      accessToken: 'mock_access_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<AuthToken> refresh(String refreshToken) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return AuthToken(
      accessToken: 'mock_access_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
