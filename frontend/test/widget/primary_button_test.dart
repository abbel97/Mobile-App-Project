import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/core/widgets/primary_button.dart';
import 'package:home_tweak/core/theme/app_theme.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

void main() {
  group('PrimaryButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(_wrap(
        PrimaryButton(label: 'Submit', onPressed: () {}),
      ));
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(_wrap(
        PrimaryButton(label: 'Tap', onPressed: () => tapped = true),
      ));
      await tester.tap(find.text('Tap'));
      expect(tapped, true);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(_wrap(
        const PrimaryButton(label: 'Disabled', onPressed: null),
      ));
      final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(btn.onPressed, isNull);
    });

    testWidgets('renders trailing widget when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        PrimaryButton(
          label:    'Go',
          trailing: const Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
      ));
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });
  });
}