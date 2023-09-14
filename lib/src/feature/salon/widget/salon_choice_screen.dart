import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/widget/shimmer.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_event.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_state.dart';

import 'salon_choice_row.dart';

/// {@template salon_choice_screen}
/// SalonChoiceScreen widget.
/// {@endtemplate}
class SalonChoiceScreen extends StatefulWidget {
  /// {@macro salon_choice_screen}
  const SalonChoiceScreen({super.key});

  @override
  State<SalonChoiceScreen> createState() => _SalonChoiceScreenState();
}

/// State for widget SalonChoiceScreen.
class _SalonChoiceScreenState extends State<SalonChoiceScreen> {
  late final SalonBLoC salonBloc;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    salonBloc = context.read<SalonBLoC>()..add(const SalonEvent.fetchAll());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SalonBLoC, SalonState>(
        listener: (context, state) {
          if (state.currentSalon == null && salonBloc.state.hasData) {
            salonBloc.add(SalonEvent.saveCurrent(salonBloc.state.data!.first));
          }
        },
        builder: (context, state) {
          return salonBloc.state.hasData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Выберите салон'),
                    ...salonBloc.state.data!.map(
                      (salon) => SalonChoiceRow(
                        salon: salon,
                        currentSalon: state.currentSalon,
                        onChanged: (salon) =>
                            salonBloc.add(SalonEvent.saveCurrent(salon!)),
                      ),
                    ),
                    // TODO: Сделать pop на выбор или на кнопку ok
                  ],
                )
              : const Shimmer();
        },
      );
}
