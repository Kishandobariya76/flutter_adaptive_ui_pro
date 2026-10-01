import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive top application bar.
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates an [AdaptiveAppBar].
  const AdaptiveAppBar({
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.platform,
  });

  /// Custom title widget.
  final Widget? title;

  /// Shorthand string title.
  final String? titleText;

  /// Leading widget (e.g. back button or drawer trigger).
  final Widget? leading;

  /// Trailing action widgets.
  final List<Widget>? actions;

  /// Background color.
  final Color? backgroundColor;

  /// Foreground / title color.
  final Color? foregroundColor;

  /// Elevation shadow depth.
  final double? elevation;

  /// Whether title should be centered.
  final bool? centerTitle;

  /// Whether to automatically imply leading back button.
  final bool automaticallyImplyLeading;

  /// Preferred size widget placed below app bar (e.g. tab bar).
  final PreferredSizeWidget? bottom;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Size get preferredSize {
    final double bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget effectiveTitle = title ?? (titleText != null ? Text(titleText!) : const SizedBox.shrink());

    if (isCupertino) {
      return CupertinoNavigationBar(
        leading: leading,
        middle: effectiveTitle,
        trailing: actions != null && actions!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: actions!,
              )
            : null,
        backgroundColor: backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.85),
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    }

    return AppBar(
      title: effectiveTitle,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
    );
  }
}

/// Navigation item description for adaptive bottom navigation.
class AdaptiveNavigationItem {
  /// Creates an [AdaptiveNavigationItem].
  const AdaptiveNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.tooltip,
  });

  /// Inactive icon.
  final Widget icon;

  /// Active icon when selected.
  final Widget? activeIcon;

  /// Item text label.
  final String label;

  /// Optional tooltip.
  final String? tooltip;
}

/// Platform-adaptive bottom navigation bar.
class AdaptiveBottomNavigationBar extends StatelessWidget {
  /// Creates an [AdaptiveBottomNavigationBar].
  const AdaptiveBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize = 24.0,
    this.platform,
  });

  /// Destination items.
  final List<AdaptiveNavigationItem> items;

  /// Selected index.
  final int currentIndex;

  /// Tap callback.
  final ValueChanged<int> onTap;

  /// Bar background color.
  final Color? backgroundColor;

  /// Selected icon and label color.
  final Color? selectedItemColor;

  /// Inactive icon and label color.
  final Color? unselectedItemColor;

  /// Size of icons.
  final double iconSize;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context).withValues(alpha: 0.85),
        activeColor: selectedItemColor ?? CupertinoTheme.of(context).primaryColor,
        inactiveColor: unselectedItemColor ?? CupertinoColors.inactiveGray,
        iconSize: iconSize,
        items: items.map((AdaptiveNavigationItem item) {
          return BottomNavigationBarItem(
            icon: item.icon,
            activeIcon: item.activeIcon,
            label: item.label,
            tooltip: item.tooltip,
          );
        }).toList(),
      );
    }

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: backgroundColor,
      destinations: items.map((AdaptiveNavigationItem item) {
        return NavigationDestination(
          icon: item.icon,
          selectedIcon: item.activeIcon,
          label: item.label,
          tooltip: item.tooltip,
        );
      }).toList(),
    );
  }
}

/// Convenience alias for [AdaptiveBottomNavigationBar].
typedef AdaptiveNavigationBar = AdaptiveBottomNavigationBar;
