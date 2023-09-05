import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

///
@immutable
final class FillTimetable {
  const FillTimetable({
    required this.employeeId,
    required this.salonId,
    required this.dates,
  });

  /// Employee's id.
  final int employeeId;

  /// Current salon id.
  final int salonId;

  /// Dates to fill.
  final List<DateTime> dates;

  /// Convert [FillTimetable] to json.
  Map<String, Object?> toJson() => {
        'employee_id': employeeId,
        'salon_id': salonId,
        'dates': dates.map((e) => DateFormat('yyyy-MM-dd').format(e)).toList(),
      };
}
