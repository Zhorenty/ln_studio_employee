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
    this.label,
    this.errorText,
    this.inputFormatters,
    this.maxLength,
    this.validator,
    this.keyboardType,
    this.dense = true,
    this.copyable = false,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

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

  /// Callback that validates the input text.
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 10 : 4),
      child: TextFormField(
        validator: validator,
        maxLength: maxLength,
        controller: controller,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelStyle: context.textTheme.bodyMedium!.copyWith(
            color: context.colorScheme.primary,
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A6A6)),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A6A6)),
          ),
          errorText: errorText,
          labelText: label,
          isDense: true,
          suffixIcon: copyable && controller?.text != null
              ? AnimatedButton(
                  padding: const EdgeInsets.only(top: 8 + 2, left: 8),
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
    );
  }
}
