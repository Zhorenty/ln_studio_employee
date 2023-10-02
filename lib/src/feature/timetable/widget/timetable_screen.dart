import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_employee/src/common/widget/avatar_widget.dart';
import 'package:ln_employee/src/common/widget/pop_up_button.dart';
import 'package:ln_employee/src/feature/salon/widget/salon_choice_screen.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/feature/timetable/bloc/timetable_bloc.dart';
import '/src/feature/timetable/bloc/timetable_event.dart';
import '/src/feature/timetable/bloc/timetable_state.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
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
                  child: SalonChoiceScreen(
                    currentSalon: state.currentSalon,
                  ),
                ),
              ),
            ),
            CupertinoSliverRefreshControl(onRefresh: _refresh),
            if (state.hasTimetables)
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 8,
                  bottom: MediaQuery.sizeOf(context).height / 8,
                ),
                sliver: SliverList.separated(
                  itemCount: state.employeeTimetable.length,
                  itemBuilder: (context, index) {
                    if (index >= _focusedDays.length) {
                      _focusedDays.add(DateTime.now());
                    }
                    final employeeTimetable = state.employeeTimetable[index];
                    final employee = employeeTimetable;

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
                          decoration: ShapeDecoration(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            color: context.colorScheme.onBackground,
                          ),
                          child: Row(
                            children: [
                              AvatarWidget(title: employee.fullName),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  employee.fullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      context.textTheme.headlineSmall!.copyWith(
                                    fontFamily: FontFamily.geologica,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            color: context.colorScheme.onBackground,
                          ),
                          child: CustomTableCalendar(
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
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              )
            else
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    context.stringOf().noEmployees,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.primary,
                      fontFamily: FontFamily.geologica,
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
