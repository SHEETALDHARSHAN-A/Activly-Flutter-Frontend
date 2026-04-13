import 'package:activly/activly_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Activly shell loads landing actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Skip for Now'), findsOneWidget);
  });

  testWidgets('No temporary MyApp alias remains', (WidgetTester tester) async {
    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(ActivlyApp), findsOneWidget);
  });
}
