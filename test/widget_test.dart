import 'package:activly/activly_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Activly shell loads landing actions', (
    WidgetTester tester,
  ) async {
    tester.binding.platformDispatcher.localeTestValue = const Locale('en');
    addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);

    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Get Started'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Skip for Now'), findsOneWidget);
  });

  testWidgets('No temporary MyApp alias remains', (WidgetTester tester) async {
    tester.binding.platformDispatcher.localeTestValue = const Locale('en');
    addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);

    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(ActivlyApp), findsOneWidget);
  });
}
