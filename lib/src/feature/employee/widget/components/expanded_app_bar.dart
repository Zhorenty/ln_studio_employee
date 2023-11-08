import 'dart:io';

import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/avatar_widget.dart';
import '/src/common/widget/overlay/message_popup.dart';

/// Custom-styled expanded [SliverAppBar].
class ExpandedAppBar extends StatefulWidget {
  const ExpandedAppBar({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    this.imageUrl,
    this.avatar,
    this.label,
    this.additional = const <Widget>[],
    this.additionalTrailing = const <Widget>[],
    this.onExit,
  });

  final File? avatar;

  final String? imageUrl;

  ///
  final String? label;

  /// Primary widget displayed in the app bar under the [CircleAvatar].
  final Widget title;

  /// Leading widget of this [ExpandedAppBar].
  final Widget leading;

  /// Trailing widget of this [ExpandedAppBar].
  final Widget trailing;

  /// Additional trailing widgets.
  final List<Widget> additionalTrailing;

  final List<Widget> additional;

  /// Callback, called when icon is pressed.
  final void Function()? onExit;

  @override
  State<ExpandedAppBar> createState() => _ExpandedAppBarState();
}

class _ExpandedAppBarState extends State<ExpandedAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.colorScheme.background,
      surfaceTintColor: context.colorScheme.background,
      toolbarHeight: 180,
      centerTitle: true,
      title: Column(
        children: [
          AvatarWidget(
            radius: 60,
            avatar: widget.avatar,
            imageUrl: widget.imageUrl,
            title: widget.label,
            isLabelVisible: true,
            onBadgeTap: () => MessagePopup.bottomSheet(
              context,
              'Выберите источник фото',
              additional: widget.additional,
            ),
          ),
          const SizedBox(height: 8),
          widget.title,
        ],
      ),
      floating: true,
      pinned: true,
      leading: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          padding: const EdgeInsets.only(top: 28),
          onPressed: widget.onExit,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: context.colorScheme.secondary,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: IconButton(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: context.colorScheme.secondary,
            ),
            highlightColor: context.colorScheme.scrim,
            onPressed: () => MessagePopup.bottomSheet(
              context,
              'Действия с сотрудником',
              scrolled: false,
              additional: widget.additionalTrailing,
            ),
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
                  widget.leading,
                  Text(
                    context.stringOf().amountOfClients,
                    style: context.textTheme.titleSmall!.copyWith(
                      color: const Color(0xFFA8A6A6),
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  widget.trailing,
                  Text(
                    context.stringOf().daysWorkedOut,
                    style: context.textTheme.titleSmall!.copyWith(
                      color: const Color(0xFFA8A6A6),
                      fontFamily: FontFamily.geologica,
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
