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
    final savedLocale = await _appPreferences.readLocale();
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }

    final savedToken = await _tokenStorage.read();
    if (savedToken != null) {
      _authController.restoreSession(savedToken);
    }

    _state = const BootstrapComplete();
    notifyListeners();
  }
}
