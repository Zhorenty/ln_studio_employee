import '../model/employee_time_block.dart';
import 'timetable_datasource.dart';

///
abstract interface class TimetableRepository {
  ///
  Future<List<EmployeeTimeBlock>> getTimetables();
}

///
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl({required this.dataSource});

  ///
  final TimetableDatasource dataSource;

  @override
  Future<List<EmployeeTimeBlock>> getTimetables() async =>
      dataSource.loadTimetables();
}
