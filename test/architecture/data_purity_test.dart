import 'package:flutter_test/flutter_test.dart';

import 'layer_check.dart';

/// Purity rule for `lib/data/`. Adapters bridge `domain/` ports to
/// concrete storage / transport implementations, so they may use Dart,
/// the domain types they implement, sibling data files, and the storage
/// packages listed below — but nothing from `ui/` or `app/`.
///
/// Extend [allowedExternalPackages] when introducing a new storage or
/// transport dependency (e.g. `dio`, `sqflite`).
void main() {
  test('lib/data/ imports only dart:*, domain/, data/, allowed packages', () {
    checkLayer(
      layer: 'data',
      packageName: 'good_example',
      allowedInternalLayers: const <String>{'domain', 'data'},
      allowedExternalPackages: const <String>{
        'flutter', // typically only flutter/foundation
        'flutter_secure_storage',
        'shared_preferences',
      },
    );
  });
}
