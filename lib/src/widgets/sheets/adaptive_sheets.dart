import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// An action item for bottom action sheets.
class AdaptiveSheetAction<T> {
  /// Creates an [AdaptiveSheetAction].
  const AdaptiveSheetAction({
    this.title,
    this.child,
    this.icon,
    this.value,
    this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  }) : assert(title != null || child != null, 'Title or child must be provided');

  /// Action title text.
  final String? title;

  /// Custom child widget.
  final Widget? child;

  /// Optional leading icon.
  final Widget? icon;

  /// Result value returned when selected.
  final T? value;

  /// Custom callback.
  final VoidCallback? onPressed;

  /// Whether this is a destructive action.
  final bool isDestructive;

  /// Whether this is the primary default action.
  final bool isDefault;
}

/// Platform-adaptive bottom action sheet component and service.
abstract final class AdaptiveActionSheet {
  /// Presents an adaptive action sheet modal popup.
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? message,
    String? titleText,
    String? messageText,
    required List<AdaptiveSheetAction<T>> actions,
    AdaptiveSheetAction<T>? cancelAction,
    String cancelText = 'Cancel',
    AdaptivePlatform? platform,
  }) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget? effectiveTitle = title ?? (titleText != null ? Text(titleText) : null);
    final Widget? effectiveMessage = message ?? (messageText != null ? Text(messageText) : null);

    if (isCupertino) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext sheetContext) {
          return CupertinoActionSheet(
            title: effectiveTitle,
            message: effectiveMessage,
            actions: actions.map((AdaptiveSheetAction<T> action) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  if (action.onPressed != null) {
                    action.onPressed!();
                  } else {
                    Navigator.of(sheetContext).pop(action.value);
                  }
                },
                isDestructiveAction: action.isDestructive,
                isDefaultAction: action.isDefault,
                child: action.child ??
                    (action.icon != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              action.icon!,
                              const SizedBox(width: 8),
                              Text(action.title!),
                            ],
                          )
                        : Text(action.title!)),
              );
            }).toList(),
            cancelButton: cancelAction != null
                ? CupertinoActionSheetAction(
                    onPressed: () {
                      if (cancelAction.onPressed != null) {
                        cancelAction.onPressed!();
                      } else {
                        Navigator.of(sheetContext).pop(cancelAction.value);
                      }
                    },
                    isDefaultAction: cancelAction.isDefault,
                    child: cancelAction.child ?? Text(cancelAction.title ?? cancelText),
                  )
                : CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    child: Text(cancelText),
                  ),
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (effectiveTitle != null || effectiveMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    children: <Widget>[
                      if (effectiveTitle != null)
                        DefaultTextStyle(
                          style: Theme.of(sheetContext).textTheme.titleMedium!,
                          child: effectiveTitle,
                        ),
                      if (effectiveMessage != null)
                        DefaultTextStyle(
                          style: Theme.of(sheetContext).textTheme.bodySmall!,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: effectiveMessage,
                          ),
                        ),
                    ],
                  ),
                ),
              const Divider(height: 1),
              ...actions.map((AdaptiveSheetAction<T> action) {
                final Color? color = action.isDestructive ? Theme.of(sheetContext).colorScheme.error : null;
                return ListTile(
                  leading: action.icon,
                  title: action.child ??
                      Text(
                        action.title!,
                        style: TextStyle(color: color, fontWeight: action.isDefault ? FontWeight.bold : null),
                      ),
                  onTap: () {
                    if (action.onPressed != null) {
                      action.onPressed!();
                    } else {
                      Navigator.of(sheetContext).pop(action.value);
                    }
                  },
                );
              }),
              ListTile(
                title: Text(cancelAction?.title ?? cancelText, textAlign: TextAlign.center),
                onTap: () {
                  if (cancelAction?.onPressed != null) {
                    cancelAction!.onPressed!();
                  } else {
                    Navigator.of(sheetContext).pop(cancelAction?.value);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Platform-adaptive general modal bottom sheet service.
abstract final class AdaptiveBottomSheet {
  /// Displays a platform-appropriate modal bottom sheet.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    AdaptivePlatform? platform,
  }) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return showCupertinoModalPopup<T>(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext sheetContext) {
          return CupertinoPopupSurface(
            isSurfacePainted: true,
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(top: false, child: builder(sheetContext)),
            ),
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext sheetContext) => SafeArea(child: builder(sheetContext)),
    );
  }
}
