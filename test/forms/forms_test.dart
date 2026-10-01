import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adaptive Form System Tests', () {
    testWidgets('AdaptiveTextFormField integrates with Form validation on Android', (WidgetTester tester) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveForm(
              formKey: formKey,
              child: Column(
                children: <Widget>[
                  AdaptiveTextFormField(
                    placeholder: 'Email',
                    validator: (String? v) => v == null || !v.contains('@') ? 'Invalid email' : null,
                    onSaved: (String? v) => savedValue = v,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Submit empty
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);
      expect(savedValue, isNull);

      // Enter valid email
      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email'), findsNothing);
      expect(savedValue, equals('test@example.com'));
    });

    testWidgets('AdaptiveTextFormField integrates with Form validation on iOS', (WidgetTester tester) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveForm(
              formKey: formKey,
              child: Column(
                children: <Widget>[
                  AdaptiveTextFormField(
                    placeholder: 'Email',
                    validator: (String? v) => v == null || !v.contains('@') ? 'Invalid email' : null,
                    onSaved: (String? v) => savedValue = v,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Submit empty
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);

      // Enter valid email
      await tester.enterText(find.byType(CupertinoTextField), 'ios@example.com');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email'), findsNothing);
      expect(savedValue, equals('ios@example.com'));
    });

    testWidgets('AdaptiveFormSection and AdaptiveFormRow render grouped controls', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          themeMode: ThemeMode.light,
          home: Scaffold(
            body: AdaptiveFormSection(
              platform: AdaptivePlatform.cupertino,
              header: Text('Account'),
              children: <Widget>[
                AdaptiveFormRow(
                  prefix: Text('Username'),
                  child: AdaptiveTextField(placeholder: 'john_doe'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.byType(CupertinoFormSection), findsOneWidget);
      expect(find.byType(CupertinoFormRow), findsOneWidget);
    });
  });
}
