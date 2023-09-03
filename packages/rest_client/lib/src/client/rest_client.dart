import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '/src/dto/employee/timetable_dto.dart';

part 'rest_client.g.dart';

const $baseUrl = 'http://31.129.104.75';
const _getCategories = '/api/employee/create';

@RestApi(baseUrl: $baseUrl)
@immutable
abstract class RestClient {
  factory RestClient(
    Dio dio, {
    String baseUrl,
  }) = _RestClient;

  @POST(_getCategories)
  Future<List<TimetableDTO>> getCategories();
}
