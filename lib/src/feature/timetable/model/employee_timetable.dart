import 'package:flutter/foundation.dart';

import 'employee.dart';
import 'timetable_item.dart';

/// Timetable for an employee.
@immutable
final class EmployeeTimetable {
  const EmployeeTimetable({
    required this.employee,
    required this.timetableItems,
  });

  /// Employee's timetable.
  final Employee employee;

  /// List of timetable items.
  final List<TimetableItem> timetableItems;

  /// Returns [EmployeeTimetable] from [json].
  factory EmployeeTimetable.fromJson(Map<String, Object?> json) =>
      EmployeeTimetable(
        employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
        timetableItems: List.from(json['timetables'] as List)
            .map((e) => TimetableItem.fromJson(e))
            .toList(),
      );
}
