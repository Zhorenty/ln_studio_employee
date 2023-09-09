import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/timetable/widget/gestured_container.dart';

/// Custom-styled [SliverAppBar].
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.title});

  /// Primary widget displayed in the app bar.
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      title: Text(
        title,
        style: context.textTheme.titleLarge!.copyWith(
          color: context.colorScheme.primary,
          fontFamily: FontFamily.geologica,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_rounded,
            color: context.colorScheme.primary,
          ),
          // TODO: Implement NotificationsScreen
          onPressed: () {},
        ),
      ],
      floating: true,
      pinned: true,
      bottom: const PreferredSize(
        preferredSize: Size(300, 62),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12),
          // TODO: Fetch salon from backend.
          child: GesturedContainer(label: 'ул. Степана Разина, д. 72'),
        ),
      ),
    );
  }
}
