import 'package:flutter/foundation.dart';

/// Timetable element.
@immutable
final class TimetableItem {
  const TimetableItem({
    required this.id,
    required this.dateAt,
    this.salary,
    this.onWork = false,
  });

  /// Employee's ID.
  final int id;

  /// Date when the employee should go to work.
  final DateTime dateAt;

  /// Employee's salary.
  final int? salary;

  /// Indicator whether employee is at work or not.
  final bool onWork;

  /// Return [TimetableItem] from [json].
  factory TimetableItem.fromJson(Map<String, Object?> json) => TimetableItem(
        id: json['id'] as int,
        dateAt: DateTime.parse(json['date_at'] as String),
        salary: json['salary'] as int?,
        onWork: json['on_work'] as bool,
      );

  @override
  String toString() => 'Employee(dateAt: $dateAt)';
}
