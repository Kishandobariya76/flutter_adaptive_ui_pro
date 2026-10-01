import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adaptive Text Field Tests', () {
    testWidgets('AdaptiveTextField renders TextField on Android', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      String changedText = '';

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveTextField(
              controller: controller,
              placeholder: 'Enter username',
              onChanged: (String v) => changedText = v,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(CupertinoTextField), findsNothing);

      await tester.enterText(find.byType(TextField), 'kishan');
      expect(changedText, equals('kishan'));
      expect(controller.text, equals('kishan'));
    });

    testWidgets('AdaptiveTextField renders CupertinoTextField on iOS', (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveTextField(
              controller: controller,
              placeholder: 'Enter password',
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoTextField), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('AdaptiveSearchField renders CupertinoSearchTextField on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: const Scaffold(
            body: AdaptiveSearchField(placeholder: 'Search items'),
          ),
        ),
      );

      expect(find.byType(CupertinoSearchTextField), findsOneWidget);
    });

    testWidgets('AdaptivePasswordField toggles obscurity on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: const Scaffold(
            body: AdaptivePasswordField(placeholder: 'Password'),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      final TextField initialField = tester.widget<TextField>(find.byType(TextField));
      expect(initialField.obscureText, isTrue);

      // Tap toggle icon button
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      final TextField revealedField = tester.widget<TextField>(find.byType(TextField));
      expect(revealedField.obscureText, isFalse);
    });
  });
}
