import 'package:activly/activly_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Landing renders action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const ActivlyApp(enableVideos: false));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Skip for Now'), findsOneWidget);
  });
}
