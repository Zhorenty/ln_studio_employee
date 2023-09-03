import 'package:flutter/foundation.dart';
import 'package:rest_client/rest_client.dart';

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

  factory Timetable.fromDTO(TimetableDTO dto) => Timetable(
        dateAt: dto.dateAt,
        salonId: dto.salonId,
        employeeId: dto.employeeId,
      );

  @override
  String toString() =>
      'Employee(birthDate: $dateAt, salonId: $salonId, employeeId: $employeeId)';
}
