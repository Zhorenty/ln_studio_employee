import 'package:flutter/foundation.dart';

///
@immutable
final class Timetable {
  const Timetable({
    required this.dateAt,
    required this.salonId,
    required this.employeeId,
  });

  ///
  final List<DateTime> dateAt;

  ///
  final int salonId;

  ///
  final int employeeId;

  factory Timetable.fromJson(Map<String, Object?> json) => Timetable(
        dateAt: json['date_at']! as List<DateTime>,
        salonId: json['salon_id']! as int,
        employeeId: json['employee_id']! as int,
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
