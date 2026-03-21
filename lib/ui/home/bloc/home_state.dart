sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeSignOutInProgress extends HomeState {
  const HomeSignOutInProgress();
}

final class HomeSignedOut extends HomeState {
  const HomeSignedOut();
}
