import 'employee.dart';
import 'timeblock.dart';

class EmployeeTimeBlock {
  Employee employee;
  List<Timetable> timetables;

  EmployeeTimeBlock({required this.employee, required this.timetables});

  factory EmployeeTimeBlock.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeBlock(
      employee: Employee.fromJson(json['employee']),
      timetables: List<Timetable>.from(
          json['timetables'].map((x) => Timetable.fromJson(x))),
    );
  }
}
