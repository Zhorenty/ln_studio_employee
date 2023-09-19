import 'package:rest_client/rest_client.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/timetable/model/employee_timetable.dart';

/// Datasource for timetables data.
abstract interface class TimetableDatasource {
  /// Fetch timetables.
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables();

  /// Fetch timetables.
  Future<List<EmployeeTimetable>> fetchEmployeesTimetablesBySalonId(
    int salonId,
  );

  /// Fill timetable items.
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  });
}

/// Implementation of timetable datasource.
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required RestClient restClient})
      : _restClient = restClient;

  /// REST client to call API.
  final RestClient _restClient;

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetables() async {
    final response = await _restClient.get('/api/timetable/all');

    final employeesTimetables = List.from((response['data'] as List))
        .map((e) => EmployeeTimetable.fromJson(e))
        .toList();

    return employeesTimetables;
  }

  @override
  Future<List<EmployeeTimetable>> fetchEmployeesTimetablesBySalonId(
    int salonId,
  ) async {
    final response =
        await _restClient.get('/api/timetable/by_salon_id/$salonId');

    final employeesTimetables = List.from((response['data'] as List))
        .map((e) => EmployeeTimetable.fromJson(e))
        .toList();

    return employeesTimetables;
  }

  @override
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) =>
      _restClient.post(
        '/api/timetable/fill',
        body: {
          'employee_id': employeeId,
          'salon_id': salonId,
          'date_at': dateAt.format(),
        },
      );
}
