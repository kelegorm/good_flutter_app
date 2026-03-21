sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginInProgress extends LoginState {
  const LoginInProgress();
}

final class LoginSuccess extends LoginState {
  const LoginSuccess();
}
