import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/portfolio/model/portfolio.dart';

/// Datasource for Record PortfolioDataProvider.
abstract interface class PortfolioDataProvider {
  /// Fetch RecordHomeDataProvider
  Future<List<PortfolioModel>> fetchPortfolio(int id);

  Future<void> addPhoto(int id, File file);

  Future<void> deletePhoto(int id);
}

/// Implementation of Record RecordDataProvider.
class PortfolioDataProviderImpl implements PortfolioDataProvider {
  PortfolioDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<PortfolioModel>> fetchPortfolio(int id) async {
    final response = await restClient.get('/api/v1/portfolio/$id/photo');

    final portfolio = List.from((response.data['data']))
        .map((e) => PortfolioModel.fromJson(e))
        .toList();

    return portfolio;
  }

  @override
  Future<void> addPhoto(int id, File file) async {
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      },
    );

    await restClient.post(
      '/api/v1/portfolio/$id/photo',
      data: formData,
    );
  }

  @override
  Future<void> deletePhoto(int id) async =>
      await restClient.delete('/api/v1/portfolio/photo/$id');
}
