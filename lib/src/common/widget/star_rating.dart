import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// Star rating based on a given rating value.
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.size = 24.0,
  });

  /// Rating value.
  final int rating;

  /// Size of each star icon.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star_outlined : Icons.star_border_outlined,
          size: size,
          color: index < rating
              ? context.colorScheme.primary
              : context.colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
