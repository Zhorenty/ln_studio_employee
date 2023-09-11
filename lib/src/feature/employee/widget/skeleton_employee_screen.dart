import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:ln_employee/src/common/widget/shimmer.dart';
import 'package:ln_employee/src/feature/employee/widget/expanded_app_bar.dart';

class SkeletonEmployeeScreen extends StatelessWidget {
  const SkeletonEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          ExpandedAppBar(
            title: Shimmer(
              size: const Size(200, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
            leading: Shimmer(
              size: const Size(40, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
            trailing: Shimmer(
              size: const Size(40, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
