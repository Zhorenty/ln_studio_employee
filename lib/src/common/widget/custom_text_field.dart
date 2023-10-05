import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// Custom-styled [TextFormField].
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.label,
    this.errorText,
    this.inputFormatters,
    this.maxLength,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.suffix,
    this.dense = true,
    this.enabled = true,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  ///
  final TextInputAction? textInputAction;

  ///
  final FocusNode? focusNode;

  ///
  final bool enabled;

  /// Optional text that describes this input field.
  final String? label;

  /// Text that appears below the [InputDecorator.child] and the border.
  final String? errorText;

  /// Indicator whether this text field should have a dense appearance.
  final bool dense;

  /// Maximum length of this text field.
  final int? maxLength;

  /// Keyboard type to use for this text field.
  final TextInputType? keyboardType;

  /// [List] of [TextInputFormatter] to apply to this text field.
  final List<TextInputFormatter>? inputFormatters;

  ///
  final void Function(String)? onChanged;

  /// Callback that validates the input text.
  final String? Function(String?)? validator;

  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dense ? 8 : 2),
      child: TextFormField(
        enabled: enabled,
        focusNode: focusNode,
        validator: validator,
        maxLength: maxLength,
        controller: controller,
        textInputAction: textInputAction,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelStyle: context.textTheme.bodyMedium!.copyWith(
            color: context.colorScheme.primary,
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: context.colorScheme.background,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB95D6D)),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB95D6D)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF272727)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF272727)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6B6A6A)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          labelText: label,
          isDense: true,
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
