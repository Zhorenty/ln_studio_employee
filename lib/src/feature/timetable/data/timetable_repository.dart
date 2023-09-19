import '/src/feature/timetable/model/employee_timetable.dart';
import 'timetable_datasource.dart';

/// Repository for timetables data.
abstract interface class TimetableRepository {
  /// Get timetables.
  Future<List<EmployeeTimetable>> getTimetables();

  /// Get timetables by salon id.
  Future<List<EmployeeTimetable>> getTimetablesBySalonId(int salonId);

  /// Fill time block items.
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  });
}

/// Implementation of the timetable repository.
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final TimetableDatasource _dataSource;

  @override
  Future<List<EmployeeTimetable>> getTimetables() =>
      _dataSource.fetchTimetables();

  @override
  Future<List<EmployeeTimetable>> getTimetablesBySalonId(int salonId) =>
      _dataSource.fetchTimetablesBySalonId(salonId);

  @override
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) =>
      _dataSource.fillTimetable(
        employeeId: employeeId,
        salonId: salonId,
        dateAt: dateAt,
      );
}
