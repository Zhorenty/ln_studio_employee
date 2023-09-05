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

class EmployeeTimetablesState extends State<EmployeeTimetables> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) => ListView.builder(
        itemCount: state.employeeTimetable.length,
        itemBuilder: (context, index) {
          final employee = state.employeeTimetable[index].employee;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                child: Text(
                  '${employee.firstName} ${employee.lastName}',
                  style: context.fonts.headlineSmall!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.onBackground,
                ),
                child: TableCalendar(
                  locale: 'ru_RU',
                  firstDay: DateTime.now().subtract(const Duration(days: 30)),
                  lastDay: DateTime.now().add(const Duration(days: 30)),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) {
                    return state.employeeTimetable[index].timetableItems.any(
                      (timetable) =>
                          timetable.dateAt.year == day.year &&
                          timetable.dateAt.month == day.month &&
                          timetable.dateAt.day == day.day,
                    );
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    // TODO(evklidus): Проверять не нажата ли уже дата
                    final fillTimetable = FillTimetable(
                      employeeId: employee.id,
                      // TODO(evklidus): Подставлять реальный salonId
                      salonId: 1,
                      dates: [selectedDay],
                    );
                    final timetableBloc =
                        BlocProvider.of<TimetableBloc>(context);
                    timetableBloc.add(
                      TimetableEvent.fillTimetables(
                        [fillTimetable],
                      ),
                    );
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: context.fonts.bodyLarge!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    todayTextStyle: context.fonts.titleSmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedTextStyle: context.fonts.titleSmall!.copyWith(
                      fontFamily: FontFamily.geologica,
                      fontWeight: FontWeight.bold,
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
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color(0xFFEEAAFF).withOpacity(.5),
                    ),
                    todayDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFEEAAFF).withOpacity(.5),
                    ),
                  ),
                ),
              ),
              Divider(color: context.colors.onBackground)
            ],
          );
        },
      ),
    );
  }
}
