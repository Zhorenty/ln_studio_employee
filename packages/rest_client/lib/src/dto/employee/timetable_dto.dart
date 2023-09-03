import 'package:meta/meta.dart';

@immutable
final class TimetableDTO {
  const TimetableDTO({
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

  ///
  factory TimetableDTO.fromJson(Map<String, Object?> json) => TimetableDTO(
        dateAt: json['date_at'] as List<DateTime>,
        salonId: json['salon_id'] as int,
        employeeId: json['employee_id'] as int,
      );

  ///
  Map<String, Object?> toJson() => {
        'date_at': dateAt.map((e) => e.toIso8601String()).toList(),
        'salon_id': salonId,
        'employee_id': employeeId,
      };
}
