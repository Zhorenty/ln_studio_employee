import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_state.dart';
import 'package:ln_employee/src/feature/salon/widget/salon_choice_screen.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';

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
        AnimatedButton(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(
            Icons.notifications_rounded,
            color: context.colorScheme.primary,
          ),
          // TODO(zhorenty): Implement NotificationsScreen.
          onPressed: () {},
        ),
      ],
      floating: true,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size(300, 62),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BlocBuilder<SalonBLoC, SalonState>(
            builder: (context, state) => _GesturedContainer(
              label: state.currentSalon?.address ?? 'ул. Степана Разина, д. 72',
              child: const SalonChoiceScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Container with [GestureDetector].
class _GesturedContainer extends StatelessWidget {
  const _GesturedContainer({
    required this.label,
    required this.child,
  });

  /// Label of this [_GesturedContainer].
  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          /// TODO(zhorenty): Move into separate widget
          ModalPopup.show(
            context: context,
            child: child,
          );
        },
        child: Container(
          height: 50,
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 17,
                    color: context.colorScheme.onBackground,
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.colorScheme.onBackground,
                size: 18,
              ),
            ],
          ),
        ),
      );
}
