import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:good_example/app/app.dart';
import 'package:good_example/app/di/app_di.dart';
import 'package:good_example/domain/auth/auth_repository.dart';
import 'package:good_example/domain/auth/auth_token.dart';
import 'package:good_example/domain/storage/app_preferences.dart';
import 'package:good_example/domain/storage/token_storage.dart';

class InMemoryTokenStorage implements TokenStorage {
  AuthToken? _token;

  @override
  Future<AuthToken?> read() async => _token;

  @override
  Future<void> write(AuthToken token) async {
    _token = token;
  }

  @override
  Future<void> clear() async {
    _token = null;
  }
}

class InMemoryAppPreferences implements AppPreferences {
  String? _locale;

  @override
  Future<String?> readLocale() async => _locale;

  @override
  Future<void> writeLocale(String locale) async {
    _locale = locale;
  }
}

class InstantMockAuthRepository implements AuthRepository {
  @override
  Future<AuthToken> login({
    required String username,
    required String password,
  }) async {
    return const AuthToken(
      accessToken: 'test_access',
      refreshToken: 'test_refresh',
    );
  }

  @override
  Future<void> logout() async {}
}

void main() {
  setUp(() {
    configureDependencies(
      tokenStorage: InMemoryTokenStorage(),
      appPreferences: InMemoryAppPreferences(),
      authRepository: InstantMockAuthRepository(),
    );
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  testWidgets('bootstrap opens login and auth switches to main screen', (
    tester,
  ) async {
    await tester.pumpWidget(const App());
    expect(find.text('Preparing application...'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Sign in to continue'), findsOneWidget);

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Main app screen'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(find.text('Sign in to continue'), findsOneWidget);
  });
}
