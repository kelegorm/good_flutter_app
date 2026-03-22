import 'package:flutter/material.dart';
import 'package:good_example/app/bootstrap/bootstrap_state.dart';
import 'package:good_example/domain/auth/auth_controller.dart';
import 'package:good_example/domain/storage/app_preferences.dart';
import 'package:good_example/domain/storage/token_storage.dart';

/// Manages the app's bootstrap phase: reads persisted data and restores session if possible.
class BootstrapController extends ChangeNotifier {
  final TokenStorage _tokenStorage;
  final AppPreferences _appPreferences;
  final AuthController _authController;

  BootstrapState _state = const BootstrapLoading();
  Future<void>? _bootstrapFuture;
  Locale? _locale;

  BootstrapController({
    required TokenStorage tokenStorage,
    required AppPreferences appPreferences,
    required AuthController authController,
  })  : _tokenStorage = tokenStorage,
        _appPreferences = appPreferences,
        _authController = authController;

  BootstrapState get state => _state;
  Locale? get locale => _locale;

  Future<void> bootstrap() => _bootstrapFuture ??= _runBootstrap();

  Future<void> _runBootstrap() async {
    try {
      await _restoreLocale();
      await _restoreSession();

      _state = const BootstrapComplete();
    } on Exception catch (e) {
      _state = BootstrapError(e.toString());
    }
    notifyListeners();
  }

  /// Soft failure: if locale can't be read, use system default.
  Future<void> _restoreLocale() async {
    try {
      final savedLocale = await _appPreferences.readLocale();
      if (savedLocale != null) {
        _locale = Locale(savedLocale);
      }
    } on Exception {
      // Non-critical — system locale will be used.
    }
  }

  /// Soft failure: if token can't be read or refresh fails, user stays logged out.
  Future<void> _restoreSession() async {
    try {
      final savedToken = await _tokenStorage.read();
      if (savedToken != null) {
        await _authController.restoreSession(savedToken);
      }
    } on Exception {
      // Non-critical — user will see login screen.
    }
  }
}
