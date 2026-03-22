import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/auth/bloc/login_event.dart';
import 'package:good_example/ui/auth/bloc/login_state.dart';

export 'package:good_example/ui/auth/bloc/login_event.dart';
export 'package:good_example/ui/auth/bloc/login_state.dart';

/// Controls login screen flow: handles sign-in requests.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthController _authController;

  LoginBloc({required AuthController authController})
      : _authController = authController,
        super(const LoginInitial()) {
    on<LoginSignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    LoginSignInRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInProgress());

    try {
      await _authController.signIn(
        username: event.username,
        password: event.password,
      );
      emit(const LoginSuccess());
    } on Exception catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
