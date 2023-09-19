import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/widget/custom_app_bar.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_state.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/timetable/bloc/timetable_bloc.dart';
import '/src/feature/timetable/bloc/timetable_event.dart';
import '/src/feature/timetable/bloc/timetable_state.dart';

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

  /// Timetable bloc.
  late final TimetableBloc _timetableBloc;

  @override
  void initState() {
    super.initState();
    _timetableBloc = BlocProvider.of<TimetableBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBLoC, SalonState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (previous.currentSalon?.id != current.currentSalon?.id) {
          _timetableBloc
              .add(TimetableEvent.fetchBySalonId(current.currentSalon!.id));
        }
        return false;
      },
      child: BlocBuilder<TimetableBloc, TimetableState>(
        builder: (context, state) => CustomScrollView(
          slivers: [
            CustomSliverAppBar(title: context.stringOf().workShedule),
            CupertinoSliverRefreshControl(onRefresh: _refresh),
            if (state.hasTimetables)
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverList.builder(
                  itemCount: state.employeeTimetable.length,
                  itemBuilder: (context, index) {
                    if (index >= _focusedDays.length) {
                      _focusedDays.add(DateTime.now());
                    }
                    final employeeTimetable = state.employeeTimetable[index];
                    final employee = employeeTimetable;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            '${employee.firstName} ${employee.lastName}',
                            style: context.textTheme.headlineSmall!.copyWith(
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                        ),
                        Container(
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

                            /// TODO: Implement EditScheduleScreen.
                            onDaySelected: (selectedDay, focusedDay) {
                              _focusedDays[index] = selectedDay;

                              _timetableBloc.add(
                                TimetableEvent.fillTimetable(
                                  employeeId: employee.id,
                                  salonId: BlocProvider.of<SalonBLoC>(context)
                                      .state
                                      .currentSalon!
                                      .id,
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
              )
            else
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    context.stringOf().noEmployees,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Refresh timetables.
  Future<void> _refresh() async {
    final block = context.read<TimetableBloc>().stream.first;
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      _timetableBloc.add(
        TimetableEvent.fetchBySalonId(salonBloc.state.currentSalon!.id),
      );
    }
    await block;
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
