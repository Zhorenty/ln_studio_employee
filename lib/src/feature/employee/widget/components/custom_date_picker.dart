import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/utils/extensions/date_time_extension.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// Custom [ElevatedButton] with provided [showDatePicker] method.
class DatePickerButton extends StatefulWidget {
  const DatePickerButton({
    super.key,
    required this.initialDate,
    this.onDateSelected,
    required this.label,
    this.dense = true,
  });

  /// Initial [DateTime].
  final DateTime initialDate;

  /// Callback, called when day was selected
  final Function(DateTime)? onDateSelected;

  /// Indicator whether this [DatePickerButton] should be densed.
  final bool dense;

  /// Label of this [DatePickerButton].
  final String label;

  @override
  DatePickerButtonState createState() => DatePickerButtonState();
}

class DatePickerButtonState extends State<DatePickerButton> {
  /// Initial or selected [DateTime].
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(),
      child: Padding(
        padding: EdgeInsets.only(top: widget.dense ? 12 : 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.primary,
                fontFamily: FontFamily.geologica,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate.defaultFormat().toString(),
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 4 + 2, bottom: 8),
                  child: Icon(Icons.calendar_month, size: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          useMaterial3: true,
          primaryColor: context.colorScheme.primary,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.dark(primary: context.colorScheme.primary)
              .copyWith(secondary: context.colorScheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      widget.onDateSelected?.call(selectedDate);
    }
  }
}
