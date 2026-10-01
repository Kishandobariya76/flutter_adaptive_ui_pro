import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import '../../theme/adaptive_component_theme.dart';

/// Platform-adaptive text input field.
///
/// On Android/Desktop/Web, renders a Material 3 [TextField].
/// On iOS, renders a [CupertinoTextField] adhering to iOS Human Interface Guidelines.
class AdaptiveTextField extends StatelessWidget {
  /// Creates an [AdaptiveTextField].
  const AdaptiveTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.hint,
    this.label,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.inputFormatters,
    this.cursorColor,
    this.platform,
    this.material,
    this.cupertino,
    this.restorationId,
    this.scrollPadding = const EdgeInsets.all(20.0),
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// iOS-style placeholder or Material hint string.
  final String? placeholder;

  /// Alternative alias for [placeholder].
  final String? hint;

  /// Label displayed above or floating in the input field.
  final String? label;

  /// Subordinate helper text displayed below the field.
  final String? helperText;

  /// Error message displayed below field.
  final String? errorText;

  /// Widget placed before the editable text.
  final Widget? prefix;

  /// Widget placed after the editable text.
  final Widget? suffix;

  /// Icon placed before the field.
  final Widget? prefixIcon;

  /// Icon placed after the field.
  final Widget? suffixIcon;

  /// The type of keyboard to use.
  final TextInputType? keyboardType;

  /// The action button to display on the software keyboard.
  final TextInputAction? textInputAction;

  /// How to capitalize words.
  final TextCapitalization textCapitalization;

  /// How the text is aligned horizontally.
  final TextAlign textAlign;

  /// Directionality of the text.
  final TextDirection? textDirection;

  /// Maximum line count.
  final int? maxLines;

  /// Minimum line count.
  final int? minLines;

  /// Character length limit.
  final int? maxLength;

  /// Whether to obscure text for passwords.
  final bool obscureText;

  /// Obscuring character.
  final String obscuringCharacter;

  /// Whether the input is interactive.
  final bool enabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether to focus automatically.
  final bool autofocus;

  /// Whether to enable auto-correction.
  final bool autocorrect;

  /// Whether to show input suggestions.
  final bool enableSuggestions;

  /// Called when text changes.
  final ValueChanged<String>? onChanged;

  /// Called when user submits from the keyboard.
  final ValueChanged<String>? onSubmitted;

  /// Called when editing completes.
  final VoidCallback? onEditingComplete;

  /// Called when field is tapped.
  final GestureTapCallback? onTap;

  /// Called when tap occurs outside field.
  final TapRegionCallback? onTapOutside;

  /// Optional formatters for user input.
  final List<TextInputFormatter>? inputFormatters;

  /// Color of the blinking cursor.
  final Color? cursorColor;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  /// Material configuration.
  final AdaptiveMaterialTextFieldConfig? material;

  /// Cupertino configuration.
  final AdaptiveCupertinoTextFieldConfig? cupertino;

  /// Restoration ID for state preservation.
  final String? restorationId;

  /// Scroll padding when keyboard appears.
  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return _buildCupertino(context);
    }
    return _buildMaterial(context);
  }

  Widget _buildMaterial(BuildContext context) {
    final Widget? effectivePrefix = prefixIcon ?? prefix;
    final Widget? effectiveSuffix = suffixIcon ?? suffix;

    final InputDecoration decoration = InputDecoration(
      labelText: label,
      hintText: placeholder ?? hint,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: effectivePrefix,
      suffixIcon: effectiveSuffix,
      border: material?.border ?? const OutlineInputBorder(),
      enabledBorder: material?.enabledBorder,
      focusedBorder: material?.focusedBorder,
      errorBorder: material?.errorBorder,
      fillColor: material?.fillColor,
      filled: material?.filled ?? false,
    );

    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      onTapOutside: onTapOutside,
      inputFormatters: inputFormatters,
      cursorColor: cursorColor,
      restorationId: restorationId,
      scrollPadding: scrollPadding,
    );
  }

  Widget _buildCupertino(BuildContext context) {
    final Widget? effectivePrefix = prefixIcon ?? prefix;
    final Widget? effectiveSuffix = suffixIcon ?? suffix;

    final BoxDecoration defaultDecoration = BoxDecoration(
      color: enabled
          ? CupertinoColors.tertiarySystemFill.resolveFrom(context)
          : CupertinoColors.quaternarySystemFill.resolveFrom(context),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      border: Border.all(
        color: errorText != null ? CupertinoColors.destructiveRed : CupertinoColors.systemGrey4.resolveFrom(context),
        width: 1.0,
      ),
    );

    final Widget cupertinoField = CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      placeholder: placeholder ?? hint,
      placeholderStyle: cupertino?.placeholderStyle,
      prefix: effectivePrefix != null
          ? Padding(padding: const EdgeInsets.only(left: 8.0), child: effectivePrefix)
          : null,
      suffix: effectiveSuffix != null
          ? Padding(padding: const EdgeInsets.only(right: 8.0), child: effectiveSuffix)
          : null,
      clearButtonMode: cupertino?.clearButtonMode ?? OverlayVisibilityMode.never,
      decoration: cupertino?.decoration ?? defaultDecoration,
      padding: cupertino?.padding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      onTapOutside: onTapOutside,
      inputFormatters: inputFormatters,
      cursorColor: cursorColor ?? CupertinoTheme.of(context).primaryColor,
      restorationId: restorationId,
      scrollPadding: scrollPadding,
    );

    if (label == null && errorText == null && helperText == null) {
      return cupertinoField;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ),
        cupertinoField,
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Text(
              errorText!,
              style: const TextStyle(fontSize: 12.0, color: CupertinoColors.destructiveRed),
            ),
          )
        else if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Text(
              helperText!,
              style: TextStyle(
                fontSize: 12.0,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
          ),
      ],
    );
  }
}
