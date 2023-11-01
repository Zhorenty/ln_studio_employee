import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetables/timetable_bloc.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetables/timetable_event.dart';
import 'package:ln_employee/src/feature/timetable/bloc/timetables/timetable_state.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/avatar_widget.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';
import '/src/feature/timetable/model/employee_timetable.dart';
import 'components/custom_table_calendar.dart';

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
  final List<DateTime> _selectedDays = [];
  final List<DateTime> _focusedDays = [];

  /// Timetable bloc.
  late final TimetableBloc _timetableBloc;

  @override
  void initState() {
    super.initState();
    _timetableBloc = TimetableBloc(
      repository: DependenciesScope.of(context).timetableRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _timetableBloc,
      child: BlocListener<SalonBLoC, SalonState>(
        listener: (context, state) {},
        listenWhen: (previous, current) {
          if (previous.currentSalon?.id != current.currentSalon?.id) {
            _timetableBloc.add(
              TimetableEvent.fetchBySalonId(current.currentSalon!.id),
            );
          }
          return false;
        },
        child: BlocBuilder<TimetableBloc, TimetableState>(
          builder: (context, state) => CustomScrollView(
            slivers: [
              CustomSliverAppBar(
                title: context.stringOf().workSchedule,
                actions: [
                  IconButton(
                    // TODO: Implement notifications screen.
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ],
                bottomChild: BlocBuilder<SalonBLoC, SalonState>(
                  builder: (context, state) => PopupButton(
                    label: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.currentSalon != null
                          ? Text(state.currentSalon!.name)
                          : const SizedBox(height: 26),
                    ),
                    child: SalonChoiceScreen(currentSalon: state.currentSalon),
                  ),
                ),
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              SliverAnimatedOpacity(
                opacity: state.hasTimetables ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                sliver: SliverPadding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: MediaQuery.sizeOf(context).height / 8,
                  ),
                  sliver: SliverList.separated(
                    itemCount: state.employeeTimetable.length,
                    itemBuilder: (context, index) {
                      final employeeTimetable = state.employeeTimetable[index];
                      final employee = employeeTimetable;

                      ///
                      addFDaysIfNecessary(index);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 8,
                              right: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              color: context.colorScheme.onBackground,
                            ),
                            child: Row(
                              children: [
                                AvatarWidget(title: employee.fullName),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: Text(
                                    employee.fullName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(
                                      fontFamily: FontFamily.geologica,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomTableCalendar(
                            focusedDay: _focusedDays[index],
                            selectedDayPredicate: (day) =>
                                selectedDayPredicate(day, index, employee),
                            onDaySelected: (sel, foc) =>
                                onDaySelected(sel, foc, index, employee.id),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Refresh timetables.
  Future<void> _refresh() async {
    final block = _timetableBloc.stream.first;
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      _timetableBloc.add(
        TimetableEvent.fetchBySalonId(salonBloc.state.currentSalon!.id),
      );
    }
    await block;
  }

  ///
  void addFDaysIfNecessary(int index) {
    if (index >= _focusedDays.length) {
      _focusedDays.add(DateTime.now());
    }
    if (index >= _selectedDays.length) {
      _selectedDays.add(DateTime.now());
    }
  }

  ///
  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    int index,
    int employeeId,
  ) {
    setState(() {
      _selectedDays[index] = selectedDay;
      _focusedDays[index] = focusedDay;
    });

    _timetableBloc.add(
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
    int index,
    EmployeeTimetable employeeTimetable,
  ) {
    isSameDay(_selectedDays[index], day);
    return employeeTimetable.timetableItems.any(
      (timetable) =>
          timetable.dateAt.year == day.year &&
          timetable.dateAt.month == day.month &&
          timetable.dateAt.day == day.day,
    );
  }
}
