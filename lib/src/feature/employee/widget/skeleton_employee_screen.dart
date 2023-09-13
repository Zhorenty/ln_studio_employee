import 'package:flutter/material.dart';

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
                          const _Header(label: 'Рейтинг'),
                          Shimmer(
                            size: const Size(128, 25),
                            color: context.colorScheme.primary,
                            backgroundColor: const Color(0xFF525252),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16 + 8),
                      const _Header(label: 'Личная информация'),
                      const _UnderscoreWidget(),
                      const CustomShimmer(label: 'Имя', dense: true),
                      const CustomShimmer(label: 'Фамилия'),
                      const CustomShimmer(label: 'Номер телефона'),
                      const CustomShimmer(label: 'Домашний адрес'),
                      const CustomShimmer(label: 'Электронная почта'),
                      const _Header(label: 'Рабочая информация'),
                      const _UnderscoreWidget(),
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

/// Horizontal line.
///
/// Usually used for underscores.
class _UnderscoreWidget extends StatelessWidget {
  const _UnderscoreWidget();

  @override
  Widget build(BuildContext context) => Container(
        height: 3,
        width: 50,
        decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
      );
}

/// Header widget with provided [label].
class _Header extends StatelessWidget {
  const _Header({required this.label});

  /// Label of this [_Header].
  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
      );
}
