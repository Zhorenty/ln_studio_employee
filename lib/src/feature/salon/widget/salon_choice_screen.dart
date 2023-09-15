import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';

import '/src/common/widget/shimmer.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_event.dart';
import '/src/feature/salon/bloc/salon_state.dart';

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
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO(evklidus): Вынести в локаль.
                      Text(
                        'Выберите салон',
                        style: context.textTheme.bodyLarge,
                      ),
                      ...salonBloc.state.data!.map(
                        // TODO(evklidus): Сделать так, чтобы нажатие срабатывало
                        // вдоль всего Row, потому что попадать только по
                        // Radio - заеб.
                        (salon) => SalonChoiceRow(
                          salon: salon,
                          currentSalon: state.currentSalon,
                          onChanged: (salon) {
                            salonBloc.add(SalonEvent.saveCurrent(salon!));
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
