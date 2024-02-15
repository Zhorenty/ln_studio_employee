import 'package:dio/dio.dart';

import '../model/timetable_item.dart';
import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/timetable/model/employee_timetable.dart';

/// Datasource for timetables data.
abstract interface class TimetableDatasource {
  /// Fetch timetables.
  Future<List<EmployeeTimetableModel>> fetchTimetables();

  /// Fetch timetables.
  Future<List<EmployeeTimetableModel>> fetchTimetablesBySalonId(
    int salonId,
  );

  /// Fetch timetables.
  Future<List<TimetableItem>> fetchEmployeeTimetables(
    final int salonId,
    final int employeeId,
  );

  /// Fill timetable items.
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  });

  /*
  Если надо выключить, я передаю все, кроме тех, которые я хочу выключить.
  Если я хочу включить, то я передаю все, включая те, которые я хочу включить.
  */
  Future<void> addTimeblock({
    required int timetableId,
    required List<int> timeblockIds,
  });
}

/// Implementation of timetable datasource.
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required Dio restClient}) : _restClient = restClient;

  /// REST client to call API.
  final Dio _restClient;

  @override
  Future<List<EmployeeTimetableModel>> fetchTimetables() async {
    final response = await _restClient.get('/api/v1/timetable');

    final timetables = List.from((response.data['data']))
        .map((e) => EmployeeTimetableModel.fromJson(e))
        .toList();

    return timetables;
  }

  @override
  Future<List<TimetableItem>> fetchEmployeeTimetables(
    int salonId,
    int employeeId,
  ) async {
    final response = await _restClient.get(
      '/api/v1/employee/$employeeId/timetables',
      queryParameters: {
        'salon_id': salonId,
      },
    );

    return List.from((response.data['data']))
        .map((e) => TimetableItem.fromJson(e))
        .toList();
  }

  @override
  Future<List<EmployeeTimetableModel>> fetchTimetablesBySalonId(
      int salonId) async {
    final response = await _restClient.get(
      '/api/v1/salon/$salonId/timetables',
    );

    final timetables = List.from((response.data['data']))
        .map((e) => EmployeeTimetableModel.fromJson(e))
        .toList();

    return timetables;
  }

  @override
  Future<void> fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) =>
      _restClient.post(
        '/api/v1/timetable/fill',
        data: {
          'employee_id': employeeId,
          'salon_id': salonId,
          'date_at': dateAt.jsonFormat(),
        },
      );

  @override
  /*
  Включение/выключение таймблока
  Если надо выключить, я передаю все, кроме тех, которые я хочу выключить.
  Если я хочу включить, то я передаю все, включая те, которые я хочу включить.
  */
  Future<void> addTimeblock({
    required int timetableId,
    required List<int> timeblockIds,
  }) =>
      _restClient.post(
        '/api/v1/timetable/add_timeblocks',
        data: {
          'timetable_id': timetableId,
          'timeblocks': timeblockIds,
        },
      );
}
