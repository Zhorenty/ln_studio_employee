import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_event.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import '/src/common/widget/overlay/modal_popup.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';

/// Custom-styled [SliverAppBar].
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions = const <Widget>[],
  });

  /// Primary widget displayed in the [CustomSliverAppBar].
  final String? title;

  /// List of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final salonBloc = context.read<SalonBLoC>();

    return SliverAppBar(
      centerTitle: false,
      title: title != null
          ? Text(
              title!,
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colorScheme.primary,
                fontFamily: FontFamily.geologica,
              ),
            )
          : null,
      actions: actions,
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
                  : Shimmer(backgroundColor: context.colorScheme.onBackground),
              // TODO(zhorenty): Move widget deeper.
              child: SalonChoiceScreen(
                onChanged: (salon) {
                  salonBloc.add(SalonEvent.saveCurrent(salon!));
                  context.pop();
                },
              ),
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
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 + 4),
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
