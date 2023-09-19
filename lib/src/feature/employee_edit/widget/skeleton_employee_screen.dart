import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/header.dart';
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
            onExit: () => context.pop(),
            title: const Shimmer(
              speed: 30,
              size: Size(200, 28),
              color: Color(0xFF121212),
              backgroundColor: Color(0xFF454545),
            ),
            leading: const Shimmer(
              speed: 30,
              size: Size(40, 28),
              color: Color(0xFF121212),
              backgroundColor: Color(0xFF454545),
            ),
            trailing: const Shimmer(
              speed: 30,
              size: Size(40, 28),
              color: Color(0xFF121212),
              backgroundColor: Color(0xFF454545),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderWidget(label: 'Рейтинг'),
                          Shimmer(
                            size: Size(128, 25),
                            color: Color.fromARGB(255, 20, 20, 18),
                            backgroundColor: Color(0xFF525252),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 + 8),
                      HeaderWidget(label: 'Личная информация'),
                      _CustomShimmer(label: 'Имя', dense: true),
                      _CustomShimmer(label: 'Фамилия'),
                      _CustomShimmer(label: 'Номер телефона'),
                      _CustomShimmer(label: 'Домашний адрес'),
                      _CustomShimmer(label: 'Электронная почта'),
                      HeaderWidget(label: 'Рабочая информация'),
                      _CustomShimmer(label: 'Номер договора', dense: true),
                      _CustomShimmer(label: 'Описание сотрудника'),
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

class _CustomShimmer extends StatelessWidget {
  const _CustomShimmer({required this.label, this.dense = false});

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
