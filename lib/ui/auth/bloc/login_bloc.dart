import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/auth/bloc/login_event.dart';
import 'package:good_example/ui/auth/bloc/login_state.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

export 'package:good_example/ui/auth/bloc/login_event.dart';
export 'package:good_example/ui/auth/bloc/login_state.dart';

/// Controls login screen flow: handles sign-in requests and navigates to home on success.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthController _authController;
  final AppNavigator _navigator;

  LoginBloc({
    required AuthController authController,
    required AppNavigator navigator,
  })  : _authController = authController,
        _navigator = navigator,
        super(const LoginInitial()) {
    on<LoginSignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    LoginSignInRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInProgress());
    _authController.signIn();
    await _navigator.openHome();
    emit(const LoginSuccess());
  }
}
