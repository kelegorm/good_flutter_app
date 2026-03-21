import 'package:flutter_test/flutter_test.dart';
import 'package:good_example/app/app.dart';

void main() {
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
