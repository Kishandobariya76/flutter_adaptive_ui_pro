import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform-specific configuration for Material buttons.
class AdaptiveMaterialButtonConfig {
  /// Creates an [AdaptiveMaterialButtonConfig].
  const AdaptiveMaterialButtonConfig({
    this.elevation,
    this.shadowColor,
    this.splashFactory,
    this.visualDensity,
    this.tapTargetSize,
  });

  /// Custom elevation.
  final double? elevation;

  /// Custom shadow color.
  final Color? shadowColor;

  /// Custom splash factory for ink ripples.
  final InteractiveInkFeatureFactory? splashFactory;

  /// Visual density adjustment.
  final VisualDensity? visualDensity;

  /// Material tap target size.
  final MaterialTapTargetSize? tapTargetSize;
}

/// Platform-specific configuration for Cupertino buttons.
class AdaptiveCupertinoButtonConfig {
  /// Creates an [AdaptiveCupertinoButtonConfig].
  const AdaptiveCupertinoButtonConfig({
    this.pressedOpacity = 0.4,
    this.borderRadius,
    this.alignment = Alignment.center,
  });

  /// Opacity applied to the button when pressed.
  final double pressedOpacity;

  /// Explicit border radius.
  final BorderRadius? borderRadius;

  /// Alignment of child content.
  final AlignmentGeometry alignment;
}

/// Platform-specific configuration for Material text inputs.
class AdaptiveMaterialTextFieldConfig {
  /// Creates an [AdaptiveMaterialTextFieldConfig].
  const AdaptiveMaterialTextFieldConfig({
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.fillColor,
    this.filled,
  });

  /// Base input border.
  final InputBorder? border;

  /// Enabled state border.
  final InputBorder? enabledBorder;

  /// Focused state border.
  final InputBorder? focusedBorder;

  /// Error state border.
  final InputBorder? errorBorder;

  /// Custom fill background color.
  final Color? fillColor;

  /// Whether the input field is filled.
  final bool? filled;
}

/// Platform-specific configuration for Cupertino text inputs.
class AdaptiveCupertinoTextFieldConfig {
  /// Creates an [AdaptiveCupertinoTextFieldConfig].
  const AdaptiveCupertinoTextFieldConfig({
    this.placeholderStyle,
    this.clearButtonMode = OverlayVisibilityMode.never,
    this.decoration,
    this.padding,
  });

  /// Style for Cupertino placeholder.
  final TextStyle? placeholderStyle;

  /// Overlay visibility mode for clear button.
  final OverlayVisibilityMode clearButtonMode;

  /// Custom box decoration.
  final BoxDecoration? decoration;

  /// Custom internal padding.
  final EdgeInsetsGeometry? padding;
}
