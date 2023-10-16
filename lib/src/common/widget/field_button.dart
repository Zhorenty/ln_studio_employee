import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FieldButton extends StatelessWidget {
  const FieldButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.controller,
    this.validator,
  });

  ///
  final TextEditingController controller;

  /// Label of this [FieldButton].
  final String label;

  ///
  final void Function()? onTap;

  ///
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomTextField(
        enabled: false,
        controller: controller,
        label: label,
        validator: validator,
      ),
    );
  }
}
