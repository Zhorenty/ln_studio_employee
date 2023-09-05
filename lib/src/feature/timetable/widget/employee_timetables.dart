import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/timetable/bloc/timetable_bloc.dart';
import '/src/feature/timetable/bloc/timetable_event.dart';
import '/src/feature/timetable/bloc/timetable_state.dart';
import '/src/feature/timetable/model/fill_time_blocks.dart';

/// {@template employee_timetables_widget}
/// Employee timetables widget.
/// {@endtemplate}
class EmployeeTimetables extends StatefulWidget {
  /// {@macro employee_timetables_widget}
  const EmployeeTimetables({super.key});

  @override
  EmployeeTimetablesState createState() => EmployeeTimetablesState();
}

/// State for [EmployeeTimetables] maintaining [_focusedDays].
class EmployeeTimetablesState extends State<EmployeeTimetables> {
  final List<DateTime> _focusedDays = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) => Expanded(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: state.employeeTimetable.length,
              itemBuilder: (context, index) {
                if (index >= _focusedDays.length) {
                  _focusedDays.add(DateTime.now());
                }
                final employeeTimetable = state.employeeTimetable[index];
                final employee = employeeTimetable.employee;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: index == 0 ? 26 : 0,
                      ),
                      child: Text(
                        '${employee.firstName} ${employee.lastName}',
                        style: context.fonts.headlineSmall!.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colors.onBackground,
                      ),
                      child: _CustomTableCalendar(
                        focusedDay: _focusedDays[index],
                        selectedDayPredicate: (day) {
                          return employeeTimetable.timetableItems.any(
                            (timetable) =>
                                timetable.dateAt.year == day.year &&
                                timetable.dateAt.month == day.month &&
                                timetable.dateAt.day == day.day,
                          );
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          final fillTimetable = FillTimetable(
                            employeeId: employee.id,
                            salonId: 1,
                            dateAt: selectedDay,
                          );
                          _focusedDays[index] = selectedDay;

                          final timetableBloc =
                              BlocProvider.of<TimetableBloc>(context);
                          timetableBloc.add(
                            TimetableEvent.fillTimetable(fillTimetable),
                          );
                        },
                      ),
                    ),
                    Divider(color: context.colors.onBackground)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom [TableCalendar] widget.
class _CustomTableCalendar extends StatelessWidget {
  const _CustomTableCalendar({
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
      0,
    );
    DateTime lastDayOfNextMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month + 2,
      0,
    );

    return TableCalendar(
      locale: 'ru_RU',
      availableGestures: AvailableGestures.none,
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
        titleTextStyle: context.fonts.bodyLarge!.copyWith(
          fontFamily: FontFamily.geologica,
        ),
      ),
      calendarStyle: CalendarStyle(
        cellMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        todayTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
          color: context.colors.onBackground,
        ),
        selectedTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
          color: context.colors.background,
        ),
        defaultTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
        ),
        holidayTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
        ),
        weekendTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          color: Colors.grey,
        ),
        outsideTextStyle: context.fonts.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          color: Colors.grey,
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
        ),
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
        ),
        holidayDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
        ),
        outsideDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
        ),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: context.colors.primary,
        ),
        todayDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.secondary,
        ),
      ),
    );
  }
}
