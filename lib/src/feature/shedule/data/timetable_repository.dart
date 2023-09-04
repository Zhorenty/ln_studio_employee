import 'package:ln_employee/src/feature/shedule/model/employee_time_block.dart';

import 'timetable_datasource.dart';

///
abstract interface class TimetableRepository {
  ///
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();
}

///
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl({required this.dataSource});

  ///
  final TimetableDatasource dataSource;

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables() =>
      dataSource.fetchEmployeesTimetables();
}
