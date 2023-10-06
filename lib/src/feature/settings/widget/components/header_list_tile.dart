import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/widget/animated_button.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_state.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/color_extension.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class HeaderListTile extends StatelessWidget {
  const HeaderListTile({super.key, this.onPressed, this.title});

  ///
  final String? title;

  ///
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.colorScheme.onBackground.lighten(0.04),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Аналитика',
            style: context.textTheme.headlineSmall?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.secondary,
            ),
          ),
          subtitle: BlocBuilder<SalonBLoC, SalonState>(
            builder: (_, state) => Text(
              state.currentSalon!.name,
              style: context.textTheme.titleSmall?.copyWith(
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          trailing: Icon(
            Icons.analytics_rounded,
            color: context.colorScheme.primary,
            size: 50,
          ),
        ),
      ),
    );
  }
}
