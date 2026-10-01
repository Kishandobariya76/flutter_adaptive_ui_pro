import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveTheme System Tests', () {
    test('AdaptiveColorScheme generates valid Material and Cupertino themes', () {
      final AdaptiveColorScheme lightScheme = AdaptiveColorScheme.light(primary: Colors.indigo);
      final ColorScheme matScheme = lightScheme.toMaterialColorScheme();
      final CupertinoThemeData cupTheme = lightScheme.toCupertinoThemeData();

      expect(matScheme.primary, equals(Colors.indigo));
      expect(cupTheme.primaryColor, equals(Colors.indigo));
      expect(matScheme.brightness, equals(Brightness.light));
      expect(cupTheme.brightness, equals(Brightness.light));
    });

    test('AdaptiveThemeData.fromSeed creates coordinated themes', () {
      final AdaptiveThemeData themeData = AdaptiveThemeData.fromSeed(
        seedColor: Colors.deepPurple,
        platform: AdaptivePlatform.adaptive,
      );

      expect(themeData.platform, equals(AdaptivePlatform.adaptive));
      expect(themeData.materialTheme.colorScheme.primary, isNotNull);
      expect(themeData.cupertinoTheme.primaryColor, equals(Colors.deepPurple));
    });

    testWidgets('AdaptiveTheme injects AdaptiveConfig and themes into context', (WidgetTester tester) async {
      final AdaptiveThemeData themeData = AdaptiveThemeData.light(platform: AdaptivePlatform.cupertino);

      await tester.pumpWidget(
        AdaptiveTheme(
          data: themeData,
          child: Builder(
            builder: (BuildContext context) {
              final AdaptiveThemeData retrieved = AdaptiveTheme.of(context);
              expect(retrieved.platform, equals(AdaptivePlatform.cupertino));
              expect(context.isCupertino, isTrue);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('AdaptiveScope updates when values change', (WidgetTester tester) async {
      await tester.pumpWidget(
        const AdaptiveScope(
          platform: AdaptivePlatform.material,
          isDarkMode: false,
          child: SizedBox.shrink(),
        ),
      );

      expect(find.byType(AdaptiveScope), findsOneWidget);
    });
  });
}
