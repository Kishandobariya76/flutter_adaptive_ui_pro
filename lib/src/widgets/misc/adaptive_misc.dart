import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide RefreshCallback;
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive divider line.
class AdaptiveDivider extends StatelessWidget {
  /// Creates an [AdaptiveDivider].
  const AdaptiveDivider({
    super.key,
    this.height = 16.0,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.platform,
  });

  /// Total height allocated for divider.
  final double height;

  /// Thickness of line.
  final double? thickness;

  /// Leading indent.
  final double? indent;

  /// Trailing indent.
  final double? endIndent;

  /// Color override.
  final Color? color;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final double effectiveThickness = thickness ?? (1.0 / MediaQuery.of(context).devicePixelRatio);
      return Padding(
        padding: EdgeInsets.only(
          left: indent ?? 0.0,
          right: endIndent ?? 0.0,
          top: (height - effectiveThickness) / 2,
          bottom: (height - effectiveThickness) / 2,
        ),
        child: Container(
          height: effectiveThickness,
          color: color ?? CupertinoColors.separator.resolveFrom(context),
        ),
      );
    }

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}

/// Platform-adaptive icon that automatically resolves between Material and Cupertino [IconData].
class AdaptiveIcon extends StatelessWidget {
  /// Creates an [AdaptiveIcon].
  const AdaptiveIcon({
    super.key,
    required this.material,
    required this.cupertino,
    this.size,
    this.color,
    this.semanticLabel,
    this.platform,
  });

  /// Material icon data.
  final IconData material;

  /// Cupertino icon data.
  final IconData cupertino;

  /// Icon size.
  final double? size;

  /// Icon color.
  final Color? color;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    return Icon(
      isCupertino ? cupertino : material,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}

/// Platform-adaptive avatar surface.
class AdaptiveAvatar extends StatelessWidget {
  /// Creates an [AdaptiveAvatar].
  const AdaptiveAvatar({
    super.key,
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundImage,
    this.radius = 20.0,
    this.platform,
  });

  /// Child widget inside avatar (initials or icon).
  final Widget? child;

  /// Background color.
  final Color? backgroundColor;

  /// Text/icon color.
  final Color? foregroundColor;

  /// Image provider.
  final ImageProvider? backgroundImage;

  /// Radius.
  final double radius;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: backgroundColor ?? CupertinoColors.systemGrey4.resolveFrom(context),
          shape: BoxShape.circle,
          image: backgroundImage != null
              ? DecorationImage(image: backgroundImage!, fit: BoxFit.cover)
              : null,
        ),
        child: child != null
            ? Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: foregroundColor ?? CupertinoColors.label.resolveFrom(context),
                    fontWeight: FontWeight.w600,
                  ),
                  child: child!,
                ),
              )
            : null,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      backgroundImage: backgroundImage,
      child: child,
    );
  }
}

/// Platform-adaptive badge widget.
class AdaptiveBadge extends StatelessWidget {
  /// Creates an [AdaptiveBadge].
  const AdaptiveBadge({
    super.key,
    this.label,
    this.count,
    this.backgroundColor,
    this.textColor,
    this.child,
    this.isLarge = false,
  });

  /// Optional text label.
  final String? label;

  /// Optional numeric count.
  final int? count;

  /// Background color.
  final Color? backgroundColor;

  /// Text color.
  final Color? textColor;

  /// Wrapped child.
  final Widget? child;

  /// Whether large pill style.
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final String? text = label ?? (count != null ? '$count' : null);

    final Widget badgeContent = Container(
      padding: EdgeInsets.symmetric(horizontal: isLarge ? 8.0 : 5.0, vertical: isLarge ? 4.0 : 2.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? CupertinoColors.destructiveRed,
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: BoxConstraints(minWidth: isLarge ? 20.0 : 16.0, minHeight: isLarge ? 20.0 : 16.0),
      child: text != null
          ? Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: isLarge ? 12.0 : 10.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );

    if (child == null) return badgeContent;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child!,
        Positioned(
          top: -4,
          right: -4,
          child: badgeContent,
        ),
      ],
    );
  }
}

/// Platform-adaptive interactive chip capsule.
class AdaptiveChip extends StatelessWidget {
  /// Creates an [AdaptiveChip].
  const AdaptiveChip({
    super.key,
    required this.label,
    this.avatar,
    this.onPressed,
    this.onDeleted,
    this.selected = false,
    this.backgroundColor,
    this.platform,
  });

  /// Label string or widget.
  final Widget label;

  /// Leading avatar or icon.
  final Widget? avatar;

  /// Tap callback.
  final VoidCallback? onPressed;

  /// Delete button callback.
  final VoidCallback? onDeleted;

  /// Selected state.
  final bool selected;

  /// Background color.
  final Color? backgroundColor;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final Color bg = selected
          ? CupertinoTheme.of(context).primaryColor
          : (backgroundColor ?? CupertinoColors.systemGrey5.resolveFrom(context));
      final Color fg = selected ? CupertinoColors.white : CupertinoColors.label.resolveFrom(context);

      return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (avatar != null) ...<Widget>[
                avatar!,
                const SizedBox(width: 6.0),
              ],
              DefaultTextStyle(
                style: TextStyle(fontSize: 13.0, color: fg, fontWeight: FontWeight.w500),
                child: label,
              ),
              if (onDeleted != null) ...<Widget>[
                const SizedBox(width: 6.0),
                GestureDetector(
                  onTap: onDeleted,
                  child: Icon(CupertinoIcons.clear_circled_solid, size: 16.0, color: fg),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return InputChip(
      label: label,
      avatar: avatar,
      onPressed: onPressed,
      onDeleted: onDeleted,
      selected: selected,
      backgroundColor: backgroundColor,
    );
  }
}

/// Platform-adaptive card container.
class AdaptiveCard extends StatelessWidget {
  /// Creates an [AdaptiveCard].
  const AdaptiveCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.color,
    this.elevation = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.platform,
  });

  /// Card content.
  final Widget child;

  /// Content padding.
  final EdgeInsetsGeometry padding;

  /// Outer margin.
  final EdgeInsetsGeometry margin;

  /// Background color.
  final Color? color;

  /// Elevation depth on Material.
  final double elevation;

  /// Corner radius.
  final BorderRadius borderRadius;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context),
          borderRadius: borderRadius,
          border: Border.all(
            color: CupertinoColors.separator.resolveFrom(context).withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
        child: child,
      );
    }

    return Container(
      margin: margin,
      child: Card(
        elevation: elevation,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Platform-adaptive refresh indicator.
class AdaptiveRefreshIndicator extends StatelessWidget {
  /// Creates an [AdaptiveRefreshIndicator].
  const AdaptiveRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.platform,
  });

  /// Scrollable child widget.
  final Widget child;

  /// Refresh callback.
  final RefreshCallback onRefresh;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          SliverToBoxAdapter(child: child),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child,
    );
  }
}

/// Platform-adaptive safe area wrapper.
class AdaptiveSafeArea extends StatelessWidget {
  /// Creates an [AdaptiveSafeArea].
  const AdaptiveSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });

  /// Child widget.
  final Widget child;

  /// Whether to avoid system intrusions at the top.
  final bool top;

  /// Whether to avoid system intrusions at the bottom.
  final bool bottom;

  /// Whether to avoid system intrusions on the left.
  final bool left;

  /// Whether to avoid system intrusions on the right.
  final bool right;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}

/// Platform-adaptive visibility toggle.
class AdaptiveVisibility extends StatelessWidget {
  /// Creates an [AdaptiveVisibility].
  const AdaptiveVisibility({
    super.key,
    required this.child,
    required this.visible,
    this.replacement = const SizedBox.shrink(),
  });

  /// Child widget.
  final Widget child;

  /// Whether visible.
  final bool visible;

  /// Replacement when hidden.
  final Widget replacement;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      replacement: replacement,
      child: child,
    );
  }
}
