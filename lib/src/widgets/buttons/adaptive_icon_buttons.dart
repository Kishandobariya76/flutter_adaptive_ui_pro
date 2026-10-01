import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive icon button.
class AdaptiveIconButton extends StatelessWidget {
  /// Creates an [AdaptiveIconButton].
  const AdaptiveIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.enabled = true,
    this.platform,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Icon widget to display.
  final Widget icon;

  /// Whether the button is enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Optional tooltip.
  final String? tooltip;

  /// Icon color when enabled.
  final Color? color;

  /// Icon color when disabled.
  final Color? disabledColor;

  /// Dimension of the icon.
  final double iconSize;

  /// Padding around the icon.
  final EdgeInsetsGeometry padding;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Semantic accessibility label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);
    final VoidCallback? effectiveOnPressed = enabled ? onPressed : null;

    Widget result;
    if (isCupertino) {
      final Color effectiveColor = enabled
          ? (color ?? CupertinoTheme.of(context).primaryColor)
          : (disabledColor ?? CupertinoColors.inactiveGray);
      result = CupertinoButton(
        onPressed: effectiveOnPressed,
        padding: padding,
        minimumSize: Size.square(iconSize + padding.vertical),
        focusNode: focusNode,
        autofocus: autofocus,
        child: IconTheme.merge(
          data: IconThemeData(color: effectiveColor, size: iconSize),
          child: icon,
        ),
      );
    } else {
      result = IconButton(
        onPressed: effectiveOnPressed,
        icon: icon,
        tooltip: tooltip,
        color: color,
        disabledColor: disabledColor,
        iconSize: iconSize,
        padding: padding,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    }

    if (semanticLabel != null && semanticLabel!.isNotEmpty) {
      result = Semantics(
        label: semanticLabel,
        button: true,
        enabled: enabled,
        child: result,
      );
    }

    return result;
  }
}

/// Platform-adaptive floating action button.
///
/// On Android, renders a Material [FloatingActionButton].
/// On iOS, renders an elevated, rounded Cupertino action capsule with smooth shadow.
class AdaptiveFloatingActionButton extends StatelessWidget {
  /// Creates an [AdaptiveFloatingActionButton].
  const AdaptiveFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation = 6.0,
    this.shape,
    this.mini = false,
    this.platform,
    this.heroTag,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Icon or content inside button.
  final Widget child;

  /// Tooltip message.
  final String? tooltip;

  /// Foreground / icon color.
  final Color? foregroundColor;

  /// Background surface color.
  final Color? backgroundColor;

  /// Elevation depth.
  final double elevation;

  /// Custom shape border.
  final ShapeBorder? shape;

  /// Whether to render in compact mini size.
  final bool mini;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Hero tag for navigation transitions.
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final double size = mini ? 44.0 : 56.0;
      final Color bg = backgroundColor ?? CupertinoTheme.of(context).primaryColor;
      final Color fg = foregroundColor ?? CupertinoColors.white;

      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CupertinoColors.black.withValues(alpha: 0.25),
              blurRadius: elevation * 1.5,
              offset: Offset(0, elevation * 0.5),
            ),
          ],
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(size / 2),
          onPressed: onPressed,
          child: IconTheme.merge(
            data: IconThemeData(color: fg, size: mini ? 20.0 : 24.0),
            child: child,
          ),
        ),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      mini: mini,
      heroTag: heroTag,
      child: child,
    );
  }
}

/// Platform-adaptive back navigation button.
class AdaptiveBackButton extends StatelessWidget {
  /// Creates an [AdaptiveBackButton].
  const AdaptiveBackButton({
    super.key,
    this.color,
    this.onPressed,
    this.platform,
    this.previousPageTitle,
  });

  /// Icon color override.
  final Color? color;

  /// Custom action override when tapped. Defaults to popping the navigator.
  final VoidCallback? onPressed;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Optional label for the previous page on iOS.
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoNavigationBarBackButton(
        color: color,
        previousPageTitle: previousPageTitle,
        onPressed: onPressed ?? () => Navigator.maybePop(context),
      );
    }

    return BackButton(
      color: color,
      onPressed: onPressed,
    );
  }
}

/// Platform-adaptive close button.
class AdaptiveCloseButton extends StatelessWidget {
  /// Creates an [AdaptiveCloseButton].
  const AdaptiveCloseButton({
    super.key,
    this.color,
    this.onPressed,
    this.platform,
  });

  /// Icon color override.
  final Color? color;

  /// Custom action override when tapped. Defaults to popping the navigator.
  final VoidCallback? onPressed;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final Color effectiveColor = color ?? CupertinoColors.label.resolveFrom(context);
      return CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: const Size.square(36),
        onPressed: onPressed ?? () => Navigator.maybePop(context),
        child: Icon(CupertinoIcons.xmark_circle_fill, color: effectiveColor, size: 24),
      );
    }

    return CloseButton(
      color: color,
      onPressed: onPressed,
    );
  }
}
