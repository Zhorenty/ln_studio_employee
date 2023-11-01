import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ln_employee/src/common/widget/picker_popup.dart';

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
    this.label,
    this.additionalTrailing = const <Widget>[],
    this.onExit,
  });

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

  /// Callback, called when icon is pressed.
  final void Function()? onExit;

  @override
  State<ExpandedAppBar> createState() => _ExpandedAppBarState();
}

class _ExpandedAppBarState extends State<ExpandedAppBar> {
  File? image;

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
            avatar: image,
            title: widget.label,
            isLabelVisible: true,
            onBadgeTap: () => MessagePopup.bottomSheet(
              context,
              'Выберите источник фото',
              additional: [
                PickerPopup(
                  onPickCamera: () => pickImage(ImageSource.camera),
                  onPickGallery: () => pickImage(ImageSource.gallery),
                ),
              ],
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }
}
