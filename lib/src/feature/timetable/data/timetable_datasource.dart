import 'package:ln_employee/src/feature/timetable/model/employee_timetable.dart';
import 'package:ln_employee/src/feature/timetable/model/fill_time_blocks.dart';
import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';
import 'package:rest_client/rest_client.dart';

///
abstract interface class TimetableDatasource {
  ///
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();

  Future<void> fillTimetables(List<FillTimetable> fillTimetables);

  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems);
}

///
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required this.restClient});

  ///
  final RestClient restClient;

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables() async {
    final response = await restClient.get('/api/timetable/timeblocks');

    final employeesTimetables =
        List.from((response['response'] as Map)['data'] as List)
            .map((e) => EmployeeTimetable.fromJson(e))
            .toList();

    return employeesTimetables;
  }

  @override
  Future<void> fillTimetables(List<FillTimetable> fillTimetables) async {
    await restClient.post(
      '/api/timetable/fill_timeblocks',
      body: {
        'data': fillTimetables
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      },
    );
  }

  @override
  Future<void> deleteTimetableItems(List<TimetableItem> timetableItems) async {
    await restClient.post(
      '/api/timetable/delete_timeblocks',
      body: {
        'ids': timetableItems
            .map(
              (e) => e.id,
            )
            .toList(),
      },
    );
  }
}
