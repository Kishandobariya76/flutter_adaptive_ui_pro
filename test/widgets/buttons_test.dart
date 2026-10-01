import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adaptive Button System Tests', () {
    testWidgets('AdaptiveButton renders FilledButton on Android', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          key: const ValueKey<String>('android_app'),
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveButton(
              label: 'Click Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(CupertinoButton), findsNothing);

      await tester.tap(find.byType(FilledButton));
      expect(tapped, isTrue);
    });

    testWidgets('AdaptiveButton renders CupertinoButton on iOS', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          key: const ValueKey<String>('ios_app'),
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveButton(
              label: 'Click Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);

      await tester.tap(find.byType(CupertinoButton));
      expect(tapped, isTrue);
    });

    testWidgets('AdaptiveButton respects widget-level override', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveButton(
              platform: AdaptivePlatform.cupertino,
              label: 'Override',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('AdaptiveButton handles disabled state correctly', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveButton(
              label: 'Disabled',
              enabled: false,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      expect(tapped, isFalse);
    });

    testWidgets('AdaptiveIconButton renders IconButton on Android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveIconButton(
              icon: const Icon(Icons.star),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('AdaptiveIconButton renders CupertinoButton on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveIconButton(
              icon: const Icon(Icons.star),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoButton), findsOneWidget);
    });

    testWidgets('AdaptiveFloatingActionButton renders FAB on Android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('AdaptiveFloatingActionButton renders elevated capsule on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveFloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byType(CupertinoButton), findsOneWidget);
    });
  });
}
