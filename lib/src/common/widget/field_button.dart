import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

class FieldButton extends StatefulWidget {
  const FieldButton({
    super.key,
    required this.dense,
    required this.label,
    required this.title,
    required this.onTap,
  });

  final bool dense;

  /// Label of this [FieldButton].
  final String label;

  /// Label of this [FieldButton].
  final String title;

  final void Function()? onTap;

  @override
  State<FieldButton> createState() => _FieldButtonState();
}

class _FieldButtonState extends State<FieldButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(top: widget.dense ? 12 : 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.primary,
                fontFamily: FontFamily.geologica,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.title,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4 + 2, bottom: 8),
                  child: Icon(Icons.arrow_forward_ios, size: 20),
                )
              ],
            ),
            Container(
              color: const Color(0xFFA8A6A6),
              height: 1,
              margin: const EdgeInsets.only(top: 4),
            )
          ],
        ),
      ),
    );
  }
}
