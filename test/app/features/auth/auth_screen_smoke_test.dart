import 'package:activly/activly_app.dart';
import 'package:activly/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Auth screen renders sign in state', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: AuthScreen(
            language: AppLanguage.en,
            onToggleLanguage: () {},
            onBackToLanding: () {},
            onAuthSuccess: () {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsAtLeastNWidgets(1));
  });
}
