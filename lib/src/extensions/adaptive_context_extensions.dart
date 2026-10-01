import 'package:flutter/widgets.dart';
import '../core/adaptive_platform.dart';
import '../core/platform_resolver.dart';
import '../theme/adaptive_theme.dart';
import '../theme/adaptive_theme_data.dart';
import '../widgets/dialogs/adaptive_dialog.dart';
import '../widgets/feedback/adaptive_feedback.dart';

/// Context extensions for rapid adaptive UI development.
extension AdaptiveContextExtension on BuildContext {
  /// Whether the resolved design system is Cupertino for this context.
  bool get isCupertino => PlatformResolver.isCupertino(this);

  /// Whether the resolved design system is Material for this context.
  bool get isMaterial => PlatformResolver.isMaterial(this);

  /// Active resolved platform for this context.
  AdaptivePlatform get resolvedAdaptivePlatform => PlatformResolver.resolve(this);

  /// Current [AdaptiveThemeData], if configured.
  AdaptiveThemeData? get adaptiveTheme => AdaptiveTheme.maybeOf(this)?.data;

  /// Displays an adaptive transient snackbar.
  void showAdaptiveSnackBar(
    String message, {
    AdaptiveFeedbackType type = AdaptiveFeedbackType.info,
    String? action,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    AdaptiveSnackBar.show(
      this,
      message: message,
      type: type,
      action: action,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  /// Displays an adaptive confirmation dialog.
  Future<bool> showAdaptiveConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) {
    return AdaptiveDialog.confirm(
      context: this,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      isDestructive: isDestructive,
    );
  }
}
