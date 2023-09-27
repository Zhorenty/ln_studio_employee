import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/overlay/message_popup.dart';
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
    this.dense = true,
    this.copyable = false,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final FocusNode? focusNode;

  /// Optional text that describes this input field.
  final String? label;

  /// Text that appears below the [InputDecorator.child] and the border.
  final String? errorText;

  /// Indicator whether the text in this text field can be copied.
  final bool copyable;

  /// Indicator whether this text field should have a dense appearance.
  final bool dense;

  /// Maximum length of this text field.
  final int? maxLength;

  /// Keyboard type to use for this text field.
  final TextInputType? keyboardType;

  /// [List] of [TextInputFormatter] to apply to this text field.
  final List<TextInputFormatter>? inputFormatters;

  final void Function(String)? onChanged;

  /// Callback that validates the input text.
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 16 : 2),
      child: SizedBox(
        height: 55,
        child: TextFormField(
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
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF272727)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF272727)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.primary),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            errorText: errorText,
            labelText: label,
            isDense: true,
            suffixIcon: copyable && controller?.text != null
                ? AnimatedButton(
                    child: Icon(
                      Icons.copy,
                      color: context.colorScheme.primary,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: controller!.text));
                      MessagePopup.success(context, 'Скопировано');
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
