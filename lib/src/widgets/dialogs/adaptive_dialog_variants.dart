import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import 'adaptive_dialog.dart';

/// Pre-configured platform-adaptive confirmation dialog.
class AdaptiveConfirmDialog extends StatelessWidget {
  /// Creates an [AdaptiveConfirmDialog].
  const AdaptiveConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.isDestructive = false,
    this.onConfirm,
    this.onCancel,
    this.platform,
  });

  /// Title text.
  final String title;

  /// Content message.
  final String message;

  /// Confirm button label.
  final String confirmText;

  /// Cancel button label.
  final String cancelText;

  /// Whether the confirmation is destructive.
  final bool isDestructive;

  /// Callback when confirmed.
  final VoidCallback? onConfirm;

  /// Callback when cancelled.
  final VoidCallback? onCancel;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    return AdaptiveAlertDialog(
      platform: platform,
      title: Text(title),
      content: Text(message),
      actions: <AdaptiveDialogAction<bool>>[
        AdaptiveDialogAction<bool>(
          title: cancelText,
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              Navigator.of(context).pop(false);
            }
          },
        ),
        AdaptiveDialogAction<bool>(
          title: confirmText,
          isDefaultAction: !isDestructive,
          isDestructiveAction: isDestructive,
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!();
            } else {
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
    );
  }
}

/// Pre-configured platform-adaptive input prompt dialog.
class AdaptiveInputDialog extends StatefulWidget {
  /// Creates an [AdaptiveInputDialog].
  const AdaptiveInputDialog({
    super.key,
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onSubmitted,
    this.platform,
  });

  /// Dialog title.
  final String title;

  /// Optional descriptive message.
  final String? message;

  /// Input placeholder.
  final String placeholder;

  /// Initial input value.
  final String? initialValue;

  /// Confirm button text.
  final String confirmText;

  /// Cancel button text.
  final String cancelText;

  /// Callback with submitted text.
  final ValueChanged<String>? onSubmitted;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  State<AdaptiveInputDialog> createState() => _AdaptiveInputDialogState();
}

class _AdaptiveInputDialogState extends State<AdaptiveInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: widget.platform);

    final Widget inputField = isCupertino
        ? CupertinoTextField(
            controller: _controller,
            placeholder: widget.placeholder,
            autofocus: true,
          )
        : TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: widget.placeholder),
            autofocus: true,
          );

    return AdaptiveAlertDialog(
      platform: widget.platform,
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(widget.message!),
            ),
          inputField,
        ],
      ),
      actions: <AdaptiveDialogAction<String>>[
        AdaptiveDialogAction<String>(
          title: widget.cancelText,
          onPressed: () => Navigator.of(context).pop(),
        ),
        AdaptiveDialogAction<String>(
          title: widget.confirmText,
          isDefaultAction: true,
          onPressed: () {
            widget.onSubmitted?.call(_controller.text);
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}

/// Generic platform-adaptive modal custom dialog container.
class AdaptiveCustomDialog extends StatelessWidget {
  /// Creates an [AdaptiveCustomDialog].
  const AdaptiveCustomDialog({
    super.key,
    required this.child,
    this.platform,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  });

  /// Content inside the dialog.
  final Widget child;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Inset padding.
  final EdgeInsets insetPadding;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return Center(
        child: Container(
          margin: insetPadding,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: child,
          ),
        ),
      );
    }

    return Dialog(
      insetPadding: insetPadding,
      child: child,
    );
  }
}
