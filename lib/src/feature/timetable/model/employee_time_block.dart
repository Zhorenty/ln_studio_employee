import 'employee.dart';
import 'timeblock.dart';

class EmployeeTimeBlock {
  final Employee employee;
  final List<TimeBlock> timetables;

  EmployeeTimeBlock({required this.employee, required this.timetables});

  factory EmployeeTimeBlock.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeBlock(
      employee: Employee.fromJson(json['employee']),
      timetables: (json['timetables'] as List<dynamic>)
          .map((e) => TimeBlock.fromJson(e))
          .toList(),
    );
  }
}
