import 'package:ln_employee/src/feature/shedule/model/employee_time_block.dart';
import 'package:rest_client/rest_client.dart';

import '../model/fill_time_blocks.dart';
import '../model/timetable_item.dart';

///
abstract interface class TimetableDatasource {
  ///
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();

  Future<void> fillTimeBlocks(List<FillTimeBlocks> fillTimeBlocks);

  Future<void> deleteTimeBlocks(List<TimetableItem> timetableItems);
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
  Future<void> fillTimeBlocks(List<FillTimeBlocks> fillTimeBlocks) async {
    await restClient.post(
      '/api/employee/create',
      body: {
        'data': fillTimeBlocks
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      },
    );
  }

  @override
  Future<void> deleteTimeBlocks(List<TimetableItem> timetableItems) async {
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
