sealed class LoginEvent {
  const LoginEvent();
}

final class LoginSignInRequested extends LoginEvent {
  const LoginSignInRequested();
}
