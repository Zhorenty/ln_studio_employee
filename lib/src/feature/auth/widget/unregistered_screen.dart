import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class UnregisteredScreen extends StatelessWidget {
  const UnregisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: Center(
        child: Text(
          'Данный номер не зарегистрирован',
          style: context.textTheme.headlineSmall?.copyWith(
            fontFamily: FontFamily.geologica,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
