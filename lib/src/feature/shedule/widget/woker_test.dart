import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '/src/common/utils/extensions/context_extension.dart';

final List<Worker> workers = [
  Worker(
    employeeId: 1,
    salonId: 2,
    workingDates: [],
  ),
  Worker(
    employeeId: 2,
    salonId: 2,
    workingDates: [],
  ),
  Worker(
    employeeId: 3,
    salonId: 2,
    workingDates: [],
  ),
];

class Worker {
  final int employeeId;
  final int salonId;
  final List<DateTime> workingDates;

  Worker({
    required this.employeeId,
    required this.salonId,
    required this.workingDates,
  });
}

class ScheduleScreenTest extends StatefulWidget {
  const ScheduleScreenTest({super.key});

  @override
  State<ScheduleScreenTest> createState() => _ScheduleScreenTestState();
}

class _ScheduleScreenTestState extends State<ScheduleScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'График работы',
            style: TextStyle(
              fontFamily: 'Playfair',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [],
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee ${workers[index].employeeId}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: context.colors.onBackground,
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    lastDay: DateTime.now().add(const Duration(days: 30)),
                    calendarFormat: CalendarFormat.month,
                    focusedDay: DateTime.now().add(const Duration(days: 1)),
                    selectedDayPredicate: (day) {
                      final workerDates = workers[index].workingDates;
                      return workerDates.any(
                        (date) =>
                            date.year == day.year &&
                            date.month == day.month &&
                            date.day == day.day,
                      );
                    },
                    onDaySelected: (selectedDay, focusedDay) {},
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEEAAFF).withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
