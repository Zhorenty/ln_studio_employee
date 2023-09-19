import 'package:flutter/foundation.dart';

import 'timetable_item.dart';

/// Timetable for an employee.
@immutable
final class EmployeeTimetable {
  const EmployeeTimetable({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.timetableItems,
    required this.salonId,
  });

  /// Employee's ID
  final int id;

  /// Employee's first name
  final String firstName;

  /// Employee's last name
  final String lastName;

  final int salonId;

  /// List of timetable items.
  final List<TimetableItem> timetableItems;

  /// Returns [EmployeeTimetable] from [json].
  factory EmployeeTimetable.fromJson(Map<String, Object?> json) =>
      EmployeeTimetable(
        id: json['id'] as int,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        salonId: json['salon_id'] as int,
        timetableItems: List.from(json['timetables'] as List)
            .map((e) => TimetableItem.fromJson(e))
            .toList(),
      );
}
