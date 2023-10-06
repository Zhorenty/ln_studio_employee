import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/common/widget/custom_text_field.dart';

/// Custom [ElevatedButton] with provided [showDatePicker] method.
class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.initialDate,
    required this.label,
    this.controller,
    this.onDateSelected,
    this.validator,
  });

  ///
  final TextEditingController? controller;

  /// Initial [DateTime].
  final DateTime initialDate;

  /// Callback, called when day was selected
  final Function(DateTime)? onDateSelected;

  /// Label of this [DatePickerField].
  final String label;

  ///
  final String? Function(String?)? validator;

  @override
  DatePickerFieldState createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
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
      child: CustomTextField(
        enabled: false,
        controller: widget.controller,
        label: widget.label,
        validator: widget.validator,
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
      widget.controller?.text = selectedDate.defaultFormat();
    }
  }
}
