import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'adaptive_config.dart';
import 'adaptive_platform.dart';

/// Central platform resolution engine implementing the 5-step resolution cascade.
///
/// Priority:
/// 1. Widget-level override (if specified and not [AdaptivePlatform.adaptive])
/// 2. Nearest [AdaptiveConfig] in the widget tree (if not [AdaptivePlatform.adaptive])
/// 3. Flutter platform detection (`Theme.of(context).platform` or [defaultTargetPlatform])
/// 4. Design system mapping (TargetPlatform.iOS => Cupertino; all others => Material)
/// 5. Material fallback
abstract final class PlatformResolver {
  /// Resolves the active [AdaptivePlatform] for the given [context] and optional [widgetOverride].
  static AdaptivePlatform resolve(
    BuildContext context, {
    AdaptivePlatform? widgetOverride,
  }) {
    // 1. Widget-level override
    if (widgetOverride != null && widgetOverride != AdaptivePlatform.adaptive) {
      return widgetOverride;
    }

    // 2. Nearest AdaptiveConfig
    final AdaptiveConfig? config = AdaptiveConfig.maybeOf(context);
    if (config != null && config.platform != AdaptivePlatform.adaptive) {
      return config.platform;
    }

    // 3. Platform detection from Theme or defaultTargetPlatform
    TargetPlatform target;
    try {
      target = Theme.of(context).platform;
    } catch (_) {
      target = defaultTargetPlatform;
    }

    // 4. iOS => Cupertino; all others (Android, Web, Desktop, Fuchsia) => Material
    if (target == TargetPlatform.iOS) {
      return AdaptivePlatform.cupertino;
    }

    // 5. Default Material
    return AdaptivePlatform.material;
  }

  /// Returns `true` if the resolved platform is [AdaptivePlatform.cupertino].
  static bool isCupertino(
    BuildContext context, {
    AdaptivePlatform? widgetOverride,
  }) {
    return resolve(context, widgetOverride: widgetOverride) == AdaptivePlatform.cupertino;
  }

  /// Returns `true` if the resolved platform is [AdaptivePlatform.material].
  static bool isMaterial(
    BuildContext context, {
    AdaptivePlatform? widgetOverride,
  }) {
    return resolve(context, widgetOverride: widgetOverride) == AdaptivePlatform.material;
  }
}
