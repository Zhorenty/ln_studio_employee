import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/avatar_widget.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
    required this.title,
    required this.createdAt,
    required this.text,
  });

  ///
  final String title;

  ///
  final String createdAt;

  ///
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(title: title),
              const SizedBox(width: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    TextSpan(
                      text: createdAt,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
        ],
      ),
    );
  }
}
