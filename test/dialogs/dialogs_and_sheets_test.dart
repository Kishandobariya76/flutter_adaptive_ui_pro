import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adaptive Dialogs and Sheets Tests', () {
    testWidgets('AdaptiveDialog.confirm displays AlertDialog on Android', (WidgetTester tester) async {
      bool? confirmed;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    confirmed = await AdaptiveDialog.confirm(
                      context: context,
                      title: 'Delete Item?',
                      message: 'This cannot be undone.',
                    );
                  },
                  child: const Text('Open Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Delete Item?'), findsOneWidget);
      expect(find.text('This cannot be undone.'), findsOneWidget);

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(confirmed, isTrue);
    });

    testWidgets('AdaptiveDialog.confirm displays CupertinoAlertDialog on iOS', (WidgetTester tester) async {
      bool? confirmed;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    confirmed = await AdaptiveDialog.confirm(
                      context: context,
                      title: 'Delete Item?',
                      message: 'This cannot be undone.',
                    );
                  },
                  child: const Text('Open Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.text('Delete Item?'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(confirmed, isFalse);
    });

    testWidgets('AdaptiveActionSheet presents CupertinoActionSheet on iOS', (WidgetTester tester) async {
      String? selected;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    selected = await AdaptiveActionSheet.show<String>(
                      context: context,
                      titleText: 'Actions',
                      actions: const <AdaptiveSheetAction<String>>[
                        AdaptiveSheetAction<String>(title: 'Share', value: 'share'),
                        AdaptiveSheetAction<String>(title: 'Delete', value: 'delete', isDestructive: true),
                      ],
                    );
                  },
                  child: const Text('Open Sheet'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoActionSheet), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);

      await tester.tap(find.text('Share'));
      await tester.pumpAndSettle();

      expect(selected, equals('share'));
    });
  });
}
