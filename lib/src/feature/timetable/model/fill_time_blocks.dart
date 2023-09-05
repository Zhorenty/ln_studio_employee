import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

///
@immutable
final class FillTimetable {
  const FillTimetable({
    required this.employeeId,
    required this.salonId,
    required this.dateAt,
  });

  /// Employee's id.
  final int employeeId;

  /// Current salon id.
  final int salonId;

  /// Dates to fill.
  final DateTime dateAt;

  /// Convert [FillTimetable] to json.
  Map<String, Object?> toJson() => {
        'employee_id': employeeId,
        'salon_id': salonId,
        'date_at': DateFormat('yyyy-MM-dd').format(dateAt),
      };
}
