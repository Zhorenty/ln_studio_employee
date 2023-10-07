import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/specialization/bloc/specialization_bloc.dart';
import '/src/feature/specialization/bloc/specialization_event.dart';
import '/src/feature/specialization/bloc/specialization_state.dart';
import '/src/feature/specialization/model/specialization.dart';

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

  @override
  void initState() {
    super.initState();
    specializationBloc = SpecializationBloc(
      repository: DependenciesScope.of(context).specializationRepository,
    )..add(const SpecializationEvent.fetchAll());
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => specializationBloc,
        child: BlocBuilder<SpecializationBloc, SpecializationState>(
          builder: (context, state) {
            return state.hasSpecializations
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выберите должность',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        ...state.specializations.map(
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
        ),
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListTile(
          selected: specialization == currentSpecialization,
          selectedTileColor: context.colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: specialization == currentSpecialization
                ? const BorderSide(color: Color(0xFF272727))
                : BorderSide(color: context.colorScheme.scrim),
          ),
          contentPadding: const EdgeInsets.only(left: 12),
          trailing: Radio<Specialization>(
            value: specialization,
            groupValue: currentSpecialization,
            onChanged: onChanged,
          ),
          title: Text(
            specialization.name,
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          subtitle: Text(
            'Оклад: ${specialization.oklad}₽',
            style: context.textTheme.bodySmall?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          onTap: () => onChanged?.call(specialization),
        ),
      );
}
