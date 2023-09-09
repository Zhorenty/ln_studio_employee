import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// Container with [GestureDetector].
class GesturedContainer extends StatelessWidget {
  const GesturedContainer({super.key, this.label});

  /// Label of this [GesturedContainer].
  final String? label;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          /// TODO: Move into separate widget
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () => context.pop(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () => context.pop(),
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
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 17,
                    color: context.colorScheme.onBackground,
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.colorScheme.onBackground,
                size: 18,
              ),
            ],
          ),
        ),
      );
}
