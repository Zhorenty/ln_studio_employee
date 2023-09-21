import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/specialization/bloc/specialization_bloc.dart';
import '/src/feature/specialization/bloc/specialization_state.dart';

///
class SpecializationWrap extends StatefulWidget {
  const SpecializationWrap({super.key});

  @override
  State<SpecializationWrap> createState() => _SpecializationWrapState();
}

class _SpecializationWrapState extends State<SpecializationWrap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecializationBloc, SpecializationState>(
      builder: (context, state) => Wrap(
        children: [
          ...state.specializations.map(
            (specialization) => Chip(
              backgroundColor: context.colorScheme.primary,
              label: Text(
                specialization.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onBackground,
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
