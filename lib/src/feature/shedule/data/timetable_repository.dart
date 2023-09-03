import 'package:ln_employee/src/feature/shedule/model/timetable.dart';

import 'timetable_datasource.dart';

///
abstract interface class TimetableRepository {
  ///
  Future<List<Timetable>> getTimetables();
}

///
final class TimetableRepositoryImpl implements TimetableRepository {
  TimetableRepositoryImpl({required this.dataSource});

  ///
  final TimetableDatasource dataSource;

  @override
  Future<List<Timetable>> getTimetables() async => dataSource.loadTimetables();
}
