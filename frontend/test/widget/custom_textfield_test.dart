import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/core/widgets/custom_textfield.dart';
import 'package:home_tweak/core/theme/app_theme.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );

void main() {
  group('CustomTextField', () {
    testWidgets('shows hint text', (tester) async {
      await tester.pumpWidget(_wrap(
        const CustomTextField(hintText: 'Enter your email'),
      ));
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('shows label when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        const CustomTextField(label: 'EMAIL', hintText: 'email'),
      ));
      expect(find.text('EMAIL'), findsOneWidget);
    });

    testWidgets('accepts user input', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(_wrap(
        CustomTextField(controller: ctrl, hintText: 'Type here'),
      ));
      await tester.enterText(find.byType(TextField), 'Hello');
      expect(ctrl.text, 'Hello');
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      await tester.pumpWidget(_wrap(
        const CustomTextField(hintText: 'Password', obscureText: true),
      ));
      final tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.obscureText, true);
    });
  });
}