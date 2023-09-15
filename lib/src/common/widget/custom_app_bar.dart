import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/shimmer.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';

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
            builder: (context, state) => PopupButton(
              label: state.currentSalon != null
                  ? Text(state.currentSalon!.name)
                  : const Shimmer(),
              child: const SalonChoiceScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Container with [ModalPopup.show] method.
class PopupButton extends StatelessWidget {
  const PopupButton({super.key, required this.child, this.label});

  /// Label of this [PopupButton].
  final Widget? label;

  /// Widget of this [PopupButton].
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => ModalPopup.show(context: context, child: child),
        child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DefaultTextStyle(
            style: context.textTheme.titleMedium!.copyWith(
              fontSize: 17,
              color: context.colorScheme.onBackground,
              fontFamily: FontFamily.geologica,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null) label!,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colorScheme.onBackground,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      );
}
