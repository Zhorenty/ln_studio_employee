import 'package:intl/intl.dart';

class FillTimetable {
  const FillTimetable({
    required this.employeeId,
    required this.salonId,
    required this.dates,
  });

  final int employeeId;
  final int salonId;
  final List<DateTime> dates;

  Map<String, Object?> toJson() => {
        'employee_id': employeeId,
        'salon_id': salonId,
        'dates': dates
            .map(
              (date) => DateFormat('yyyy-MM-dd').format(date),
            )
            .toList(),
      };
}
