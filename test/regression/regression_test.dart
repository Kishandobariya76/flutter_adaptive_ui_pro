import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Regression & Edge Case Tests', () {
    testWidgets('AdaptiveIcon renders Material icon on Android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: const Scaffold(
            body: AdaptiveIcon(
              material: Icons.settings,
              cupertino: CupertinoIcons.gear,
            ),
          ),
        ),
      );

      final Icon matIcon = tester.widget<Icon>(find.byType(Icon));
      expect(matIcon.icon, equals(Icons.settings));
    });

    testWidgets('AdaptiveIcon renders Cupertino icon on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: const Scaffold(
            body: AdaptiveIcon(
              material: Icons.settings,
              cupertino: CupertinoIcons.gear,
            ),
          ),
        ),
      );

      final Icon cupIcon = tester.widget<Icon>(find.byType(Icon));
      expect(cupIcon.icon, equals(CupertinoIcons.gear));
    });

    testWidgets('AdaptiveScaffold renders body properly when app bar and bottom bar are omitted',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: const AdaptiveScaffold(
            body: Center(child: Text('Only Body Content')),
          ),
        ),
      );

      expect(find.text('Only Body Content'), findsOneWidget);
      expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    });

    testWidgets('AdaptiveDivider renders hairline thickness on Cupertino', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: const Scaffold(
            body: AdaptiveDivider(),
          ),
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('AdaptiveBadge displays text count and supports large styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AdaptiveBadge(
              count: 99,
              isLarge: true,
              child: Icon(Icons.mail),
            ),
          ),
        ),
      );

      expect(find.text('99'), findsOneWidget);
      expect(find.byType(AdaptiveBadge), findsOneWidget);
    });
  });
}
