sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginInProgress extends LoginState {
  const LoginInProgress();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}
