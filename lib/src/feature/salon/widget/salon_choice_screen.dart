import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_event.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/models/salon.dart';

/// {@template salon_choice_screen}
/// SalonChoiceScreen widget.
/// {@endtemplate}
class SalonChoiceScreen extends StatefulWidget {
  /// {@macro salon_choice_screen}
  const SalonChoiceScreen({
    super.key,
    required this.currentSalon,
    this.onChanged,
  });

  ///
  final Salon? currentSalon;

  ///
  final void Function(Salon?)? onChanged;

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
  Widget build(BuildContext context) => BlocBuilder<SalonBLoC, SalonState>(
        builder: (context, state) => salonBloc.state.hasData
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Выберите салон',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    ...salonBloc.state.data!.map(
                      (salon) => _SalonChoiceRow(
                        salon: salon,
                        currentSalon: widget.currentSalon,
                        onChanged: (salon) {
                          if (widget.onChanged == null) {
                            salonBloc.add(SalonEvent.saveCurrent(salon!));
                          } else {
                            setState(() => widget.onChanged!(salon));
                          }
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Shimmer(),
      );
}

/// {@template salon_choice_row}
/// _SalonChoiceRow widget.
/// {@endtemplate}
class _SalonChoiceRow extends StatelessWidget {
  /// {@macro salon_choice_row}
  const _SalonChoiceRow({
    required this.salon,
    this.currentSalon,
    this.onChanged,
  });

  /// Salon with the provided attributes.
  final Salon salon;

  /// Salon that represents the currently selected salon.
  final Salon? currentSalon;

  /// Callback, called when the [Salon] selection changes.
  final void Function(Salon?)? onChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListTile(
          selected: salon == currentSalon,
          selectedTileColor: context.colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: salon == currentSalon
                ? const BorderSide(color: Color(0xFF272727))
                : BorderSide(color: context.colorScheme.scrim),
          ),
          contentPadding: const EdgeInsets.only(left: 12),
          trailing: Radio<Salon>(
            value: salon,
            groupValue: currentSalon,
            onChanged: onChanged,
          ),
          title: Text(
            salon.name,
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          onTap: () => onChanged?.call(salon),
        ),
      );
}
