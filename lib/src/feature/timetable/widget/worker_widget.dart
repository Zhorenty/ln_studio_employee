import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '../bloc/timetable_bloc.dart';
import '../bloc/timetable_state.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.colors.background,
        body: ListView.builder(
          itemCount: state.timetables.length,
          itemBuilder: (context, index) {
            final employee = state.timetables[index].employee;

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
                  margin: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 8,
                    top: 0,
                  ),
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
                      return state.timetables[index].timetableItems.any(
                        (timetable) =>
                            timetable.dateAt.year == day.year &&
                            timetable.dateAt.month == day.month &&
                            timetable.dateAt.day == day.day,
                      );
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      print('ЭРИК КОЛЛБЭК ТУТ');
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

                      selectedDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFEEAAFF).withOpacity(.5),
                      ),
                      // todayDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10),
                      //   color: const Color(0xFFEEAAFF).withOpacity(.5),
                      // ),
                    ),
                  ),
                ),
                Divider(color: context.colors.onBackground)
              ],
            );
          },
        ),
      ),
    );
  }
}
