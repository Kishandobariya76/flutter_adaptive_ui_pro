import 'package:flutter/widgets.dart';
import 'adaptive_platform.dart';

/// A scope widget providing reactive platform and environment metadata.
class AdaptiveScope extends InheritedWidget {
  /// Creates an [AdaptiveScope].
  const AdaptiveScope({
    super.key,
    required this.platform,
    this.isDarkMode = false,
    required super.child,
  });

  /// The active [AdaptivePlatform] for this scope.
  final AdaptivePlatform platform;

  /// Whether dark mode is active in this scope.
  final bool isDarkMode;

  /// Retrieves the nearest [AdaptiveScope] from the context.
  static AdaptiveScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveScope>();
  }

  /// Retrieves the nearest [AdaptiveScope] from the context, throwing if not found.
  static AdaptiveScope of(BuildContext context) {
    final AdaptiveScope? result = maybeOf(context);
    assert(result != null, 'No AdaptiveScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AdaptiveScope oldWidget) {
    return platform != oldWidget.platform || isDarkMode != oldWidget.isDarkMode;
  }
}
