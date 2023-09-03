import 'package:rest_client/rest_client.dart';

import '../model/timetable.dart';

///
abstract interface class TimetableDatasource {
  ///
  Future<List<Timetable>> loadTimetables();
}

///
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl({required this.restClient});

  ///
  final RestClient restClient;

  @override
  Future<List<Timetable>> loadTimetables() async {
    final response = await restClient.get('/api/timetable/all');

    final tables = List.from((response['response'] as Map)['data'] as List)
        .map((e) => Timetable.fromJson(e))
        .toList();

    return tables;
  }
}
