import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/adaptive_config.dart';
import 'adaptive_theme_data.dart';

/// Top-level adaptive theme widget that provides both Material and Cupertino themes
/// to the widget hierarchy while registering an [AdaptiveConfig] platform resolution scope.
class AdaptiveTheme extends InheritedWidget {
  /// Creates an [AdaptiveTheme].
  AdaptiveTheme({
    super.key,
    required this.data,
    required Widget child,
  }) : super(
          child: AdaptiveConfig(
            platform: data.platform,
            child: Theme(
              data: data.materialTheme,
              child: CupertinoTheme(
                data: data.cupertinoTheme,
                child: child,
              ),
            ),
          ),
        );

  /// The active [AdaptiveThemeData].
  final AdaptiveThemeData data;

  /// Retrieves the nearest [AdaptiveThemeData] from the given [context].
  static AdaptiveThemeData of(BuildContext context) {
    final AdaptiveTheme? theme = maybeOf(context);
    assert(theme != null, 'No AdaptiveTheme found in context');
    return theme!.data;
  }

  /// Retrieves the nearest [AdaptiveTheme] from the given [context], or `null` if none exists.
  static AdaptiveTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveTheme>();
  }

  @override
  bool updateShouldNotify(AdaptiveTheme oldWidget) => data != oldWidget.data;
}
