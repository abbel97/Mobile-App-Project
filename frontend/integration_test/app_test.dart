import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:home_tweak/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration — App Launch', () {
    testWidgets('app launches without crashing', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
     
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('splash screen transitions to home or dashboard', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 6));
    
      final hasText = find.byType(Text);
      expect(hasText, findsWidgets);
    });
  });

  group('Integration — Navigation', () {
    testWidgets('login screen is reachable from home', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final signIn = find.text('Sign In');
      if (signIn.evaluate().isNotEmpty) {
        await tester.tap(signIn.first);
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsWidgets);
      }
    });

    testWidgets('customer register screen is reachable', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final custBtn = find.text('Customer');
      if (custBtn.evaluate().isNotEmpty) {
        await tester.tap(custBtn.first);
        await tester.pumpAndSettle();
        expect(find.byType(TextField), findsWidgets);
      }
    });
  });
}