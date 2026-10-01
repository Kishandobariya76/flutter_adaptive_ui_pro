import 'package:flutter/foundation.dart';

/// Flutter-safe platform detection utility that operates cleanly across mobile, desktop, and web.
///
/// This utility intentionally avoids importing `dart:io` to guarantee complete compatibility
/// with Flutter Web and testing environments.
abstract final class PlatformDetector {
  /// Returns the current target platform as determined by Flutter framework.
  static TargetPlatform get targetPlatform => defaultTargetPlatform;

  /// Returns `true` if compiling or running in Flutter Web.
  static bool get isWeb => kIsWeb;

  /// Returns `true` if the platform is Android and not running on Web.
  static bool get isAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns `true` if the platform is iOS and not running on Web.
  static bool get isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns `true` if the platform is macOS and not running on Web.
  static bool get isMacOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns `true` if the platform is Windows and not running on Web.
  static bool get isWindows => !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns `true` if the platform is Linux and not running on Web.
  static bool get isLinux => !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Returns `true` if the platform is Fuchsia and not running on Web.
  static bool get isFuchsia => !kIsWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Returns `true` if running on any desktop platform (macOS, Windows, Linux).
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Returns `true` if running on any mobile platform (iOS, Android).
  static bool get isMobile => isIOS || isAndroid;

  /// Returns a human-readable platform description string.
  static String get platformName {
    if (kIsWeb) return 'Web (${defaultTargetPlatform.name})';
    return defaultTargetPlatform.name;
  }
}
