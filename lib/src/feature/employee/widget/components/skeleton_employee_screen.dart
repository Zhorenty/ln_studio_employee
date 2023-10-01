import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import 'expanded_app_bar.dart';

class SkeletonEditEmployeeScreen extends StatelessWidget {
  const SkeletonEditEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          ExpandedAppBar(
            onExit: () => context.pop(),
            title: const SizedBox(
              width: 200,
              height: 28,
            ),
            leading: const SizedBox(
              width: 40,
              height: 28,
            ),
            trailing: const SizedBox(
              width: 40,
              height: 28,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: MediaQuery.sizeOf(context).height / 1.2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom [Shimmer] for this skeleton.
class _CustomShimmer extends StatelessWidget {
  const _CustomShimmer({required this.label, required this.dense});

  /// Indicator whether this [_CustomShimmer] should be densed.
  final bool dense;

  /// Label of this [_CustomShimmer].
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dense ? 11 : 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall!.copyWith(
              color: context.colorScheme.primary,
              fontFamily: FontFamily.geologica,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 64),
            child: Shimmer(
              color: Color(0xFF121212),
              backgroundColor: Color(0xFF454545),
              size: Size(double.infinity, 24),
            ),
          ),
          const Divider(color: Color(0xFFA8A6A6))
        ],
      ),
    );
  }
}
