import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/book_history/model/timeblock.dart';

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

  /// Включение/выключение таймблока
  Future<void> toggleTimeblock({
    required int timetableId,
    required int timeblockId,
    required bool onWork,
  });

  /// Получение всех таймблоков конкретного рабочего дня сотрудника
  Future<List<EmployeeTimeblock$Response>> getTimetableTimeblocks({
    required int timetableId,
    required int timeblockId,
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
  Future<void> toggleTimeblock({
    required int timetableId,
    required int timeblockId,
    required bool onWork,
  }) =>
      _restClient.post(
        '/api/v1/timetable/add_timeblocks',
        data: {
          'timetable_id': timetableId,
          'timeblock_id': timeblockId,
          "on_work": onWork,
        },
      );

  @override
  Future<List<EmployeeTimeblock$Response>> getTimetableTimeblocks({
    required int timetableId,
    required int timeblockId,
  }) async {
    final response =
        await _restClient.get('/api/v1/timetable/timeblocks/$timetableId');
    final timeblocks = List.from(response.data['data'])
        .map((e) => EmployeeTimeblock$Response.fromJson(e))
        .toList();
    return timeblocks;
  }
}
