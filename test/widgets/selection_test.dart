import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adaptive Selection Controls Tests', () {
    testWidgets('AdaptiveSwitch renders Switch on Android and triggers onChanged', (WidgetTester tester) async {
      bool switchVal = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AdaptiveSwitch(
                  value: switchVal,
                  onChanged: (bool v) => setState(() => switchVal = v),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
      expect(find.byType(CupertinoSwitch), findsNothing);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(switchVal, isTrue);
    });

    testWidgets('AdaptiveSwitch renders CupertinoSwitch on iOS', (WidgetTester tester) async {
      bool switchVal = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AdaptiveSwitch(
                  value: switchVal,
                  onChanged: (bool v) => setState(() => switchVal = v),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoSwitch), findsOneWidget);
      expect(find.byType(Switch), findsNothing);
    });

    testWidgets('AdaptiveCheckbox renders Checkbox on Android', (WidgetTester tester) async {
      bool? checkVal = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveCheckbox(
              value: checkVal,
              onChanged: (bool? v) => checkVal = v,
            ),
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.byType(CupertinoCheckbox), findsNothing);
    });

    testWidgets('AdaptiveCheckbox renders CupertinoCheckbox on iOS', (WidgetTester tester) async {
      bool? checkVal = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveCheckbox(
              value: checkVal,
              onChanged: (bool? v) => checkVal = v,
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoCheckbox), findsOneWidget);
      expect(find.byType(Checkbox), findsNothing);
    });

    testWidgets('AdaptiveSlider renders Slider on Android', (WidgetTester tester) async {
      double sliderVal = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveSlider(
              value: sliderVal,
              onChanged: (double v) => sliderVal = v,
            ),
          ),
        ),
      );

      expect(find.byType(Slider), findsOneWidget);
      expect(find.byType(CupertinoSlider), findsNothing);
    });

    testWidgets('AdaptiveSlider renders CupertinoSlider on iOS', (WidgetTester tester) async {
      double sliderVal = 0.5;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveSlider(
              value: sliderVal,
              onChanged: (double v) => sliderVal = v,
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoSlider), findsOneWidget);
      expect(find.byType(Slider), findsNothing);
    });

    testWidgets('AdaptiveSegmentedControl renders SegmentedButton on Android', (WidgetTester tester) async {
      int selected = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: AdaptiveSegmentedControl<int>(
              groupValue: selected,
              onValueChanged: (int? v) => selected = v ?? 0,
              children: const <int, Widget>{
                0: Text('First'),
                1: Text('Second'),
              },
            ),
          ),
        ),
      );

      expect(find.byType(SegmentedButton<int>), findsOneWidget);
      expect(find.byType(CupertinoSlidingSegmentedControl<int>), findsNothing);
    });

    testWidgets('AdaptiveSegmentedControl renders CupertinoSlidingSegmentedControl on iOS',
        (WidgetTester tester) async {
      int selected = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: AdaptiveSegmentedControl<int>(
              groupValue: selected,
              onValueChanged: (int? v) => selected = v ?? 0,
              children: const <int, Widget>{
                0: Text('First'),
                1: Text('Second'),
              },
            ),
          ),
        ),
      );

      expect(find.byType(CupertinoSlidingSegmentedControl<int>), findsOneWidget);
      expect(find.byType(SegmentedButton<int>), findsNothing);
    });
  });
}
