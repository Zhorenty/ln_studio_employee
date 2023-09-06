import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/timetable/bloc/timetable_bloc.dart';
import '/src/feature/timetable/bloc/timetable_event.dart';
import '/src/feature/timetable/bloc/timetable_state.dart';
import '/src/feature/timetable/widget/salon_choice_widget.dart';

/// {@template timetable_screen}
/// Timetable screen.
/// {@endtemplate}
class TimetableScreen extends StatefulWidget {
  /// {@macro timetable_screen}
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final List<DateTime> _focusedDays = [];

  late final TimetableBloc _timetableBloc;

  @override
  void initState() {
    super.initState();
    _timetableBloc = BlocProvider.of<TimetableBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) => CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(
              'График работы',
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colorScheme.primary,
                fontFamily: FontFamily.geologica,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: context.colorScheme.primary,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
            floating: true,
            pinned: true,
            stretch: true,
            bottom: const PreferredSize(
              preferredSize: Size(300, 70),
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: SalonChoiceWidget(),
              ),
            ),
          ),
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
                      style: context.textTheme.headlineSmall!.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colorScheme.onBackground,
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
                        _focusedDays[index] = selectedDay;

                        _timetableBloc.add(
                          TimetableEvent.fillTimetable(
                            employeeId: employee.id,
                            salonId: 1,
                            dateAt: selectedDay,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ],
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
          kIsWeb ? AvailableGestures.none : AvailableGestures.all,
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
        cellMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        todayTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
          color: context.colorScheme.onBackground,
        ),
        selectedTextStyle: context.textTheme.titleSmall!.copyWith(
          fontFamily: FontFamily.geologica,
          fontWeight: FontWeight.bold,
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
          color: Colors.grey,
        ),
        outsideTextStyle: context.textTheme.titleSmall!.copyWith(
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
          color: context.colorScheme.primary,
        ),
        todayDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }
}
