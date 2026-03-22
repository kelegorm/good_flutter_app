/// A pair of tokens representing an authenticated session.
class AuthToken {
  final String accessToken;
  final String refreshToken;

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });
}
