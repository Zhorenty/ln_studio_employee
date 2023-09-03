import 'package:ln_employee/src/feature/shedule/model/timetable.dart';

class EmployeeTimeBlock {
  const EmployeeTimeBlock({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.timeTables,
  });

  final int employeeId;
  final String firstName;
  final String lastName;
  final List<Timetable> timeTables;

  factory EmployeeTimeBlock.fromJson(Map<String, Object?> json) =>
      EmployeeTimeBlock(
        employeeId: json['employee_id'] as int,
        firstName: json['first_name'] as String,
        lastName: json['second_name'] as String,
        timeTables: List.from(json['time_tables'] as List)
            .map((e) => Timetable.fromJson(e))
            .toList(),
      );
}
