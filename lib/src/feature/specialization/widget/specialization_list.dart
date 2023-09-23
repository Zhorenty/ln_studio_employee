import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/widget/shimmer.dart';
import 'package:ln_employee/src/feature/specialization/model/specialization.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/specialization/bloc/specialization_bloc.dart';
import '/src/feature/specialization/bloc/specialization_state.dart';

/// {@template specialization_choice_screen}
/// SpecializationChoiceScreen widget.
/// {@endtemplate}
class SpecializationChoiceScreen extends StatefulWidget {
  /// {@macro specialization_choice_screen}
  const SpecializationChoiceScreen({
    super.key,
    required this.currentSpecialization,
    this.onChanged,
  });

  ///
  final Specialization? currentSpecialization;

  ///
  final void Function(Specialization?)? onChanged;

  @override
  State<SpecializationChoiceScreen> createState() =>
      _SpecializationChoiceScreenState();
}

/// State for widget SpecializationChoiceScreen.
class _SpecializationChoiceScreenState
    extends State<SpecializationChoiceScreen> {
  late final SpecializationBloc specializationBloc;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    specializationBloc = context.read<SpecializationBloc>();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SpecializationBloc, SpecializationState>(
        builder: (context, state) {
          return specializationBloc.state.hasSpecializations
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выберите специализацию',
                        style: context.textTheme.bodyLarge,
                      ),
                      ...specializationBloc.state.specializations.map(
                        (specialization) => _SpecializationChoiceRow(
                          specialization: specialization,
                          currentSpecialization: widget.currentSpecialization,
                          onChanged: (specialization) {
                            widget.onChanged!(specialization);
                            context.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Shimmer();
        },
      );
}

/// {@template specialization_choice_row}
/// _SpecializationChoiceRow widget.
/// {@endtemplate}
class _SpecializationChoiceRow extends StatelessWidget {
  /// {@macro specialization_choice_row}
  const _SpecializationChoiceRow({
    required this.specialization,
    this.currentSpecialization,
    this.onChanged,
  });

  /// Salon with the provided attributes.
  final Specialization specialization;

  /// Specialization that represents the currently selected specialization.
  final Specialization? currentSpecialization;

  /// Callback, called when the [Specialization] selection changes.
  final void Function(Specialization?)? onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Radio<Specialization>(
          value: specialization,
          groupValue: currentSpecialization,
          onChanged: onChanged,
        ),
        title: Text(specialization.name),
        onTap: () => onChanged?.call(specialization),
      );
}
