import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FieldButton extends StatefulWidget {
  const FieldButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;

  /// Label of this [FieldButton].
  final String label;

  final void Function()? onTap;

  ///
  final String? Function(String?)? validator;

  @override
  State<FieldButton> createState() => _FieldButtonState();
}

class _FieldButtonState extends State<FieldButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomTextField(
        enabled: false,
        controller: widget.controller,
        label: widget.label,
        validator: widget.validator,
      ),
    );
  }
}
