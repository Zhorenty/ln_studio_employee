import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';

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
    this.suffix,
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
  final Widget? suffix;

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
        suffix: widget.suffix,
        labelStyle: context.textTheme.bodyLarge!.copyWith(
          color: context.colorScheme.primaryContainer,
          fontFamily: FontFamily.geologica,
        ),
      ),
    );
  }

  ///
  Future<void> _selectDate() async {
    DateTime? picked;
    Platform.isIOS
        ? await showCupertinoModalPopup(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.sizeOf(context).height * 0.35,
                color: context.colorScheme.onBackground,
                padding: const EdgeInsets.only(bottom: 30, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) => picked = value,
                        initialDateTime: selectedDate,
                        minimumYear: 2000,
                        maximumYear: DateTime.now().year + 1,
                      ),
                    ),
                    FilledButton(
                      onPressed: context.pop,
                      child: const Text('Готово'),
                    )
                  ],
                ),
              );
            },
          )
        : picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            builder: (context, child) => Theme(
              data: ThemeData.dark().copyWith(
                primaryColor: context.colorScheme.primary,
                buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
                colorScheme:
                    ColorScheme.dark(primary: context.colorScheme.primary)
                        .copyWith(secondary: context.colorScheme.primary),
              ),
              child: child!,
            ),
          );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked!);
      widget.onDateSelected?.call(selectedDate);
      widget.controller?.text = selectedDate.defaultFormat();
    }
  }
}
