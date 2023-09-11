import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.label,
    this.dense = true,
  });

  ///
  final TextEditingController? controller;

  ///
  final Function(String)? onFieldSubmitted;

  ///
  final bool dense;

  ///
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 10 : 4),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
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
          labelText: label,
          isDense: true,
        ),
      ),
    );
  }
}
