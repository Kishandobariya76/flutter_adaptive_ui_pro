import 'package:flutter/widgets.dart';
import 'adaptive_platform.dart';

/// An inherited configuration widget that supplies an [AdaptivePlatform] mode to its subtree.
class AdaptiveConfig extends InheritedWidget {
  /// Creates an [AdaptiveConfig] with a specified [platform] override.
  const AdaptiveConfig({
    super.key,
    required this.platform,
    required super.child,
  });

  /// The active platform mode for the descendant widget tree.
  final AdaptivePlatform platform;

  /// Retrieves the nearest [AdaptiveConfig] from the widget tree, if present.
  static AdaptiveConfig? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveConfig>();
  }

  /// Retrieves the nearest [AdaptiveConfig] from the widget tree, throwing if not found.
  static AdaptiveConfig of(BuildContext context) {
    final AdaptiveConfig? result = maybeOf(context);
    assert(result != null, 'No AdaptiveConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AdaptiveConfig oldWidget) => platform != oldWidget.platform;
}
