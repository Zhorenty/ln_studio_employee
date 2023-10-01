import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ln_employee/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_employee/src/common/utils/extensions/context_extension.dart';
import 'package:table_calendar/table_calendar.dart';

/// Custom [TableCalendar] widget.
class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({
    super.key,
    required this.focusedDay,
    this.selectedDayPredicate,
    this.onDaySelected,
  });

  /// Focused day.
  final DateTime focusedDay;

  /// Deciding whether given day should be marked as selected.
  final bool Function(DateTime)? selectedDayPredicate;

  /// Called whenever any day gets tapped.
  final void Function(DateTime, DateTime)? onDaySelected;

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfPreviousMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      1,
    );
    DateTime lastDayOfNextMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month + 2,
      0,
    );

    return TableCalendar(
      locale: 'ru_RU',
      availableGestures:
          kIsWeb ? AvailableGestures.none : AvailableGestures.horizontalSwipe,
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: firstDayOfPreviousMonth,
      lastDay: lastDayOfNextMonth,
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: selectedDayPredicate,
      onDaySelected: onDaySelected,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: context.textTheme.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: context.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.onBackground,
        ),
        selectedTextStyle: context.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.background,
        ),
        defaultTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
        ),
        holidayTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
        ),
        weekendTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.primaryContainer,
        ),
        outsideTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.primaryContainer,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.scrim,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.scrim,
        ),
        holidayDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.scrim,
        ),
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.scrim,
        ),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.primary,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }
}
