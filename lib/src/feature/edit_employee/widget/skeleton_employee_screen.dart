import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/widget/header.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import 'components/expanded_app_bar.dart';

class SkeletonEmployeeScreen extends StatelessWidget {
  const SkeletonEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          ExpandedAppBar(
            title: Shimmer(
              speed: 30,
              size: const Size(200, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
            leading: Shimmer(
              speed: 30,
              size: const Size(40, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
            ),
            trailing: Shimmer(
              speed: 30,
              size: const Size(40, 28),
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderWidget(label: 'Рейтинг'),
                          Shimmer(
                            size: const Size(128, 25),
                            color: context.colorScheme.primary,
                            backgroundColor: const Color(0xFF525252),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16 + 8),
                      const HeaderWidget(label: 'Личная информация'),
                      const CustomShimmer(label: 'Имя', dense: true),
                      const CustomShimmer(label: 'Фамилия'),
                      const CustomShimmer(label: 'Номер телефона'),
                      const CustomShimmer(label: 'Домашний адрес'),
                      const CustomShimmer(label: 'Электронная почта'),
                      const HeaderWidget(label: 'Рабочая информация'),
                      const CustomShimmer(label: 'Номер договора', dense: true),
                      const CustomShimmer(label: 'Описание сотрудника'),
                    ],
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

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.label,
    this.dense = false,
  });

  final bool dense;

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
          Padding(
            padding: const EdgeInsets.only(right: 64),
            child: Shimmer(
              color: const Color(0xFF525252),
              backgroundColor: context.colorScheme.primaryContainer,
              size: const Size(double.infinity, 24),
            ),
          ),
          const Divider(color: Color(0xFFA8A6A6))
        ],
      ),
    );
  }
}
