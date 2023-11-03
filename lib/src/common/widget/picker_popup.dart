import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';

class PickerPopup extends StatelessWidget {
  const PickerPopup({
    super.key,
    required this.onPickCamera,
    required this.onPickGallery,
  });

  final void Function() onPickCamera;

  final void Function() onPickGallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fixedSize: Size(MediaQuery.sizeOf(context).width - 75, 35),
            backgroundColor: context.colorScheme.primary,
          ),
          onPressed: onPickCamera,
          child: Text(
            'Снять на камеру',
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fixedSize: Size(MediaQuery.sizeOf(context).width - 75, 35),
            backgroundColor: context.colorScheme.primary,
          ),
          onPressed: onPickGallery,
          child: Text(
            'Выбрать из галереи',
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
