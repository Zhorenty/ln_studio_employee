import 'package:rest_client/rest_client.dart';

import '../model/employee.dart';
import '../model/employee_time_block.dart';
import '../model/timeblock.dart';

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

    final data = response as List<dynamic>;

    final tables = data.map((json) {
      final employeeJson = json['employee'] as Map<String, dynamic>;
      final timeTablesJson = json['timetables'] as List<dynamic>;

      final employee = Employee.fromJson(employeeJson);
      final timeTables = timeTablesJson
          .map((timeTableJson) => Timetable.fromJson(timeTableJson))
          .toList();

      return EmployeeTimeBlock(
        employeeId: employee.id,
        firstName: employee.firstName,
        lastName: employee.lastName,
        timeTables: timeTables,
      );
    }).toList();

    return tables;
  }
}
