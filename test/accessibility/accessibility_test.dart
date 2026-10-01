import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Accessibility & Semantics Tests', () {
    testWidgets('AdaptiveButton provides semantic label and button flag', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaptiveButton(
              label: 'Proceed',
              semanticLabel: 'Proceed to Checkout Step',
              onPressed: () {},
            ),
          ),
        ),
      );

      final SemanticsHandle handle = tester.ensureSemantics();

      expect(
        tester.getSemantics(find.byType(AdaptiveButton)),
        matchesSemantics(
          label: 'Proceed to Checkout Step',
          isButton: true,
          isEnabled: true,
          hasEnabledState: true,
        ),
      );

      handle.dispose();
    });

    testWidgets('Disabled state reflects correctly in semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdaptiveButton(
              label: 'Proceed',
              semanticLabel: 'Proceed to Checkout Step',
              enabled: false,
              onPressed: () {},
            ),
          ),
        ),
      );

      final SemanticsHandle handle = tester.ensureSemantics();

      expect(
        tester.getSemantics(find.byType(AdaptiveButton)),
        matchesSemantics(
          label: 'Proceed to Checkout Step',
          isButton: true,
          hasEnabledState: true,
        ),
      );

      handle.dispose();
    });

    testWidgets('Adaptive widgets adapt to large text scaling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2.5)),
            child: Scaffold(
              body: Column(
                children: <Widget>[
                  AdaptiveButton(
                    label: 'Large Font Action',
                    onPressed: () {},
                  ),
                  const AdaptiveTextField(
                    placeholder: 'Type here',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Large Font Action'), findsOneWidget);
      expect(find.byType(AdaptiveButton), findsOneWidget);
    });

    testWidgets('Adaptive widgets support RTL directionality', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: AdaptiveListTile(
                leading: Icon(Icons.star),
                title: Text('عنوان القائمة'),
                trailing: Icon(Icons.chevron_left),
              ),
            ),
          ),
        ),
      );

      expect(find.text('عنوان القائمة'), findsOneWidget);
    });
  });
}
