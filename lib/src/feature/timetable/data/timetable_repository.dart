import 'package:ln_employee/src/feature/book_history/model/timeblock.dart';

import '../model/timetable_item.dart';
import '/src/feature/timetable/model/employee_timetable.dart';
import 'timetable_datasource.dart';

/// Repository for timetables data.
abstract interface class TimetableRepository {
  /// Get timetables.
  Future<List<EmployeeTimetableModel>> getTimetables();

  /// Get timetables by salon id.
  Future<List<EmployeeTimetableModel>> getTimetablesBySalonId(int salonId);

  /// Fetch timetables.
  Future<List<TimetableItem>> fetchEmployeeTimetables(
    final int salonId,
    final int employeeId,
  );

  /// Fill time block items.
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  });

  /// Включение/выключение таймблока
  Future<void> toggleTimeblock({
    required int timetableId,
    required int timeblockId,
    required bool onWork,
  });

  /// Получение всех таймблоков конкретного рабочего дня сотрудника
  Future<List<EmployeeTimeblock$Response>> getTimetableTimeblocks({
    required int timetableId,
    required int timeblockId,
  });
}

/// Implementation of the timetable repository.
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final TimetableDatasource _dataSource;

  @override
  Future<List<EmployeeTimetableModel>> getTimetables() =>
      _dataSource.fetchTimetables();

  @override
  Future<List<TimetableItem>> fetchEmployeeTimetables(
    int salonId,
    int employeeId,
  ) =>
      _dataSource.fetchEmployeeTimetables(salonId, employeeId);

  @override
  Future<List<EmployeeTimetableModel>> getTimetablesBySalonId(int salonId) =>
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

  @override
  Future<void> toggleTimeblock({
    required int timetableId,
    required int timeblockId,
    required bool onWork,
  }) =>
      _dataSource.toggleTimeblock(
        timetableId: timetableId,
        timeblockId: timeblockId,
        onWork: onWork,
      );

  @override
  Future<List<EmployeeTimeblock$Response>> getTimetableTimeblocks({
    required int timetableId,
    required int timeblockId,
  }) =>
      _dataSource.getTimetableTimeblocks(
        timetableId: timetableId,
        timeblockId: timeblockId,
      );
}
