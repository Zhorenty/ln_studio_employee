import 'package:ln_employee/src/feature/shedule/model/timetable_item.dart';

class FillTimeBlocks {
  const FillTimeBlocks({
    required this.employeeId,
    required this.salonId,
    required this.timetableItems,
  });

  final int employeeId;
  final int salonId;
  final List<TimetableItem> timetableItems;

  Map<String, Object?> toJson() => {
        'employee_id': employeeId,
        'salon_id': salonId,
        'time_tables': timetableItems
            .map(
              (e) => e.dateAt.toIso8601String(),
            )
            .toList(),
      };
}
