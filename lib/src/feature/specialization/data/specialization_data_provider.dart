import 'package:dio/dio.dart';

import '/src/feature/specialization/model/specialization.dart';

/// Datasource for specializations data.
abstract interface class SpecializationDataProvider {
  /// Fetch specializations.
  Future<List<Specialization>> fetchSpecializations();
}

/// Implementation of Specialization datasource.
class SpecializationDataProviderImpl implements SpecializationDataProvider {
  SpecializationDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<Specialization>> fetchSpecializations() async {
    final response = await restClient.get('/api/v1/job');
    final specializations = List.from(response.data['data'] as List)
        .map((e) => Specialization.fromJson(e))
        .toList();
    return specializations;
  }
}
