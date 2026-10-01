import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformResolver Cascade Tests', () {
    testWidgets('resolves to Material by default on Android/Desktop/Web', (WidgetTester tester) async {
      AdaptivePlatform? resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Builder(
            builder: (BuildContext context) {
              resolved = PlatformResolver.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved, equals(AdaptivePlatform.material));
    });

    testWidgets('resolves to Cupertino on iOS target platform', (WidgetTester tester) async {
      AdaptivePlatform? resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Builder(
            builder: (BuildContext context) {
              resolved = PlatformResolver.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved, equals(AdaptivePlatform.cupertino));
    });

    testWidgets('widget-level override takes precedence over tree and platform', (WidgetTester tester) async {
      AdaptivePlatform? resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: AdaptiveConfig(
            platform: AdaptivePlatform.material,
            child: Builder(
              builder: (BuildContext context) {
                resolved = PlatformResolver.resolve(
                  context,
                  widgetOverride: AdaptivePlatform.cupertino,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(resolved, equals(AdaptivePlatform.cupertino));
    });

    testWidgets('nearest AdaptiveConfig takes precedence over parent AdaptiveConfig', (WidgetTester tester) async {
      AdaptivePlatform? outerResolved;
      AdaptivePlatform? innerResolved;

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveConfig(
            platform: AdaptivePlatform.material,
            child: Builder(
              builder: (BuildContext outerContext) {
                outerResolved = PlatformResolver.resolve(outerContext);
                return AdaptiveConfig(
                  platform: AdaptivePlatform.cupertino,
                  child: Builder(
                    builder: (BuildContext innerContext) {
                      innerResolved = PlatformResolver.resolve(innerContext);
                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(outerResolved, equals(AdaptivePlatform.material));
      expect(innerResolved, equals(AdaptivePlatform.cupertino));
    });

    testWidgets('AdaptiveConfig.adaptive falls through to platform detection', (WidgetTester tester) async {
      AdaptivePlatform? resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: AdaptiveConfig(
            platform: AdaptivePlatform.adaptive,
            child: Builder(
              builder: (BuildContext context) {
                resolved = PlatformResolver.resolve(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(resolved, equals(AdaptivePlatform.cupertino));
    });

    testWidgets('PlatformResolver.isCupertino and isMaterial helpers reflect resolution', (WidgetTester tester) async {
      bool isCup = false;
      bool isMat = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Builder(
            builder: (BuildContext context) {
              isCup = PlatformResolver.isCupertino(context);
              isMat = PlatformResolver.isMaterial(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(isCup, isTrue);
      expect(isMat, isFalse);
    });
  });
}
