import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/book_history/model/timeblock.dart';

/// Timetable element.
@immutable
final class TimetableItem {
  const TimetableItem({
    required this.id,
    required this.dateAt,
    required this.salonId,
    this.salary,
    this.onWork = false,
    required this.timeblocs,
  });

  /// Employee's ID.
  final int id;

  /// Date when the employee should go to work.
  final DateTime dateAt;

  ///
  final int salonId;

  /// Employee's salary.
  final int? salary;

  /// Indicator whether employee is at work or not.
  final bool onWork;

  final List<EmployeeTimeblock$Response> timeblocs;

  /// Return [TimetableItem] from [json].
  factory TimetableItem.fromJson(Map<String, dynamic> json) => TimetableItem(
        id: json['id'] as int,
        dateAt: DateTime.parse(json['date_at'] as String),
        salonId: json['salon_id'] as int,
        salary: json['salary'] as int?,
        onWork: json['on_work'] as bool,
        timeblocs: List.of(json['timeblocks'])
            .map((e) => EmployeeTimeblock$Response.fromJson(e))
            .toList(),
      );
}
