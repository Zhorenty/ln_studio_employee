import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_employee/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/employee_timetable/employee_timetable_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/employee_timetable/employee_timetable_event.dart';
import 'package:ln_employee/src/feature/timetable/bloc/employee_timetable/employee_timetable_state.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetables/timetable_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetables/timetable_event.dart';
import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';
import 'package:ln_employee/src/feature/timetable/widget/components/custom_table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class TimetableEmployeeScreen extends StatefulWidget {
  const TimetableEmployeeScreen({
    super.key,
    required this.employeeId,
    required this.salonId,
  });

  ///
  final int employeeId;
  final int salonId;

  @override
  State<TimetableEmployeeScreen> createState() =>
      _TimetableEmployeeScreenState();
}

class _TimetableEmployeeScreenState extends State<TimetableEmployeeScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  late EmployeeTimetableBloc employeeTimetableBloc;

  @override
  void initState() {
    super.initState();
    employeeTimetableBloc = EmployeeTimetableBloc(
      DependenciesScope.of(context).timetableRepository,
    )..add(EmployeeTimetableEvent$FetchTimetable(
        employeeId: widget.employeeId,
        salonId: widget.salonId,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: employeeTimetableBloc,
      child: BlocBuilder<EmployeeTimetableBloc, EmployeeTimetableState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colorScheme.onBackground,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Расписание',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.list(
                    children: [
                      CustomTableCalendar(
                        padding: const EdgeInsets.symmetric(horizontal: 8).add(
                          const EdgeInsets.only(bottom: 8),
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF272727),
                        ),
                        color: context.colorScheme.background,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            selectedDayPredicate(day, state.timetables),
                        onDaySelected: (sel, foc) =>
                            onDaySelected(sel, foc, widget.employeeId),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    int employeeId,
  ) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });

    context.read<TimetableBloc>().add(
          TimetableEvent.fillTimetable(
            employeeId: employeeId,
            salonId: BlocProvider.of<SalonBLoC>(context).state.currentSalon!.id,
            dateAt: selectedDay,
          ),
        );
  }

  ///
  bool selectedDayPredicate(
    DateTime day,
    List<TimetableItem> timetableItems,
  ) {
    isSameDay(_selectedDay, day);
    return timetableItems.any(
      (timetable) =>
          timetable.dateAt.year == day.year &&
          timetable.dateAt.month == day.month &&
          timetable.dateAt.day == day.day,
    );
  }
}
