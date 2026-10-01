import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import '../buttons/adaptive_button.dart';
import '../progress/adaptive_progress.dart';

/// Semantic types for snackbars and banners.
enum AdaptiveFeedbackType {
  /// Informational notice.
  info,

  /// Success message.
  success,

  /// Warning alert.
  warning,

  /// Error failure message.
  error,
}

/// Platform-adaptive snackbar notification service.
abstract final class AdaptiveSnackBar {
  /// Displays an adaptive transient notification.
  ///
  /// On Android, displays a Material [SnackBar] via [ScaffoldMessenger].
  /// On iOS, displays a top-anchored floating capsule banner with Cupertino styling.
  static void show(
    BuildContext context, {
    required String message,
    AdaptiveFeedbackType type = AdaptiveFeedbackType.info,
    String? action,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
    AdaptivePlatform? platform,
  }) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      _showCupertinoBanner(
        context,
        message: message,
        type: type,
        action: action,
        onActionPressed: onActionPressed,
        duration: duration,
      );
      return;
    }

    final Color bgColor;
    final IconData iconData;
    switch (type) {
      case AdaptiveFeedbackType.success:
        bgColor = Colors.green.shade800;
        iconData = Icons.check_circle_outline;
      case AdaptiveFeedbackType.warning:
        bgColor = Colors.orange.shade900;
        iconData = Icons.warning_amber_rounded;
      case AdaptiveFeedbackType.error:
        bgColor = Colors.red.shade900;
        iconData = Icons.error_outline;
      case AdaptiveFeedbackType.info:
        bgColor = const Color(0xFF323232);
        iconData = Icons.info_outline;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(iconData, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: bgColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        action: action != null
            ? SnackBarAction(
                label: action,
                textColor: Colors.white,
                onPressed: onActionPressed ?? () {},
              )
            : null,
      ),
    );
  }

  static void _showCupertinoBanner(
    BuildContext context, {
    required String message,
    required AdaptiveFeedbackType type,
    String? action,
    VoidCallback? onActionPressed,
    required Duration duration,
  }) {
    final OverlayState overlay = Overlay.of(context);
    late OverlayEntry entry;

    final IconData iconData;
    final Color iconColor;
    switch (type) {
      case AdaptiveFeedbackType.success:
        iconData = CupertinoIcons.check_mark_circled_solid;
        iconColor = CupertinoColors.systemGreen;
      case AdaptiveFeedbackType.warning:
        iconData = CupertinoIcons.exclamationmark_triangle_fill;
        iconColor = CupertinoColors.systemYellow;
      case AdaptiveFeedbackType.error:
        iconData = CupertinoIcons.xmark_circle_fill;
        iconColor = CupertinoColors.systemRed;
      case AdaptiveFeedbackType.info:
        iconData = CupertinoIcons.info_circle_fill;
        iconColor = CupertinoColors.systemBlue;
    }

    entry = OverlayEntry(
      builder: (BuildContext overlayContext) {
        return Positioned(
          top: MediaQuery.of(overlayContext).padding.top + 10,
          left: 16,
          right: 16,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: -50.0, end: 0.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            builder: (BuildContext ctx, double value, Widget? child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(overlayContext),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CupertinoColors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Icon(iconData, color: iconColor, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.label.resolveFrom(overlayContext),
                        ),
                      ),
                    ),
                    if (action != null)
                      CupertinoButton(
                        padding: const EdgeInsets.only(left: 8),
                        minimumSize: const Size.square(30),
                        onPressed: () {
                          entry.remove();
                          onActionPressed?.call();
                        },
                        child: Text(
                          action,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
    Future<void>.delayed(duration, () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}

/// Convenience toast helper.
abstract final class AdaptiveToast {
  /// Displays a brief toast message.
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    AdaptivePlatform? platform,
  }) {
    AdaptiveSnackBar.show(
      context,
      message: message,
      duration: duration,
      platform: platform,
    );
  }
}

/// Platform-adaptive banner notification widget.
class AdaptiveBanner extends StatelessWidget {
  /// Creates an [AdaptiveBanner].
  const AdaptiveBanner({
    super.key,
    required this.message,
    this.type = AdaptiveFeedbackType.info,
    this.actions = const <Widget>[],
    this.platform,
  });

  /// Banner text message.
  final String message;

  /// Semantic type.
  final AdaptiveFeedbackType type;

  /// Action widgets.
  final List<Widget> actions;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CupertinoColors.separator.resolveFrom(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(message, style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
            if (actions.isNotEmpty) ...<Widget>[
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
            ],
          ],
        ),
      );
    }

    return MaterialBanner(
      content: Text(message),
      actions: actions.isNotEmpty ? actions : <Widget>[const SizedBox.shrink()],
    );
  }
}

/// Platform-adaptive tooltip wrapper.
class AdaptiveTooltip extends StatelessWidget {
  /// Creates an [AdaptiveTooltip].
  const AdaptiveTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
  });

  /// Tooltip message.
  final String message;

  /// Child widget.
  final Widget child;

  /// Whether to prefer displaying below child.
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      child: child,
    );
  }
}

/// High-level platform-adaptive error state display.
class AdaptiveErrorView extends StatelessWidget {
  /// Creates an [AdaptiveErrorView].
  const AdaptiveErrorView({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.retryText = 'Try Again',
    this.platform,
  });

  /// Error title.
  final String title;

  /// Error message detail.
  final String message;

  /// Optional retry callback.
  final VoidCallback? onRetry;

  /// Retry button label.
  final String retryText;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget icon = Icon(
      isCupertino ? CupertinoIcons.exclamationmark_circle : Icons.error_outline,
      size: 64,
      color: isCupertino ? CupertinoColors.destructiveRed : Theme.of(context).colorScheme.error,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 20),
              AdaptiveButton(
                onPressed: onRetry,
                label: retryText,
                platform: platform,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// High-level platform-adaptive empty state display.
class AdaptiveEmptyState extends StatelessWidget {
  /// Creates an [AdaptiveEmptyState].
  const AdaptiveEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.action,
    this.platform,
  });

  /// Empty state title.
  final String title;

  /// Description message.
  final String message;

  /// Optional custom icon.
  final Widget? icon;

  /// Optional action widget.
  final Widget? action;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget effectiveIcon = icon ??
        Icon(
          isCupertino ? CupertinoIcons.tray : Icons.inbox_outlined,
          size: 64,
          color: CupertinoColors.placeholderText.resolveFrom(context),
        );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            effectiveIcon,
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (action != null) ...<Widget>[
              const SizedBox(height: 20),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// High-level platform-adaptive loading state view.
class AdaptiveLoadingView extends StatelessWidget {
  /// Creates an [AdaptiveLoadingView].
  const AdaptiveLoadingView({
    super.key,
    this.message = 'Loading...',
    this.platform,
  });

  /// Optional message displayed below loading indicator.
  final String? message;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AdaptiveCircularProgressIndicator(platform: platform),
          if (message != null) ...<Widget>[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
