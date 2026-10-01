import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform-agnostic color scheme bridging Material 3 [ColorScheme] and Cupertino color semantics.
class AdaptiveColorScheme {
  /// Creates an [AdaptiveColorScheme].
  const AdaptiveColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    this.brightness = Brightness.light,
    Color? secondary,
    Color? onSecondary,
  })  : secondary = secondary ?? primary,
        onSecondary = onSecondary ?? onPrimary;

  /// Creates a light color scheme default.
  factory AdaptiveColorScheme.light({
    Color primary = const Color(0xFF007AFF),
    Color surface = const Color(0xFFFFFFFF),
    Color background = const Color(0xFFF2F2F7),
    Color error = const Color(0xFFFF3B30),
  }) {
    return AdaptiveColorScheme(
      primary: primary,
      onPrimary: Colors.white,
      surface: surface,
      onSurface: const Color(0xFF000000),
      background: background,
      onBackground: const Color(0xFF000000),
      error: error,
      onError: Colors.white,
      brightness: Brightness.light,
    );
  }

  /// Creates a dark color scheme default.
  factory AdaptiveColorScheme.dark({
    Color primary = const Color(0xFF0A84FF),
    Color surface = const Color(0xFF1C1C1E),
    Color background = const Color(0xFF000000),
    Color error = const Color(0xFFFF453A),
  }) {
    return AdaptiveColorScheme(
      primary: primary,
      onPrimary: Colors.white,
      surface: surface,
      onSurface: const Color(0xFFFFFFFF),
      background: background,
      onBackground: const Color(0xFFFFFFFF),
      error: error,
      onError: Colors.white,
      brightness: Brightness.dark,
    );
  }

  /// Primary brand color.
  final Color primary;

  /// Contrast color on [primary].
  final Color onPrimary;

  /// Secondary accent color.
  final Color secondary;

  /// Contrast color on [secondary].
  final Color onSecondary;

  /// Surface color for cards, sheets, dialogs.
  final Color surface;

  /// Contrast color on [surface].
  final Color onSurface;

  /// Background color for scaffolding.
  final Color background;

  /// Contrast color on [background].
  final Color onBackground;

  /// Semantic error color.
  final Color error;

  /// Contrast color on [error].
  final Color onError;

  /// Overall brightness mode.
  final Brightness brightness;

  /// Converts this scheme to a Material 3 [ColorScheme].
  ColorScheme toMaterialColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
    );
  }

  /// Converts this scheme to a [CupertinoThemeData].
  CupertinoThemeData toCupertinoThemeData() {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: primary,
      barBackgroundColor: surface.withValues(alpha: 0.9),
      scaffoldBackgroundColor: background,
    );
  }
}
