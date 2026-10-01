import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';
import '../../theme/adaptive_component_theme.dart';
import 'adaptive_text_field.dart';

/// Platform-adaptive form field that fully integrates with Flutter's [Form] and [FormState].
class AdaptiveTextFormField extends FormField<String> {
  /// Creates an [AdaptiveTextFormField].
  AdaptiveTextFormField({
    super.key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    String? placeholder,
    String? hint,
    String? label,
    String? helperText,
    Widget? prefix,
    Widget? suffix,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    int? maxLines = 1,
    int? minLines,
    int? maxLength,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    List<TextInputFormatter>? inputFormatters,
    Color? cursorColor,
    AdaptivePlatform? platform,
    AdaptiveMaterialTextFieldConfig? material,
    AdaptiveCupertinoTextFieldConfig? cupertino,
    super.onSaved,
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    super.restorationId,
  }) : super(
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
          builder: (FormFieldState<String> field) {
            final _AdaptiveTextFormFieldState state = field as _AdaptiveTextFormFieldState;
            final bool isCupertino = PlatformResolver.isCupertino(field.context, widgetOverride: platform);

            void handleChanged(String value) {
              field.didChange(value);
              onChanged?.call(value);
            }

            if (isCupertino) {
              return AdaptiveTextField(
                controller: state._effectiveController,
                focusNode: focusNode,
                placeholder: placeholder,
                hint: hint,
                label: label,
                helperText: helperText,
                errorText: field.errorText,
                prefix: prefix,
                suffix: suffix,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
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
                onChanged: handleChanged,
                onSubmitted: onSubmitted,
                onEditingComplete: onEditingComplete,
                onTap: onTap,
                onTapOutside: onTapOutside,
                inputFormatters: inputFormatters,
                cursorColor: cursorColor,
                platform: AdaptivePlatform.cupertino,
                cupertino: cupertino,
              );
            }

            return TextFormField(
              controller: state._effectiveController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: label,
                hintText: placeholder ?? hint,
                helperText: helperText,
                errorText: field.errorText,
                prefix: prefix,
                suffix: suffix,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: material?.border ?? const OutlineInputBorder(),
                enabledBorder: material?.enabledBorder,
                focusedBorder: material?.focusedBorder,
                errorBorder: material?.errorBorder,
                fillColor: material?.fillColor,
                filled: material?.filled ?? false,
              ),
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
              onChanged: handleChanged,
              onFieldSubmitted: onSubmitted,
              onEditingComplete: onEditingComplete,
              onTap: onTap,
              onTapOutside: onTapOutside,
              inputFormatters: inputFormatters,
              cursorColor: cursorColor,
            );
          },
        );

  /// Controller for text.
  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _AdaptiveTextFormFieldState();
}

class _AdaptiveTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller!;

  @override
  AdaptiveTextFormField get widget => super.widget as AdaptiveTextFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AdaptiveTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller?.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

/// Platform-adaptive search field.
///
/// On iOS, uses [CupertinoSearchTextField].
/// On Android, uses Material [SearchBar] or an optimized search [TextField].
class AdaptiveSearchField extends StatelessWidget {
  /// Creates an [AdaptiveSearchField].
  const AdaptiveSearchField({
    super.key,
    this.controller,
    this.placeholder = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onSuffixTap,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.platform,
  });

  /// Text controller.
  final TextEditingController? controller;

  /// Search hint string.
  final String placeholder;

  /// Changed callback.
  final ValueChanged<String>? onChanged;

  /// Submitted callback.
  final ValueChanged<String>? onSubmitted;

  /// Clear button callback.
  final VoidCallback? onSuffixTap;

  /// Whether active.
  final bool enabled;

  /// Autofocus.
  final bool autofocus;

  /// Focus node.
  final FocusNode? focusNode;

  /// Explicit platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return CupertinoSearchTextField(
        controller: controller,
        focusNode: focusNode,
        placeholder: placeholder,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onSuffixTap: onSuffixTap,
        enabled: enabled,
        autofocus: autofocus,
      );
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller != null && controller!.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller!.clear();
                  onChanged?.call('');
                  onSuffixTap?.call();
                },
              )
            : null,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// Platform-adaptive password input field with integrated visibility toggle.
class AdaptivePasswordField extends StatefulWidget {
  /// Creates an [AdaptivePasswordField].
  const AdaptivePasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.placeholder = 'Password',
    this.label = 'Password',
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.validator,
    this.platform,
  });

  /// Controller.
  final TextEditingController? controller;

  /// Focus node.
  final FocusNode? focusNode;

  /// Placeholder.
  final String placeholder;

  /// Label.
  final String? label;

  /// On changed.
  final ValueChanged<String>? onChanged;

  /// On submitted.
  final ValueChanged<String>? onSubmitted;

  /// Whether enabled.
  final bool enabled;

  /// Form validator.
  final FormFieldValidator<String>? validator;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  State<AdaptivePasswordField> createState() => _AdaptivePasswordFieldState();
}

class _AdaptivePasswordFieldState extends State<AdaptivePasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: widget.platform);

    final Widget toggleIcon = IconButton(
      icon: Icon(
        _obscured
            ? (isCupertino ? CupertinoIcons.eye_slash : Icons.visibility_off)
            : (isCupertino ? CupertinoIcons.eye : Icons.visibility),
        size: 20,
      ),
      onPressed: widget.enabled
          ? () {
              setState(() {
                _obscured = !_obscured;
              });
            }
          : null,
    );

    if (widget.validator != null) {
      return AdaptiveTextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        placeholder: widget.placeholder,
        label: widget.label,
        obscureText: _obscured,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        suffixIcon: toggleIcon,
        validator: widget.validator,
        platform: widget.platform,
      );
    }

    return AdaptiveTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      placeholder: widget.placeholder,
      label: widget.label,
      obscureText: _obscured,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      suffixIcon: toggleIcon,
      platform: widget.platform,
    );
  }
}
