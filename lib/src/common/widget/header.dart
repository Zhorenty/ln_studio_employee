import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// Header widget with provided [label].
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.label,
    this.showUnderscore = true,
  });

  /// Label of this [HeaderWidget].
  final String label;

  /// Indicator whether underscore is visible.
  final bool showUnderscore;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyLarge!.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          if (showUnderscore)
            Container(
              height: 3,
              width: 50,
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
        ],
      );
}
