import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/ui/home/bloc/home_event.dart';
import 'package:good_example/ui/home/bloc/home_state.dart';
import 'package:good_example/ui/navigation/app_navigator.dart';

export 'package:good_example/ui/home/bloc/home_event.dart';
export 'package:good_example/ui/home/bloc/home_state.dart';

/// Controls home screen flow: handles sign-out and future in-app navigation.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthController _authController;

  // ignore: unused_field
  final AppNavigator _navigator;

  HomeBloc({
    required AuthController authController,
    required AppNavigator navigator,
  }) : _authController = authController,
       _navigator = navigator,
       super(const HomeInitial()) {
    on<HomeSignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignOutRequested(
    HomeSignOutRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeSignOutInProgress());
    await _authController.signOut();
    emit(const HomeSignedOut());
  }
}
