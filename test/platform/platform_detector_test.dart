import 'package:flutter/foundation.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformDetector Tests', () {
    test('targetPlatform matches defaultTargetPlatform', () {
      expect(PlatformDetector.targetPlatform, equals(defaultTargetPlatform));
    });

    test('isWeb matches kIsWeb flag', () {
      expect(PlatformDetector.isWeb, equals(kIsWeb));
    });

    test('platformName returns non-empty string', () {
      expect(PlatformDetector.platformName.isNotEmpty, isTrue);
    });

    test('desktop and mobile categorization are mutually consistent', () {
      if (PlatformDetector.isDesktop) {
        expect(
          PlatformDetector.isMacOS || PlatformDetector.isWindows || PlatformDetector.isLinux,
          isTrue,
        );
      }
      if (PlatformDetector.isMobile) {
        expect(PlatformDetector.isIOS || PlatformDetector.isAndroid, isTrue);
      }
    });

    test('AdaptivePlatform extensions work correctly', () {
      expect(AdaptivePlatform.material.isMaterial, isTrue);
      expect(AdaptivePlatform.material.isCupertino, isFalse);
      expect(AdaptivePlatform.material.isAdaptive, isFalse);

      expect(AdaptivePlatform.cupertino.isCupertino, isTrue);
      expect(AdaptivePlatform.cupertino.isMaterial, isFalse);

      expect(AdaptivePlatform.adaptive.isAdaptive, isTrue);
    });
  });
}
