import 'package:rest_client/rest_client.dart';

import '../model/employee_time_block.dart';

///
abstract interface class TimetableDatasource {
  ///
  Future<List<EmployeeTimeBlock>> loadTimetables();
}

///
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required this.restClient});

  ///
  final RestClient restClient;

  @override
  Future<List<EmployeeTimeBlock>> loadTimetables() async {
    final response = await restClient.get('/api/timetable/timeblocks');

    final tables = List.from(
      ((response['response'] as Map<String, dynamic>)['data'] as List),
    ).map((e) => EmployeeTimeBlock.fromJson(e)).toList();

    return tables;
  }
}
