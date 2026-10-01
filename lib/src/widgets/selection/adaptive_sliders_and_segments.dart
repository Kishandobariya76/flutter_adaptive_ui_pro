import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive slider control.
class AdaptiveSlider extends StatelessWidget {
  /// Creates an [AdaptiveSlider].
  const AdaptiveSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.platform,
    this.semanticFormatterCallback,
  });

  /// Current value.
  final double value;

  /// Value change callback.
  final ValueChanged<double>? onChanged;

  /// Callback when user starts dragging.
  final ValueChanged<double>? onChangeStart;

  /// Callback when user finishes dragging.
  final ValueChanged<double>? onChangeEnd;

  /// Minimum value.
  final double min;

  /// Maximum value.
  final double max;

  /// Division count.
  final int? divisions;

  /// Value label popup.
  final String? label;

  /// Active track color.
  final Color? activeColor;

  /// Inactive track color.
  final Color? inactiveColor;

  /// Thumb color.
  final Color? thumbColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic formatter.
  final SemanticFormatterCallback? semanticFormatterCallback;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoSlider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        activeColor: activeColor,
        thumbColor: thumbColor ?? CupertinoColors.white,
        onChanged: onChanged,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
      );
    }

    return Slider(
      value: value.clamp(min, max),
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: thumbColor,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      semanticFormatterCallback: semanticFormatterCallback,
    );
  }
}

/// Platform-adaptive range slider.
class AdaptiveRangeSlider extends StatelessWidget {
  /// Creates an [AdaptiveRangeSlider].
  const AdaptiveRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.labels,
    this.activeColor,
    this.inactiveColor,
    this.platform,
  });

  /// Range values.
  final RangeValues values;

  /// Callback when range changes.
  final ValueChanged<RangeValues>? onChanged;

  /// Drag start callback.
  final ValueChanged<RangeValues>? onChangeStart;

  /// Drag end callback.
  final ValueChanged<RangeValues>? onChangeEnd;

  /// Minimum value.
  final double min;

  /// Maximum value.
  final double max;

  /// Divisions.
  final int? divisions;

  /// Labels for start/end.
  final RangeLabels? labels;

  /// Active track color.
  final Color? activeColor;

  /// Inactive track color.
  final Color? inactiveColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final Color effectiveActive = activeColor ?? CupertinoTheme.of(context).primaryColor;
      final Color effectiveInactive = inactiveColor ?? CupertinoColors.systemGrey4.resolveFrom(context);

      return CupertinoTheme(
        data: CupertinoThemeData(primaryColor: effectiveActive),
        child: Material(
          type: MaterialType.transparency,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: effectiveActive,
              inactiveTrackColor: effectiveInactive,
              thumbColor: CupertinoColors.white,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
              rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 14.0, elevation: 3.0),
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              divisions: divisions,
              labels: labels,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ),
      );
    }

    return RangeSlider(
      values: values,
      min: min,
      max: max,
      divisions: divisions,
      labels: labels,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
    );
  }
}

/// Platform-adaptive segmented control.
///
/// On iOS, renders [CupertinoSlidingSegmentedControl].
/// On Android, renders Material 3 [SegmentedButton].
class AdaptiveSegmentedControl<T extends Object> extends StatelessWidget {
  /// Creates an [AdaptiveSegmentedControl].
  const AdaptiveSegmentedControl({
    super.key,
    required this.children,
    required this.groupValue,
    required this.onValueChanged,
    this.backgroundColor,
    this.thumbColor,
    this.platform,
  });

  /// Map of value to label widget.
  final Map<T, Widget> children;

  /// Currently selected value.
  final T? groupValue;

  /// Changed callback.
  final ValueChanged<T?> onValueChanged;

  /// Background container color.
  final Color? backgroundColor;

  /// Thumb/indicator color.
  final Color? thumbColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoSlidingSegmentedControl<T>(
        children: children,
        groupValue: groupValue,
        onValueChanged: onValueChanged,
        backgroundColor: backgroundColor ?? CupertinoColors.tertiarySystemFill.resolveFrom(context),
        thumbColor: thumbColor ?? CupertinoColors.white,
      );
    }

    return SegmentedButton<T>(
      segments: children.entries.map((MapEntry<T, Widget> entry) {
        return ButtonSegment<T>(
          value: entry.key,
          label: entry.value,
        );
      }).toList(),
      selected: groupValue != null ? <T>{groupValue!} : <T>{},
      onSelectionChanged: (Set<T> newSelection) {
        if (newSelection.isNotEmpty) {
          onValueChanged(newSelection.first);
        }
      },
    );
  }
}
