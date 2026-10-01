import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive circular progress indicator.
///
/// On iOS, renders [CupertinoActivityIndicator].
/// On Android/Web/Desktop, renders Material [CircularProgressIndicator].
class AdaptiveCircularProgressIndicator extends StatelessWidget {
  /// Creates an [AdaptiveCircularProgressIndicator].
  const AdaptiveCircularProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.radius = 12.0,
    this.animating = true,
    this.platform,
    this.semanticLabel,
  });

  /// Deterministic progress value between 0.0 and 1.0, or null for indeterminate.
  final double? value;

  /// Progress color.
  final Color? color;

  /// Background track color.
  final Color? backgroundColor;

  /// Stroke width for Material circular indicator.
  final double strokeWidth;

  /// Radius for Cupertino activity indicator.
  final double radius;

  /// Whether animation is active for Cupertino indicator.
  final bool animating;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    Widget result;
    if (isCupertino) {
      if (value != null) {
        result = CupertinoActivityIndicator.partiallyRevealed(
          radius: radius,
          progress: value!.clamp(0.0, 1.0),
          color: color,
        );
      } else {
        result = CupertinoActivityIndicator(
          radius: radius,
          animating: animating,
          color: color,
        );
      }
    } else {
      result = CircularProgressIndicator(
        value: value,
        color: color,
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
        semanticsLabel: semanticLabel,
      );
    }

    if (semanticLabel != null && isCupertino) {
      result = Semantics(label: semanticLabel, child: result);
    }

    return result;
  }
}

/// Convenience alias for circular activity spinner.
typedef AdaptiveLoadingIndicator = AdaptiveCircularProgressIndicator;

/// Platform-adaptive linear progress indicator.
class AdaptiveLinearProgressIndicator extends StatelessWidget {
  /// Creates an [AdaptiveLinearProgressIndicator].
  const AdaptiveLinearProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight = 4.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.platform,
    this.semanticLabel,
  });

  /// Current progress value between 0.0 and 1.0.
  final double? value;

  /// Progress bar color.
  final Color? color;

  /// Background track color.
  final Color? backgroundColor;

  /// Minimum height of track.
  final double minHeight;

  /// Corner radius of the track.
  final BorderRadius borderRadius;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final Color active = color ?? CupertinoTheme.of(context).primaryColor;
      final Color bg = backgroundColor ?? CupertinoColors.systemGrey5.resolveFrom(context);

      return Semantics(
        label: semanticLabel,
        value: value != null ? '${(value! * 100).toInt()}%' : null,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            height: minHeight,
            color: bg,
            child: value != null
                ? FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value!.clamp(0.0, 1.0),
                    child: Container(color: active),
                  )
                : const LinearProgressIndicator(),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: LinearProgressIndicator(
        value: value,
        color: color,
        backgroundColor: backgroundColor,
        minHeight: minHeight,
        semanticsLabel: semanticLabel,
      ),
    );
  }
}
