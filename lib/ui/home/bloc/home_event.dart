part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeSignOutRequested extends HomeEvent {
  const HomeSignOutRequested();
}
