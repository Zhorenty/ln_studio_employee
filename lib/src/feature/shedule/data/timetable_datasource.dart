import 'package:rest_client/rest_client.dart';

import '../model/timetable.dart';

///
abstract interface class TimetableDatasource {
  ///
  Future<List<Timetable>> loadTimetables();
}

///
class TimetableDatasourceImpl implements TimetableDatasource {
  TimetableDatasourceImpl(RestClient client) : _client = client;

  ///
  final RestClient _client;

  @override
  Future<List<Timetable>> loadTimetables() => _client.getCategories().then(
        (list) => list.map(Timetable.fromDTO).toList(),
      );
}
