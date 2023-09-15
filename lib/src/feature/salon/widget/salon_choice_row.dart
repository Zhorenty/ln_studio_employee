import 'package:flutter/material.dart';
import '/src/feature/salon/models/salon.dart';

/// {@template salon_choice_row}
/// SalonChoiceRow widget.
/// {@endtemplate}
class SalonChoiceRow extends StatelessWidget {
  /// {@macro salon_choice_row}
  const SalonChoiceRow({
    super.key,
    required this.salon,
    this.currentSalon,
    this.onChanged,
  });

  ///
  final Salon salon;

  ///
  final Salon? currentSalon;

  ///
  final void Function(Salon?)? onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Radio<Salon>(
          value: salon,
          groupValue: currentSalon,
          onChanged: onChanged,
        ),
        title: Text(salon.name),
        onTap: () => onChanged?.call(salon),
      );
}
