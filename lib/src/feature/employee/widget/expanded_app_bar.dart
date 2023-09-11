import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// TODO: Refactor
class ExpandedAppBar extends StatelessWidget {
  const ExpandedAppBar({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    this.onPressed,
  });

  final Widget title;

  final Widget leading;

  final Widget trailing;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.colorScheme.background,
      surfaceTintColor: context.colorScheme.background,
      toolbarHeight: 180,
      title: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: context.colorScheme.secondary,
          ),
          const SizedBox(height: 8),
          title,
        ],
      ),
      floating: true,
      pinned: true,
      leading: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: IconButton(
            /// TODO: Button "Delete employee here"
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_outlined),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size(300, 68),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  leading,
                  Text(
                    'Кол-во клиентов',
                    style: context.textTheme.titleSmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: const Color(0xFFA8A6A6),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  trailing,
                  Text(
                    'Дней отработано',
                    style: context.textTheme.titleSmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: const Color(0xFFA8A6A6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
