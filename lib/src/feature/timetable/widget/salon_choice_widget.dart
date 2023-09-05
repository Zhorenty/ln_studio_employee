import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';

class SalonChoiceWidget extends StatelessWidget {
  const SalonChoiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                color: context.colors.onBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'ул. Степана Разина, д. 72',
              style: context.fonts.titleMedium!.copyWith(
                fontSize: 17,
                color: context.colors.onBackground,
                fontFamily: FontFamily.geologica,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colors.onBackground,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
