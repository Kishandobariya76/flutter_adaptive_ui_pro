import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import '../../theme/adaptive_component_theme.dart';

/// Style variants supported by [AdaptiveButton].
enum AdaptiveButtonStyle {
  /// Filled prominent button (Material FilledButton / Cupertino filled button).
  filled,

  /// Elevated button with shadow (Material ElevatedButton).
  elevated,

  /// Tonal button with subtle background (Material FilledButton.tonal).
  tonal,

  /// Outlined button with visible border (Material OutlinedButton).
  outlined,

  /// Plain borderless text button (Material TextButton / Cupertino plain button).
  text,
}

/// A platform-adaptive button that automatically renders Material on Android/Desktop/Web
/// and Cupertino on iOS, while respecting widget and tree-level overrides.
class AdaptiveButton extends StatelessWidget {
  /// Creates a standard [AdaptiveButton].
  const AdaptiveButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.child,
    this.label,
    this.icon,
    this.style = AdaptiveButtonStyle.filled,
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
  }) : assert(
          child != null || label != null || icon != null,
          'At least one of child, label, or icon must be provided.',
        );

  /// Creates a filled [AdaptiveButton].
  const AdaptiveButton.filled({
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
  }) : style = AdaptiveButtonStyle.filled;

  /// Creates an elevated [AdaptiveButton].
  const AdaptiveButton.elevated({
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
  }) : style = AdaptiveButtonStyle.elevated;

  /// Creates a tonal [AdaptiveButton].
  const AdaptiveButton.tonal({
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
  }) : style = AdaptiveButtonStyle.tonal;

  /// Creates an outlined [AdaptiveButton].
  const AdaptiveButton.outlined({
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
  }) : style = AdaptiveButtonStyle.outlined;

  /// Creates a borderless text [AdaptiveButton].
  const AdaptiveButton.text({
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
  }) : style = AdaptiveButtonStyle.text;

  /// Callback executed when button is pressed.
  final VoidCallback? onPressed;

  /// Callback executed when button is long pressed.
  final VoidCallback? onLongPress;

  /// Primary child widget inside button.
  final Widget? child;

  /// Text label string.
  final String? label;

  /// Optional icon widget.
  final Widget? icon;

  /// Button styling mode.
  final AdaptiveButtonStyle style;

  /// Whether the button is interactive.
  final bool enabled;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Padding around button content.
  final EdgeInsetsGeometry? padding;

  /// Button background color.
  final Color? backgroundColor;

  /// Button foreground / text color.
  final Color? foregroundColor;

  /// Border radius of button corners.
  final BorderRadius? borderRadius;

  /// Minimum dimensions.
  final Size? minimumSize;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether to autofocus.
  final bool autofocus;

  /// Optional tooltip message.
  final String? tooltip;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Material-specific configurations.
  final AdaptiveMaterialButtonConfig? material;

  /// Cupertino-specific configurations.
  final AdaptiveCupertinoButtonConfig? cupertino;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);
    final VoidCallback? effectiveOnPressed = enabled ? onPressed : null;

    Widget buttonWidget = isCupertino
        ? _buildCupertinoButton(context, effectiveOnPressed)
        : _buildMaterialButton(context, effectiveOnPressed);

    if (tooltip != null && tooltip!.isNotEmpty) {
      buttonWidget = Tooltip(message: tooltip!, child: buttonWidget);
    }

    if (semanticLabel != null && semanticLabel!.isNotEmpty) {
      buttonWidget = Semantics(
        label: semanticLabel,
        button: true,
        enabled: enabled,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }

  Widget _buildContent(BuildContext context, {Color? defaultTextColor}) {
    if (child != null) return child!;
    if (icon != null && label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon!,
          const SizedBox(width: 8),
          Text(label!, style: TextStyle(color: defaultTextColor)),
        ],
      );
    }
    if (icon != null) return icon!;
    return Text(label!, style: TextStyle(color: defaultTextColor));
  }

  Widget _buildMaterialButton(BuildContext context, VoidCallback? effectiveOnPressed) {
    final Widget content = _buildContent(context, defaultTextColor: foregroundColor);
    final ButtonStyle buttonStyle = ButtonStyle(
      padding: padding != null ? WidgetStatePropertyAll<EdgeInsetsGeometry>(padding!) : null,
      backgroundColor: backgroundColor != null ? WidgetStatePropertyAll<Color>(backgroundColor!) : null,
      foregroundColor: foregroundColor != null ? WidgetStatePropertyAll<Color>(foregroundColor!) : null,
      minimumSize: minimumSize != null ? WidgetStatePropertyAll<Size>(minimumSize!) : null,
      elevation: material?.elevation != null ? WidgetStatePropertyAll<double>(material!.elevation!) : null,
      shadowColor: material?.shadowColor != null ? WidgetStatePropertyAll<Color>(material!.shadowColor!) : null,
      splashFactory: material?.splashFactory,
      visualDensity: material?.visualDensity,
      tapTargetSize: material?.tapTargetSize,
      shape: borderRadius != null
          ? WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: borderRadius!),
            )
          : null,
    );

    switch (style) {
      case AdaptiveButtonStyle.filled:
        return FilledButton(
          onPressed: effectiveOnPressed,
          onLongPress: onLongPress,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          child: content,
        );
      case AdaptiveButtonStyle.elevated:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          onLongPress: onLongPress,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          child: content,
        );
      case AdaptiveButtonStyle.tonal:
        return FilledButton.tonal(
          onPressed: effectiveOnPressed,
          onLongPress: onLongPress,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          child: content,
        );
      case AdaptiveButtonStyle.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          onLongPress: onLongPress,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          child: content,
        );
      case AdaptiveButtonStyle.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          onLongPress: onLongPress,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          child: content,
        );
    }
  }

  Widget _buildCupertinoButton(BuildContext context, VoidCallback? effectiveOnPressed) {
    final BorderRadius effectiveRadius =
        borderRadius ?? cupertino?.borderRadius ?? const BorderRadius.all(Radius.circular(8));
    final double pressedOpacity = cupertino?.pressedOpacity ?? 0.4;
    final AlignmentGeometry alignment = cupertino?.alignment ?? Alignment.center;
    final Size effectiveMinSize = minimumSize ?? const Size.square(kMinInteractiveDimensionCupertino);

    if (style == AdaptiveButtonStyle.filled) {
      return CupertinoButton.filled(
        onPressed: effectiveOnPressed,
        padding: padding,
        borderRadius: effectiveRadius,
        pressedOpacity: pressedOpacity,
        minimumSize: effectiveMinSize,
        alignment: alignment,
        focusNode: focusNode,
        autofocus: autofocus,
        child: _buildContent(context, defaultTextColor: foregroundColor ?? CupertinoColors.white),
      );
    }

    if (style == AdaptiveButtonStyle.outlined) {
      final Color borderColor = foregroundColor ?? CupertinoTheme.of(context).primaryColor;
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: enabled ? borderColor : CupertinoColors.inactiveGray),
          borderRadius: effectiveRadius,
          color: backgroundColor,
        ),
        child: CupertinoButton(
          onPressed: effectiveOnPressed,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: effectiveRadius,
          pressedOpacity: pressedOpacity,
          minimumSize: effectiveMinSize,
          alignment: alignment,
          focusNode: focusNode,
          autofocus: autofocus,
          child: _buildContent(context, defaultTextColor: borderColor),
        ),
      );
    }

    if (style == AdaptiveButtonStyle.tonal) {
      final Color bg = backgroundColor ?? CupertinoColors.systemGrey5.resolveFrom(context);
      final Color fg = foregroundColor ?? CupertinoTheme.of(context).primaryColor;
      return CupertinoButton(
        onPressed: effectiveOnPressed,
        color: bg,
        padding: padding,
        borderRadius: effectiveRadius,
        pressedOpacity: pressedOpacity,
        minimumSize: effectiveMinSize,
        alignment: alignment,
        focusNode: focusNode,
        autofocus: autofocus,
        child: _buildContent(context, defaultTextColor: fg),
      );
    }

    return CupertinoButton(
      onPressed: effectiveOnPressed,
      color: backgroundColor,
      padding: padding,
      borderRadius: effectiveRadius,
      pressedOpacity: pressedOpacity,
      minimumSize: effectiveMinSize,
      alignment: alignment,
      focusNode: focusNode,
      autofocus: autofocus,
      child: _buildContent(context, defaultTextColor: foregroundColor),
    );
  }
}
