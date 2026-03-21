abstract interface class AppNavigator {
  Future<void> openLogin();
  Future<void> openHome();
  void back();
}
