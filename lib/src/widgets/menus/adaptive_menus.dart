import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import '../pickers/adaptive_pickers.dart';

/// An entry item for adaptive dropdowns and menus.
class AdaptiveMenuItem<T> {
  /// Creates an [AdaptiveMenuItem].
  const AdaptiveMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  /// The associated value.
  final T value;

  /// Display text label.
  final String label;

  /// Optional leading icon.
  final Widget? icon;

  /// Whether selectable.
  final bool enabled;
}

/// Platform-adaptive dropdown selector.
///
/// On Android, renders a Material [DropdownButton].
/// On iOS, renders an iOS button displaying the current choice and tapping triggers
/// an authentic modal [CupertinoPicker] sheet.
class AdaptiveDropdown<T> extends StatelessWidget {
  /// Creates an [AdaptiveDropdown].
  const AdaptiveDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint,
    this.icon,
    this.isExpanded = false,
    this.platform,
  });

  /// List of available choices.
  final List<AdaptiveMenuItem<T>> items;

  /// Currently selected value.
  final T? value;

  /// Callback when a new value is chosen.
  final ValueChanged<T?>? onChanged;

  /// Placeholder hint.
  final Widget? hint;

  /// Optional dropdown indicator icon.
  final Widget? icon;

  /// Whether to expand to fill available horizontal width.
  final bool isExpanded;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final AdaptiveMenuItem<T>? selectedItem =
          items.cast<AdaptiveMenuItem<T>?>().firstWhere((AdaptiveMenuItem<T>? i) => i?.value == value, orElse: () => null);

      final Widget labelWidget = selectedItem != null
          ? Text(selectedItem.label, style: TextStyle(color: CupertinoColors.label.resolveFrom(context)))
          : (hint ?? const Text('Select...'));

      return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        color: CupertinoColors.tertiarySystemFill.resolveFrom(context),
        borderRadius: BorderRadius.circular(8.0),
        onPressed: onChanged != null
            ? () async {
                final T? picked = await AdaptivePicker.show<T>(
                  context: context,
                  items: items.map((AdaptiveMenuItem<T> e) => e.value).toList(),
                  selectedItem: value,
                  itemBuilder: (T val) {
                    final AdaptiveMenuItem<T> item = items.firstWhere((AdaptiveMenuItem<T> i) => i.value == val);
                    return Text(item.label);
                  },
                );
                if (picked != null) {
                  onChanged!(picked);
                }
              }
            : null,
        child: Row(
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: labelWidget),
            icon ??
                const Icon(
                  CupertinoIcons.chevron_up_chevron_down,
                  size: 16,
                  color: CupertinoColors.secondaryLabel,
                ),
          ],
        ),
      );
    }

    return DropdownButton<T>(
      value: value,
      items: items.map((AdaptiveMenuItem<T> item) {
        return DropdownMenuItem<T>(
          value: item.value,
          enabled: item.enabled,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (item.icon != null) ...<Widget>[
                item.icon!,
                const SizedBox(width: 8),
              ],
              Text(item.label),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      hint: hint,
      icon: icon,
      isExpanded: isExpanded,
    );
  }
}

/// Convenience alias for [AdaptiveDropdown].
typedef AdaptiveDropdownButton<T> = AdaptiveDropdown<T>;

/// Platform-adaptive dropdown menu.
typedef AdaptiveDropdownMenu<T> = AdaptiveDropdown<T>;

/// Platform-adaptive popup menu button.
class AdaptivePopupMenu<T> extends StatelessWidget {
  /// Creates an [AdaptivePopupMenu].
  const AdaptivePopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.child,
    this.icon,
    this.tooltip,
    this.platform,
  });

  /// Menu items.
  final List<AdaptiveMenuItem<T>> items;

  /// Selection callback.
  final ValueChanged<T> onSelected;

  /// Custom anchor child.
  final Widget? child;

  /// Optional icon.
  final Widget? icon;

  /// Tooltip message.
  final String? tooltip;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          showCupertinoModalPopup<T>(
            context: context,
            builder: (BuildContext sheetContext) {
              return CupertinoActionSheet(
                actions: items.map((AdaptiveMenuItem<T> item) {
                  return CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(sheetContext).pop(item.value);
                      onSelected(item.value);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (item.icon != null) ...<Widget>[
                          item.icon!,
                          const SizedBox(width: 8),
                        ],
                        Text(item.label),
                      ],
                    ),
                  );
                }).toList(),
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: const Text('Cancel'),
                ),
              );
            },
          );
        },
        child: child ?? icon ?? const Icon(CupertinoIcons.ellipsis_circle),
      );
    }

    return PopupMenuButton<T>(
      tooltip: tooltip,
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((AdaptiveMenuItem<T> item) {
          return PopupMenuItem<T>(
            value: item.value,
            enabled: item.enabled,
            child: Row(
              children: <Widget>[
                if (item.icon != null) ...<Widget>[
                  item.icon!,
                  const SizedBox(width: 8),
                ],
                Text(item.label),
              ],
            ),
          );
        }).toList();
      },
      child: child,
    );
  }
}

/// Action item for adaptive context menus.
class AdaptiveContextAction {
  /// Creates an [AdaptiveContextAction].
  const AdaptiveContextAction({
    required this.title,
    required this.onPressed,
    this.icon,
    this.isDestructive = false,
  });

  /// Action title text.
  final String title;

  /// Action callback.
  final VoidCallback onPressed;

  /// Optional icon.
  final Widget? icon;

  /// Whether destructive action.
  final bool isDestructive;
}

/// Platform-adaptive context menu widget.
///
/// On iOS, renders authentic [CupertinoContextMenu].
/// On Material, triggers popup menu on secondary click or long press.
class AdaptiveContextMenu extends StatelessWidget {
  /// Creates an [AdaptiveContextMenu].
  const AdaptiveContextMenu({
    super.key,
    required this.child,
    required this.actions,
    this.platform,
  });

  /// Child widget wrapped by context menu.
  final Widget child;

  /// Menu actions.
  final List<AdaptiveContextAction> actions;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoContextMenu(
        actions: actions.map((AdaptiveContextAction action) {
          return CupertinoContextMenuAction(
            onPressed: () {
              Navigator.of(context).pop();
              action.onPressed();
            },
            isDestructiveAction: action.isDestructive,
            trailingIcon: action.icon is Icon ? (action.icon as Icon).icon : null,
            child: Text(action.title),
          );
        }).toList(),
        child: child,
      );
    }

    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        final RelativeRect position = RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        );
        showMenu(
          context: context,
          position: position,
          items: actions.map((AdaptiveContextAction action) {
            return PopupMenuItem<VoidCallback>(
              value: action.onPressed,
              child: Row(
                children: <Widget>[
                  if (action.icon != null) ...<Widget>[
                    action.icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    action.title,
                    style: TextStyle(
                      color: action.isDestructive ? Theme.of(context).colorScheme.error : null,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ).then((VoidCallback? selectedAction) {
          selectedAction?.call();
        });
      },
      child: child,
    );
  }
}
