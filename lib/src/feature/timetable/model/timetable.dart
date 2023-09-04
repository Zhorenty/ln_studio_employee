import 'package:flutter/foundation.dart';

///
@immutable
final class Timetable {
  const Timetable({
    required this.id,
    required this.dateAt,
    required this.salonId,
    required this.employeeId,
    this.salary,
    this.onWork = false,
  });

  final int id;

  /// Дата когда сотрудник должен выйти
  final DateTime dateAt;

  ///
  final int salonId;

  ///
  final int employeeId;

  final int? salary;

  final bool onWork;

  factory Timetable.fromJson(Map<String, Object?> json) => Timetable(
        id: json['id'] as int,
        dateAt: DateTime.parse(json['date_at'] as String),
        salonId: json['salon_id'] as int,
        employeeId: json['employee_id'] as int,
        salary: json['salary'] as int?,
        onWork: json['on_work'] as bool,
      );

  Map<String, Object?> toJson() => {
        'dateAt': dateAt,
        'salonId': salonId,
        'employee_id': employeeId,
      };

  @override
  String toString() =>
      'Employee(dateAt: $dateAt, salonId: $salonId, employeeId: $employeeId)';
}
