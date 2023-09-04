import 'package:ln_employee/src/feature/timetable/model/employee_timetable.dart';
import 'package:ln_employee/src/feature/timetable/model/fill_time_blocks.dart';
import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';

import 'timetable_datasource.dart';

///
abstract interface class TimetableRepository {
  ///
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();

  Future<void> fillTimetables(List<FillTimetable> fillTimetables);

  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems);
}

///
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl({required this.dataSource});

  ///
  final TimetableDatasource dataSource;

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables() =>
      dataSource.fetchEmployeesTimetables();

  @override
  Future<void> fillTimetables(List<FillTimetable> fillTimetables) =>
      dataSource.fillTimetables(fillTimetables);

  @override
  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems) =>
      dataSource.deleteTimetableItems(timetableItems);
}
