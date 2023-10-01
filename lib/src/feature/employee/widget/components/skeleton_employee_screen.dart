import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/utils/extensions/context_extension.dart';
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
