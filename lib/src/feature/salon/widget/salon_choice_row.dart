import 'package:flutter/material.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';

/// {@template custom_app_bar}
/// CustomAppBar widget.
/// {@endtemplate}
class SalonChoiceRow extends StatefulWidget {
  /// {@macro custom_app_bar}
  const SalonChoiceRow({
    super.key,
    required this.salon,
    this.currentSalon,
    this.onChanged,
  });

  final Salon salon;
  final Salon? currentSalon;
  final void Function(Salon?)? onChanged;

  @override
  State<SalonChoiceRow> createState() => _SalonChoiceRowState();
}

class _SalonChoiceRowState extends State<SalonChoiceRow> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Radio<Salon>(
            value: widget.salon,
            groupValue: widget.currentSalon,
            onChanged: widget.onChanged,
          ),
          Text(widget.salon.address),
        ],
      );
}
