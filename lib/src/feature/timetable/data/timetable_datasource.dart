import 'package:intl/intl.dart';
import 'package:rest_client/rest_client.dart';

import '/src/feature/timetable/model/employee_timetable.dart';

/// Datasource for timetables data.
abstract interface class TimetableDatasource {
  /// Fetch timetables.
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();

  /// Fill timetable items.
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  });
}

/// Implementation of timetable datasource.
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables() async {
    final response = await restClient.get('/api/timetable/timeblocks');

    final employeesTimetables = List.from(
      (response['response'] as Map)['data'] as List,
    ).map((e) => EmployeeTimetable.fromJson(e)).toList();

    return employeesTimetables;
  }

  @override
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) async {
    await restClient.post(
      '/api/timetable/fill_timeblock',
      body: {
        'employee_id': employeeId,
        'salon_id': salonId,
        'date_at': DateFormat('yyyy-MM-dd').format(dateAt),
      },
    );
  }
}
