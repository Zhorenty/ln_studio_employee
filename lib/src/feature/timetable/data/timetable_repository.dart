import 'package:ln_employee/src/feature/timetable/model/employee_timetable.dart';
import 'package:ln_employee/src/feature/timetable/model/fill_time_blocks.dart';
import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';

import 'timetable_datasource.dart';

/// Repository for timetables data.
abstract interface class TimetableRepository {
  /// Get timetables.
  Future<List<EmployeeTimetable>> getEmployeesTimetables();

  /// Fill time block items.
  Future<void> fillTimetables(List<FillTimetable> fillTimetables);

  /// Delete time block items.
  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems);
}

/// Implementation of the timetable repository.
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl({required this.dataSource});

  /// Timetable data source.
  final TimetableDatasource dataSource;

  @override
  Future<List<EmployeeTimetable>> getEmployeesTimetables() =>
      dataSource.fetchEmployeesTimetables();

  @override
  Future<void> fillTimetables(List<FillTimetable> fillTimetables) =>
      dataSource.fillTimetables(fillTimetables);

  @override
  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems) =>
      dataSource.deleteTimetableItems(timetableItems);
}
