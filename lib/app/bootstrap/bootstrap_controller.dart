import 'package:flutter/material.dart';
import 'package:good_example/app/bootstrap/bootstrap_state.dart';

/// Manages the app's bootstrap phase: runs startup tasks and exposes the resulting [BootstrapState].
class BootstrapController extends ChangeNotifier {
  BootstrapState get state => _state;
  Locale? get locale => _locale;

  BootstrapState _state = const BootstrapLoading();
  Future<void>? _bootstrapFuture;
  Locale? _locale;

  Future<void> bootstrap() {
    return _bootstrapFuture ??= _runBootstrap();
  }

  Future<void> _runBootstrap() async {
    _locale = await _resolveInitialLocale();
    _state = const BootstrapComplete();
    notifyListeners();
  }

  Future<Locale?> _resolveInitialLocale() async {
    // Reserved for future locale restoration or locale selection during bootstrap.
    return null;
  }
}
