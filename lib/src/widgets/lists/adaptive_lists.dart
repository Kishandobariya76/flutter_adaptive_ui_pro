import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive list tile.
///
/// On iOS, renders [CupertinoListTile] with native separator lines and iOS typography.
/// On Android, renders Material [ListTile] with ripple ink splash.
class AdaptiveListTile extends StatelessWidget {
  /// Creates an [AdaptiveListTile].
  const AdaptiveListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.dense,
    this.contentPadding,
    this.platform,
  });

  /// Leading widget.
  final Widget? leading;

  /// Primary title widget.
  final Widget title;

  /// Secondary subtitle widget.
  final Widget? subtitle;

  /// Trailing accessory widget.
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Long press callback.
  final VoidCallback? onLongPress;

  /// Whether active.
  final bool enabled;

  /// Whether selected.
  final bool selected;

  /// Compact dense flag.
  final bool? dense;

  /// Custom padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing ??
            (onTap != null
                ? const Icon(CupertinoIcons.chevron_forward, size: 18, color: CupertinoColors.inactiveGray)
                : null),
        onTap: enabled ? onTap : null,
        padding: contentPadding as EdgeInsets?,
      );
    }

    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      enabled: enabled,
      selected: selected,
      dense: dense,
      contentPadding: contentPadding,
    );
  }
}

/// Platform-adaptive grouped list section.
class AdaptiveListSection extends StatelessWidget {
  /// Creates an [AdaptiveListSection].
  const AdaptiveListSection({
    super.key,
    this.header,
    this.footer,
    required this.children,
    this.insetGrouped = true,
    this.margin,
    this.platform,
  });

  /// Section header widget.
  final Widget? header;

  /// Section footer widget.
  final Widget? footer;

  /// Section child items.
  final List<Widget> children;

  /// Whether to apply iOS inset-grouped styling.
  final bool insetGrouped;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      if (insetGrouped) {
        return CupertinoListSection.insetGrouped(
          header: header,
          footer: footer,
          margin: margin,
          children: children,
        );
      }
      return CupertinoListSection(
        header: header,
        footer: footer,
        margin: margin ?? EdgeInsets.zero,
        children: children,
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (header != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 6.0),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                child: header!,
              ),
            ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.3)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(children: children),
          ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 4.0),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!,
                child: footer!,
              ),
            ),
        ],
      ),
    );
  }
}

/// Platform-adaptive list view with platform-native bounce physics on iOS.
class AdaptiveListView extends StatelessWidget {
  /// Creates an [AdaptiveListView].
  const AdaptiveListView({
    super.key,
    required this.children,
    this.padding,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
    this.platform,
  });

  /// List items.
  final List<Widget> children;

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Scroll physics.
  final ScrollPhysics? physics;

  /// Scroll controller.
  final ScrollController? controller;

  /// Whether to shrink wrap.
  final bool shrinkWrap;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final ScrollPhysics effectivePhysics =
        physics ?? (isCupertino ? const BouncingScrollPhysics() : const ClampingScrollPhysics());

    return ListView(
      controller: controller,
      physics: effectivePhysics,
      padding: padding,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}

/// Platform-adaptive expansion tile.
class AdaptiveExpansionTile extends StatefulWidget {
  /// Creates an [AdaptiveExpansionTile].
  const AdaptiveExpansionTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.platform,
  });

  /// Leading widget.
  final Widget? leading;

  /// Title widget.
  final Widget title;

  /// Subtitle widget.
  final Widget? subtitle;

  /// Expandable children.
  final List<Widget> children;

  /// Initially expanded flag.
  final bool initiallyExpanded;

  /// Expansion change callback.
  final ValueChanged<bool>? onExpansionChanged;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  State<AdaptiveExpansionTile> createState() => _AdaptiveExpansionTileState();
}

class _AdaptiveExpansionTileState extends State<AdaptiveExpansionTile> with SingleTickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: _expanded ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
      widget.onExpansionChanged?.call(_expanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: widget.platform);

    if (isCupertino) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoListTile(
            leading: widget.leading,
            title: widget.title,
            subtitle: widget.subtitle,
            trailing: RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 0.25).animate(_animController),
              child: const Icon(CupertinoIcons.chevron_forward, size: 16),
            ),
            onTap: _toggle,
          ),
          SizeTransition(
            sizeFactor: _animController,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(children: widget.children),
            ),
          ),
        ],
      );
    }

    return ExpansionTile(
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: widget.onExpansionChanged,
      children: widget.children,
    );
  }
}

/// Platform-adaptive dismissible item container.
class AdaptiveDismissible extends StatelessWidget {
  /// Creates an [AdaptiveDismissible].
  const AdaptiveDismissible({
    super.key,
    required this.child,
    this.background,
    this.secondaryBackground,
    this.onDismissed,
    this.confirmDismiss,
    this.direction = DismissDirection.endToStart,
    this.platform,
  });

  /// Content.
  final Widget child;

  /// Background when swiped right.
  final Widget? background;

  /// Background when swiped left.
  final Widget? secondaryBackground;

  /// Callback when dismissed.
  final DismissDirectionCallback? onDismissed;

  /// Confirmation callback before dismissal.
  final ConfirmDismissCallback? confirmDismiss;

  /// Swipe direction.
  final DismissDirection direction;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key ?? UniqueKey(),
      background: background,
      secondaryBackground: secondaryBackground,
      onDismissed: onDismissed,
      confirmDismiss: confirmDismiss,
      direction: direction,
      child: child,
    );
  }
}

/// Platform-adaptive scrollbar.
class AdaptiveScrollbar extends StatelessWidget {
  /// Creates an [AdaptiveScrollbar].
  const AdaptiveScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility,
    this.platform,
  });

  /// Scrollable child widget.
  final Widget child;

  /// Scroll controller.
  final ScrollController? controller;

  /// Thumb visibility.
  final bool? thumbVisibility;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoScrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        child: child,
      );
    }

    return Scrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      child: child,
    );
  }
}
