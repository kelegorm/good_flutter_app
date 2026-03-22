sealed class LoginEvent {
  const LoginEvent();
}

class LoginSignInRequested extends LoginEvent {
  final String username;
  final String password;

  const LoginSignInRequested({
    required this.username,
    required this.password,
  });
}
