import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/overlay/message_popup.dart';

///
class CopyIcon extends StatelessWidget {
  const CopyIcon(this.text, {super.key});

  /// Text to copy.
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      child: Icon(
        Icons.copy,
        color: context.colorScheme.primary,
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        MessagePopup.success(context, 'Скопировано');
      },
    );
  }
}
