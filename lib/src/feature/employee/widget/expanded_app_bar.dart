import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';

/// Custom-styled expanded [SliverAppBar].
class ExpandedAppBar extends StatelessWidget {
  const ExpandedAppBar({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    this.onExit,
  });

  /// Primary widget displayed in the app bar under the [CircleAvatar].
  final Widget title;

  /// Leading widget of this [ExpandedAppBar].
  final Widget leading;

  /// Trailing widget of this [ExpandedAppBar].
  final Widget trailing;

  /// Callback, called when icon is pressed.
  final void Function()? onExit;

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
            onPressed: onExit,
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: AnimatedButton(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.notifications_rounded,
              color: context.colorScheme.primary,
            ),

            /// TODO(zhorenty): Button "Delete employee here"
            onPressed: () {},
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
                    context.stringOf().amountOfClients,
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
                    context.stringOf().daysWorkedOut,
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
