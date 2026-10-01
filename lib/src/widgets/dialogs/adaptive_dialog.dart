import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// An action item button within an adaptive dialog.
class AdaptiveDialogAction<T> {
  /// Creates an [AdaptiveDialogAction].
  const AdaptiveDialogAction({
    this.title,
    this.child,
    this.onPressed,
    this.value,
    this.isDestructiveAction = false,
    this.isDefaultAction = false,
  }) : assert(title != null || child != null, 'Either title or child must be provided.');

  /// Text title for the button.
  final String? title;

  /// Custom child widget.
  final Widget? child;

  /// Custom callback. If omitted, tapping pops the dialog returning [value].
  final VoidCallback? onPressed;

  /// Result value returned when tapped.
  final T? value;

  /// Whether this represents a destructive action (renders in red).
  final bool isDestructiveAction;

  /// Whether this is the default prominent action (e.g. bolded on iOS).
  final bool isDefaultAction;
}

/// A platform-adaptive dialog providing both declarative widgets and static presentation helpers.
abstract final class AdaptiveDialog {
  /// Shows a platform-adaptive dialog, resolving to [CupertinoAlertDialog] on iOS
  /// and Material [AlertDialog] on Android/Web/Desktop.
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    String? titleText,
    String? contentText,
    List<AdaptiveDialogAction<T>> actions = const <AdaptiveDialogAction<Never>>[],
    bool barrierDismissible = true,
    Color? barrierColor,
    AdaptivePlatform? platform,
    RouteSettings? routeSettings,
  }) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget effectiveTitle = title ?? (titleText != null ? Text(titleText) : const SizedBox.shrink());
    final Widget? effectiveContent = content ?? (contentText != null ? Text(contentText) : null);

    if (isCupertino) {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        routeSettings: routeSettings,
        builder: (BuildContext dialogContext) {
          return CupertinoAlertDialog(
            title: title != null || titleText != null ? effectiveTitle : null,
            content: effectiveContent,
            actions: actions.map((AdaptiveDialogAction<T> action) {
              return CupertinoDialogAction(
                onPressed: () {
                  if (action.onPressed != null) {
                    action.onPressed!();
                  } else {
                    Navigator.of(dialogContext).pop(action.value);
                  }
                },
                isDestructiveAction: action.isDestructiveAction,
                isDefaultAction: action.isDefaultAction,
                child: action.child ?? Text(action.title!),
              );
            }).toList(),
          );
        },
      );
    }

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      routeSettings: routeSettings,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: title != null || titleText != null ? effectiveTitle : null,
          content: effectiveContent,
          actions: actions.map((AdaptiveDialogAction<T> action) {
            final Color? textColor = action.isDestructiveAction ? Theme.of(dialogContext).colorScheme.error : null;
            return TextButton(
              onPressed: () {
                if (action.onPressed != null) {
                  action.onPressed!();
                } else {
                  Navigator.of(dialogContext).pop(action.value);
                }
              },
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: textColor,
                  fontWeight: action.isDefaultAction ? FontWeight.bold : FontWeight.normal,
                ),
                child: action.child ?? Text(action.title!),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// Shows an adaptive confirmation dialog with 'Cancel' and 'Confirm' actions.
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    AdaptivePlatform? platform,
  }) async {
    final bool? result = await show<bool>(
      context: context,
      titleText: title,
      contentText: message,
      platform: platform,
      actions: <AdaptiveDialogAction<bool>>[
        AdaptiveDialogAction<bool>(
          title: cancelText,
          value: false,
        ),
        AdaptiveDialogAction<bool>(
          title: confirmText,
          value: true,
          isDefaultAction: !isDestructive,
          isDestructiveAction: isDestructive,
        ),
      ],
    );
    return result ?? false;
  }

  /// Shows an adaptive informational alert dialog with an OK button.
  static Future<void> info({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    AdaptivePlatform? platform,
  }) {
    return show<void>(
      context: context,
      titleText: title,
      contentText: message,
      platform: platform,
      actions: <AdaptiveDialogAction<void>>[
        AdaptiveDialogAction<void>(
          title: buttonText,
          isDefaultAction: true,
        ),
      ],
    );
  }

  /// Shows an adaptive error alert dialog.
  static Future<void> error({
    required BuildContext context,
    String title = 'Error',
    required String message,
    String buttonText = 'OK',
    AdaptivePlatform? platform,
  }) {
    return show<void>(
      context: context,
      titleText: title,
      contentText: message,
      platform: platform,
      actions: <AdaptiveDialogAction<void>>[
        AdaptiveDialogAction<void>(
          title: buttonText,
          isDestructiveAction: true,
          isDefaultAction: true,
        ),
      ],
    );
  }

  /// Shows an adaptive success alert dialog.
  static Future<void> success({
    required BuildContext context,
    String title = 'Success',
    required String message,
    String buttonText = 'OK',
    AdaptivePlatform? platform,
  }) {
    return show<void>(
      context: context,
      titleText: title,
      contentText: message,
      platform: platform,
      actions: <AdaptiveDialogAction<void>>[
        AdaptiveDialogAction<void>(
          title: buttonText,
          isDefaultAction: true,
        ),
      ],
    );
  }

  /// Shows an adaptive prompt dialog prompting the user for text input.
  static Future<String?> prompt({
    required BuildContext context,
    required String title,
    String? message,
    String? initialValue,
    String placeholder = '',
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    AdaptivePlatform? platform,
  }) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    return show<String>(
      context: context,
      titleText: title,
      platform: platform,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(message),
            ),
          CupertinoTextField(
            controller: controller,
            placeholder: placeholder,
            autofocus: true,
          ),
        ],
      ),
      actions: <AdaptiveDialogAction<String>>[
        AdaptiveDialogAction<String>(
          title: cancelText,
          value: null,
        ),
        AdaptiveDialogAction<String>(
          title: confirmText,
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(controller.text),
        ),
      ],
    );
  }
}

/// Platform-adaptive alert dialog widget.
class AdaptiveAlertDialog extends StatelessWidget {
  /// Creates an [AdaptiveAlertDialog].
  const AdaptiveAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions = const <AdaptiveDialogAction<dynamic>>[],
    this.platform,
  });

  /// Title widget.
  final Widget? title;

  /// Content widget.
  final Widget? content;

  /// List of actions.
  final List<AdaptiveDialogAction<dynamic>> actions;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions.map((AdaptiveDialogAction<dynamic> action) {
          return CupertinoDialogAction(
            onPressed: () {
              if (action.onPressed != null) {
                action.onPressed!();
              } else {
                Navigator.of(context).pop(action.value);
              }
            },
            isDestructiveAction: action.isDestructiveAction,
            isDefaultAction: action.isDefaultAction,
            child: action.child ?? Text(action.title ?? ''),
          );
        }).toList(),
      );
    }

    return AlertDialog(
      title: title,
      content: content,
      actions: actions.map((AdaptiveDialogAction<dynamic> action) {
        return TextButton(
          onPressed: () {
            if (action.onPressed != null) {
              action.onPressed!();
            } else {
              Navigator.of(context).pop(action.value);
            }
          },
          child: action.child ?? Text(action.title ?? ''),
        );
      }).toList(),
    );
  }
}
