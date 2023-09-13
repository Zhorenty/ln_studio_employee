import 'package:flutter/material.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// TODO(zhorenty): Redesign widget.
/// Custom [ElevatedButton] with provided [showDatePicker] method.
class DatePickerButton extends StatefulWidget {
  const DatePickerButton({
    super.key,
    required this.initialDate,
    this.onDateSelected,
  });

  /// Initial [DateTime].
  final DateTime initialDate;

  /// Callback, called when day was selected
  final Function(DateTime)? onDateSelected;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Выберите дату'),
        ),
        Text('Выбранная дата: ${selectedDate.format()}'),
      ],
    );
  }

  ///
  Future<void> _selectDate(BuildContext context) async {
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
