import 'package:flutter/widgets.dart';
import '../../core/adaptive_platform.dart';
import '../../theme/adaptive_component_theme.dart';
import 'adaptive_button.dart';

/// Platform-adaptive elevated button with subtle surface elevation or filled Cupertino styling.
class AdaptiveElevatedButton extends StatelessWidget {
  /// Creates an [AdaptiveElevatedButton].
  const AdaptiveElevatedButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.platform,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.minimumSize,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.material,
    this.cupertino,
  });

  /// Action when button is tapped.
  final VoidCallback? onPressed;

  /// Action when button is long pressed.
  final VoidCallback? onLongPress;

  /// Custom child widget.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether the button is enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Padding around button contents.
  final EdgeInsetsGeometry? padding;

  /// Background color.
  final Color? backgroundColor;

  /// Foreground / text color.
  final Color? foregroundColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Minimum button dimensions.
  final Size? minimumSize;

  /// Focus node for keyboard interactions.
  final FocusNode? focusNode;

  /// Whether to autofocus.
  final bool autofocus;

  /// Tooltip message.
  final String? tooltip;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Material configuration.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: AdaptiveButtonStyle.elevated,
      enabled: enabled,
      platform: platform,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      minimumSize: minimumSize,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      semanticLabel: semanticLabel,
      material: material,
      cupertino: cupertino,
      label: label,
      icon: icon,
      child: child,
    );
  }
}

/// Platform-adaptive filled button with prominent background.
class AdaptiveFilledButton extends StatelessWidget {
  /// Creates an [AdaptiveFilledButton].
  const AdaptiveFilledButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.platform,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.minimumSize,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.material,
    this.cupertino,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Action when long pressed.
  final VoidCallback? onLongPress;

  /// Custom child widget.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether the button is enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Padding around contents.
  final EdgeInsetsGeometry? padding;

  /// Background color.
  final Color? backgroundColor;

  /// Text / icon color.
  final Color? foregroundColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Minimum dimensions.
  final Size? minimumSize;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Tooltip message.
  final String? tooltip;

  /// Semantic label.
  final String? semanticLabel;

  /// Material configuration.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: AdaptiveButtonStyle.filled,
      enabled: enabled,
      platform: platform,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      minimumSize: minimumSize,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      semanticLabel: semanticLabel,
      material: material,
      cupertino: cupertino,
      label: label,
      icon: icon,
      child: child,
    );
  }
}

/// Platform-adaptive tonal filled button.
class AdaptiveFilledTonalButton extends StatelessWidget {
  /// Creates an [AdaptiveFilledTonalButton].
  const AdaptiveFilledTonalButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.platform,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.minimumSize,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.material,
    this.cupertino,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Action when long pressed.
  final VoidCallback? onLongPress;

  /// Custom child widget.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// Background color.
  final Color? backgroundColor;

  /// Text color.
  final Color? foregroundColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Minimum dimensions.
  final Size? minimumSize;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Tooltip message.
  final String? tooltip;

  /// Semantic label.
  final String? semanticLabel;

  /// Material configuration.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: AdaptiveButtonStyle.tonal,
      enabled: enabled,
      platform: platform,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      minimumSize: minimumSize,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      semanticLabel: semanticLabel,
      material: material,
      cupertino: cupertino,
      label: label,
      icon: icon,
      child: child,
    );
  }
}

/// Platform-adaptive outlined button with visible border.
class AdaptiveOutlinedButton extends StatelessWidget {
  /// Creates an [AdaptiveOutlinedButton].
  const AdaptiveOutlinedButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.platform,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.minimumSize,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.material,
    this.cupertino,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Action when long pressed.
  final VoidCallback? onLongPress;

  /// Custom child widget.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// Background color.
  final Color? backgroundColor;

  /// Text / border color.
  final Color? foregroundColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Minimum dimensions.
  final Size? minimumSize;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Tooltip message.
  final String? tooltip;

  /// Semantic label.
  final String? semanticLabel;

  /// Material configuration.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: AdaptiveButtonStyle.outlined,
      enabled: enabled,
      platform: platform,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      minimumSize: minimumSize,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      semanticLabel: semanticLabel,
      material: material,
      cupertino: cupertino,
      label: label,
      icon: icon,
      child: child,
    );
  }
}

/// Platform-adaptive text button without border or background.
class AdaptiveTextButton extends StatelessWidget {
  /// Creates an [AdaptiveTextButton].
  const AdaptiveTextButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.enabled = true,
    this.platform,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.minimumSize,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.semanticLabel,
    this.material,
    this.cupertino,
  });

  /// Action when tapped.
  final VoidCallback? onPressed;

  /// Action when long pressed.
  final VoidCallback? onLongPress;

  /// Custom child widget.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether enabled.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// Background color.
  final Color? backgroundColor;

  /// Text color.
  final Color? foregroundColor;

  /// Corner radius.
  final BorderRadius? borderRadius;

  /// Minimum dimensions.
  final Size? minimumSize;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Tooltip message.
  final String? tooltip;

  /// Semantic label.
  final String? semanticLabel;

  /// Material configuration.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: AdaptiveButtonStyle.text,
      enabled: enabled,
      platform: platform,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      minimumSize: minimumSize,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      semanticLabel: semanticLabel,
      material: material,
      cupertino: cupertino,
      label: label,
      icon: icon,
      child: child,
    );
  }
}
