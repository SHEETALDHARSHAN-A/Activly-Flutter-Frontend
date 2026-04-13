import 'package:activly/activly_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Shell shows landing first', (WidgetTester tester) async {
    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
  });
}
