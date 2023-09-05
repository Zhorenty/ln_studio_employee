import '/src/feature/timetable/model/employee_timetable.dart';
import '/src/feature/timetable/model/fill_time_blocks.dart';
import 'timetable_datasource.dart';

/// Repository for timetables data.
abstract interface class TimetableRepository {
  /// Get timetables.
  Future<List<EmployeeTimetable>> getEmployeesTimetables();

  /// Fill time block items.
  Future<void> fillTimetable(FillTimetable fillTimetable);
}

/// Implementation of the timetable repository.
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final TimetableDatasource _dataSource;

  @override
  Future<List<EmployeeTimetable>> getEmployeesTimetables() =>
      _dataSource.fetchEmployeesTimetables();

  @override
  Future<void> fillTimetable(FillTimetable fillTimetables) =>
      _dataSource.fillTimetable(fillTimetables);
}
