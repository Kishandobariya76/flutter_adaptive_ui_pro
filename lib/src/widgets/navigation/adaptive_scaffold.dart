import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import 'adaptive_bars.dart';

/// Platform-adaptive page scaffold.
///
/// On Android, renders a standard Material [Scaffold].
/// On iOS, renders a [CupertinoPageScaffold] with authentic Apple styling and typography.
class AdaptiveScaffold extends StatelessWidget {
  /// Creates an [AdaptiveScaffold].
  const AdaptiveScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.platform,
  });

  /// Top app bar (e.g. [AdaptiveAppBar] or [PreferredSizeWidget]).
  final PreferredSizeWidget? appBar;

  /// Main page content.
  final Widget body;

  /// Bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Floating action button.
  final Widget? floatingActionButton;

  /// Drawer menu.
  final Widget? drawer;

  /// Background scaffold color.
  final Color? backgroundColor;

  /// Whether to resize content when on-screen keyboard appears.
  final bool resizeToAvoidBottomInset;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final ObstructingPreferredSizeWidget? cupertinoNavBar =
          appBar is ObstructingPreferredSizeWidget ? (appBar as ObstructingPreferredSizeWidget) : null;

      Widget pageContent = body;

      // If app bar is not ObstructingPreferredSizeWidget (e.g. custom PreferredSizeWidget), stack or column it
      if (appBar != null && cupertinoNavBar == null) {
        pageContent = Column(
          children: <Widget>[
            appBar!,
            Expanded(child: pageContent),
          ],
        );
      }

      // If bottom bar is present in Cupertino mode
      if (bottomNavigationBar != null) {
        pageContent = Column(
          children: <Widget>[
            Expanded(child: pageContent),
            bottomNavigationBar!,
          ],
        );
      }

      // Stack floating action button if supplied
      if (floatingActionButton != null) {
        pageContent = Stack(
          children: <Widget>[
            pageContent,
            Positioned(
              right: 16.0,
              bottom: 16.0 + (bottomNavigationBar != null ? 50.0 : 0.0),
              child: floatingActionButton!,
            ),
          ],
        );
      }

      return CupertinoPageScaffold(
        navigationBar: cupertinoNavBar,
        backgroundColor: backgroundColor ?? CupertinoColors.systemGroupedBackground.resolveFrom(context),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: SafeArea(
          top: cupertinoNavBar == null,
          bottom: bottomNavigationBar == null,
          child: Material(
            type: MaterialType.transparency,
            child: pageContent,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

/// Convenience alias for [AdaptiveScaffold].
typedef AdaptivePageScaffold = AdaptiveScaffold;

/// Platform-adaptive drawer widget.
class AdaptiveDrawer extends StatelessWidget {
  /// Creates an [AdaptiveDrawer].
  const AdaptiveDrawer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation,
    this.platform,
  });

  /// Drawer contents.
  final Widget child;

  /// Background color.
  final Color? backgroundColor;

  /// Elevation shadow depth.
  final double? elevation;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return Container(
        width: 300,
        color: backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: child,
          ),
        ),
      );
    }

    return Drawer(
      backgroundColor: backgroundColor,
      elevation: elevation,
      child: child,
    );
  }
}

/// Platform-adaptive tab bar.
class AdaptiveTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates an [AdaptiveTabBar].
  const AdaptiveTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.isScrollable = false,
    this.platform,
  });

  /// List of tab widgets.
  final List<Widget> tabs;

  /// Tab controller.
  final TabController? controller;

  /// Tap callback.
  final ValueChanged<int>? onTap;

  /// Whether tabs scroll horizontally.
  final bool isScrollable;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Size get preferredSize => const Size.fromHeight(48.0);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      onTap: onTap,
      isScrollable: isScrollable,
    );
  }
}

/// Platform-adaptive navigation rail for tablets and desktop layouts.
class AdaptiveNavigationRail extends StatelessWidget {
  /// Creates an [AdaptiveNavigationRail].
  const AdaptiveNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    this.leading,
    this.trailing,
    this.extended = false,
    this.backgroundColor,
    this.platform,
  });

  /// Current destination index.
  final int selectedIndex;

  /// Callback when destination changes.
  final ValueChanged<int> onDestinationSelected;

  /// List of rail destinations.
  final List<AdaptiveNavigationItem> destinations;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Whether the rail is extended.
  final bool extended;

  /// Background color.
  final Color? backgroundColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      leading: leading,
      trailing: trailing,
      extended: extended,
      backgroundColor: backgroundColor,
      destinations: destinations.map((AdaptiveNavigationItem item) {
        return NavigationRailDestination(
          icon: item.icon,
          selectedIcon: item.activeIcon,
          label: Text(item.label),
        );
      }).toList(),
    );
  }
}
