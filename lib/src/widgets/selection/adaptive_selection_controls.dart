import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive checkbox widget.
///
/// Uses [CupertinoCheckbox] on iOS and Material [Checkbox] on other platforms.
class AdaptiveCheckbox extends StatelessWidget {
  /// Creates an [AdaptiveCheckbox].
  const AdaptiveCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.focusNode,
    this.autofocus = false,
    this.platform,
    this.semanticLabel,
  });

  /// Checkbox value.
  final bool? value;

  /// Value changed callback.
  final ValueChanged<bool?>? onChanged;

  /// Whether null is a valid third state.
  final bool tristate;

  /// Active state fill color.
  final Color? activeColor;

  /// Checkmark color.
  final Color? checkColor;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    Widget widget;
    if (isCupertino) {
      widget = CupertinoCheckbox(
        value: value,
        tristate: tristate,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    } else {
      widget = Checkbox(
        value: value,
        tristate: tristate,
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    }

    if (semanticLabel != null && semanticLabel!.isNotEmpty) {
      widget = Semantics(label: semanticLabel, child: widget);
    }

    return widget;
  }
}

/// Platform-adaptive checkbox embedded in a list tile.
class AdaptiveCheckboxListTile extends StatelessWidget {
  /// Creates an [AdaptiveCheckboxListTile].
  const AdaptiveCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.platform,
  });

  /// Checkbox value.
  final bool? value;

  /// Changed callback.
  final ValueChanged<bool?>? onChanged;

  /// Title widget.
  final Widget? title;

  /// Subtitle widget.
  final Widget? subtitle;

  /// Secondary widget (leading icon).
  final Widget? secondary;

  /// Tristate flag.
  final bool tristate;

  /// Active color.
  final Color? activeColor;

  /// Checkmark color.
  final Color? checkColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoListTile(
        leading: secondary,
        title: title ?? const SizedBox.shrink(),
        subtitle: subtitle,
        trailing: CupertinoCheckbox(
          value: value,
          tristate: tristate,
          onChanged: onChanged,
          activeColor: activeColor,
          checkColor: checkColor,
        ),
        onTap: onChanged != null
            ? () {
                if (tristate) {
                  if (value == null) {
                    onChanged!(true);
                  } else if (value == true) {
                    onChanged!(false);
                  } else {
                    onChanged!(null);
                  }
                } else {
                  onChanged!(!(value ?? false));
                }
              }
            : null,
      );
    }

    return CheckboxListTile(
      value: value,
      tristate: tristate,
      onChanged: onChanged,
      title: title,
      subtitle: subtitle,
      secondary: secondary,
      activeColor: activeColor,
      checkColor: checkColor,
    );
  }
}

/// Platform-adaptive radio button.
class AdaptiveRadio<T> extends StatelessWidget {
  /// Creates an [AdaptiveRadio].
  const AdaptiveRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.focusNode,
    this.autofocus = false,
    this.platform,
    this.semanticLabel,
  });

  /// Value represented by this radio.
  final T value;

  /// Currently selected group value.
  final T? groupValue;

  /// Changed callback.
  final ValueChanged<T?>? onChanged;

  /// Active selection color.
  final Color? activeColor;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    Widget widget;
    if (isCupertino) {
      widget = CupertinoRadio<T>(
        value: value,
        // ignore: deprecated_member_use
        groupValue: groupValue,
        // ignore: deprecated_member_use
        onChanged: onChanged,
        activeColor: activeColor,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    } else {
      widget = Radio<T>(
        value: value,
        // ignore: deprecated_member_use
        groupValue: groupValue,
        // ignore: deprecated_member_use
        onChanged: onChanged,
        // ignore: deprecated_member_use
        activeColor: activeColor,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    }

    if (semanticLabel != null && semanticLabel!.isNotEmpty) {
      widget = Semantics(label: semanticLabel, child: widget);
    }

    return widget;
  }
}

/// Platform-adaptive radio embedded in a list tile.
class AdaptiveRadioListTile<T> extends StatelessWidget {
  /// Creates an [AdaptiveRadioListTile].
  const AdaptiveRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.platform,
  });

  /// The value of this item.
  final T value;

  /// Currently selected group value.
  final T? groupValue;

  /// Selection callback.
  final ValueChanged<T?>? onChanged;

  /// Title widget.
  final Widget? title;

  /// Subtitle widget.
  final Widget? subtitle;

  /// Secondary leading widget.
  final Widget? secondary;

  /// Active color.
  final Color? activeColor;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoListTile(
        leading: secondary,
        title: title ?? const SizedBox.shrink(),
        subtitle: subtitle,
        trailing: CupertinoRadio<T>(
          value: value,
          // ignore: deprecated_member_use
          groupValue: groupValue,
          // ignore: deprecated_member_use
          onChanged: onChanged,
          activeColor: activeColor,
        ),
        onTap: onChanged != null ? () => onChanged!(value) : null,
      );
    }

    return RadioListTile<T>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // ignore: deprecated_member_use
      onChanged: onChanged,
      title: title,
      subtitle: subtitle,
      secondary: secondary,
      // ignore: deprecated_member_use
      activeColor: activeColor,
    );
  }
}

/// Platform-adaptive switch toggle.
class AdaptiveSwitch extends StatelessWidget {
  /// Creates an [AdaptiveSwitch].
  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
    this.focusNode,
    this.autofocus = false,
    this.platform,
    this.semanticLabel,
  });

  /// Whether the switch is on.
  final bool value;

  /// Changed callback.
  final ValueChanged<bool>? onChanged;

  /// Color when active/on.
  final Color? activeColor;

  /// Background track color.
  final Color? trackColor;

  /// Thumb slider color.
  final Color? thumbColor;

  /// Focus node.
  final FocusNode? focusNode;

  /// Autofocus flag.
  final bool autofocus;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Accessibility semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    Widget widget;
    if (isCupertino) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        inactiveTrackColor: trackColor,
        thumbColor: thumbColor,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    } else {
      widget = Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        inactiveTrackColor: trackColor,
        thumbColor: thumbColor != null ? WidgetStatePropertyAll<Color>(thumbColor!) : null,
        focusNode: focusNode,
        autofocus: autofocus,
      );
    }

    if (semanticLabel != null && semanticLabel!.isNotEmpty) {
      widget = Semantics(label: semanticLabel, child: widget);
    }

    return widget;
  }
}

/// Platform-adaptive switch embedded in a list tile.
class AdaptiveSwitchListTile extends StatelessWidget {
  /// Creates an [AdaptiveSwitchListTile].
  const AdaptiveSwitchListTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.platform,
  });

  /// Switch value.
  final bool value;

  /// Changed callback.
  final ValueChanged<bool>? onChanged;

  /// Title widget.
  final Widget? title;

  /// Subtitle widget.
  final Widget? subtitle;

  /// Secondary leading widget.
  final Widget? secondary;

  /// Active color.
  final Color? activeColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoListTile(
        leading: secondary,
        title: title ?? const SizedBox.shrink(),
        subtitle: subtitle,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: activeColor,
        ),
        onTap: onChanged != null ? () => onChanged!(!value) : null,
      );
    }

    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: title,
      subtitle: subtitle,
      secondary: secondary,
      // ignore: deprecated_member_use
      activeColor: activeColor,
    );
  }
}
