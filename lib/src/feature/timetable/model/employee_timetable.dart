import 'employee.dart';
import 'timetable_item.dart';

///
class EmployeeTimetable {
  const EmployeeTimetable({
    required this.employee,
    required this.timetableItems,
  });

  ///
  final Employee employee;

  ///
  final List<TimetableItem> timetableItems;

  ///
  factory EmployeeTimetable.fromJson(Map<String, Object?> json) =>
      EmployeeTimetable(
        employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
        timetableItems: List.from(json['timetables'] as List)
            .map((e) => TimetableItem.fromJson(e))
            .toList(),
      );
}
