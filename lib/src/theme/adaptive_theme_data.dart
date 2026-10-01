import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/adaptive_platform.dart';
import 'adaptive_color_scheme.dart';
import 'adaptive_text_theme.dart';

/// Comprehensive theme data configuration holding both Material and Cupertino theme definitions.
class AdaptiveThemeData {
  /// Creates an [AdaptiveThemeData].
  AdaptiveThemeData({
    this.platform = AdaptivePlatform.adaptive,
    ThemeData? materialTheme,
    CupertinoThemeData? cupertinoTheme,
    this.brightness = Brightness.light,
    this.colorScheme,
    this.textTheme = const AdaptiveTextTheme(),
  })  : materialTheme = materialTheme ??
            ThemeData(
              useMaterial3: true,
              brightness: brightness,
              colorScheme: colorScheme?.toMaterialColorScheme() ??
                  ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF), brightness: brightness),
            ),
        cupertinoTheme = cupertinoTheme ??
            (colorScheme?.toCupertinoThemeData() ??
                CupertinoThemeData(
                  brightness: brightness,
                  primaryColor: const CupertinoDynamicColor.withBrightness(
                    color: Color(0xFF007AFF),
                    darkColor: Color(0xFF0A84FF),
                  ),
                ));

  /// Creates a default light theme.
  factory AdaptiveThemeData.light({
    AdaptivePlatform platform = AdaptivePlatform.adaptive,
    Color primaryColor = const Color(0xFF007AFF),
  }) {
    final AdaptiveColorScheme scheme = AdaptiveColorScheme.light(primary: primaryColor);
    return AdaptiveThemeData(
      platform: platform,
      brightness: Brightness.light,
      colorScheme: scheme,
      materialTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: scheme.toMaterialColorScheme(),
      ),
      cupertinoTheme: scheme.toCupertinoThemeData(),
    );
  }

  /// Creates a default dark theme.
  factory AdaptiveThemeData.dark({
    AdaptivePlatform platform = AdaptivePlatform.adaptive,
    Color primaryColor = const Color(0xFF0A84FF),
  }) {
    final AdaptiveColorScheme scheme = AdaptiveColorScheme.dark(primary: primaryColor);
    return AdaptiveThemeData(
      platform: platform,
      brightness: Brightness.dark,
      colorScheme: scheme,
      materialTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: scheme.toMaterialColorScheme(),
      ),
      cupertinoTheme: scheme.toCupertinoThemeData(),
    );
  }

  /// Creates theme data generated from a seed color.
  factory AdaptiveThemeData.fromSeed({
    required Color seedColor,
    AdaptivePlatform platform = AdaptivePlatform.adaptive,
    Brightness brightness = Brightness.light,
  }) {
    final ColorScheme matScheme = ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
    return AdaptiveThemeData(
      platform: platform,
      brightness: brightness,
      materialTheme: ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: matScheme,
      ),
      cupertinoTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: seedColor,
      ),
    );
  }

  /// The active [AdaptivePlatform] mode.
  final AdaptivePlatform platform;

  /// The backing Material [ThemeData].
  final ThemeData materialTheme;

  /// The backing [CupertinoThemeData].
  final CupertinoThemeData cupertinoTheme;

  /// Theme brightness (light or dark).
  final Brightness brightness;

  /// Unified color scheme.
  final AdaptiveColorScheme? colorScheme;

  /// Unified typography.
  final AdaptiveTextTheme textTheme;

  /// Creates a copy of this theme data with updated values.
  AdaptiveThemeData copyWith({
    AdaptivePlatform? platform,
    ThemeData? materialTheme,
    CupertinoThemeData? cupertinoTheme,
    Brightness? brightness,
    AdaptiveColorScheme? colorScheme,
    AdaptiveTextTheme? textTheme,
  }) {
    return AdaptiveThemeData(
      platform: platform ?? this.platform,
      materialTheme: materialTheme ?? this.materialTheme,
      cupertinoTheme: cupertinoTheme ?? this.cupertinoTheme,
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
    );
  }
}
