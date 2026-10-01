import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_config.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive form container wrapping Flutter's native [Form].
class AdaptiveForm extends StatefulWidget {
  /// Creates an [AdaptiveForm].
  const AdaptiveForm({
    super.key,
    this.formKey,
    required this.child,
    this.canPop,
    this.onPopInvokedWithResult,
    this.autovalidateMode,
  });

  /// Optional key referencing the backing [FormState].
  final GlobalKey<FormState>? formKey;

  /// Form content.
  final Widget child;

  /// Whether the route can be popped.
  final bool? canPop;

  /// Pop invoked callback.
  final PopInvokedWithResultCallback<dynamic>? onPopInvokedWithResult;

  /// Autovalidate mode.
  final AutovalidateMode? autovalidateMode;

  @override
  AdaptiveFormState createState() => AdaptiveFormState();
}

/// State for [AdaptiveForm] providing standard form manipulation helpers.
class AdaptiveFormState extends State<AdaptiveForm> {
  late final GlobalKey<FormState> _internalKey = GlobalKey<FormState>();

  /// Returns the effective [GlobalKey] used by the underlying [Form].
  GlobalKey<FormState> get effectiveKey => widget.formKey ?? _internalKey;

  /// Validates every [FormField] that is a descendant of this form.
  bool validate() => effectiveKey.currentState?.validate() ?? false;

  /// Saves every [FormField] that is a descendant of this form.
  void save() => effectiveKey.currentState?.save();

  /// Resets every [FormField] that is a descendant of this form.
  void reset() => effectiveKey.currentState?.reset();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: effectiveKey,
      canPop: widget.canPop,
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      autovalidateMode: widget.autovalidateMode,
      child: widget.child,
    );
  }
}

/// Generic platform-adaptive form field base.
class AdaptiveFormField<T> extends FormField<T> {
  /// Creates an [AdaptiveFormField].
  const AdaptiveFormField({
    super.key,
    required super.builder,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.enabled = true,
    super.restorationId,
  });
}

/// Platform-adaptive form section grouping related inputs.
class AdaptiveFormSection extends StatelessWidget {
  /// Creates an [AdaptiveFormSection].
  const AdaptiveFormSection({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.margin,
    this.insetGrouped = true,
    this.platform,
  });

  /// Form rows inside this section.
  final List<Widget> children;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Outer section margin.
  final EdgeInsetsGeometry? margin;

  /// Whether to use inset grouped styling on iOS.
  final bool insetGrouped;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final Widget sectionContent;
    if (isCupertino) {
      if (insetGrouped) {
        sectionContent = CupertinoFormSection.insetGrouped(
          header: header,
          footer: footer,
          margin: margin as EdgeInsets? ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          children: children,
        );
      } else {
        sectionContent = CupertinoFormSection(
          header: header,
          footer: footer,
          margin: margin as EdgeInsets? ?? EdgeInsets.zero,
          children: children,
        );
      }
    } else {
      sectionContent = Container(
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
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.3)),
              ),
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

    if (platform != null) {
      return AdaptiveConfig(
        platform: platform!,
        child: sectionContent,
      );
    }
    return sectionContent;
  }
}

/// Platform-adaptive form row for placing labels and controls side-by-side.
class AdaptiveFormRow extends StatelessWidget {
  /// Creates an [AdaptiveFormRow].
  const AdaptiveFormRow({
    super.key,
    required this.child,
    this.prefix,
    this.helper,
    this.error,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    this.platform,
  });

  /// Control widget in the row.
  final Widget child;

  /// Optional prefix label or icon.
  final Widget? prefix;

  /// Supporting helper note.
  final Widget? helper;

  /// Error message.
  final Widget? error;

  /// Padding.
  final EdgeInsetsGeometry padding;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoFormRow(
        prefix: prefix,
        helper: helper,
        error: error,
        padding: padding,
        child: child,
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (prefix != null) ...<Widget>[
                prefix!,
                const SizedBox(width: 16.0),
              ],
              Expanded(child: child),
            ],
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.error),
                child: error!,
              ),
            )
          else if (helper != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!,
                child: helper!,
              ),
            ),
        ],
      ),
    );
  }
}
