import 'dart:io';

import 'package:dio/dio.dart';

import '../model/news.dart';

/// Datasource for Record ProfileDataProvider.
abstract interface class ProfileDataProvider {
  /// Fetch RecordHomeDataProvider
  Future<List<NewsModel>> fetchNews();

  Future<NewsModel> editNews(NewsModel news);

  Future<void> uploadPhoto(int id, File file);
}

/// Implementation of Record RecordDataProvider.
class ProfileDataProviderImpl implements ProfileDataProvider {
  ProfileDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<List<NewsModel>> fetchNews() async {
    final response = await restClient.get('/api/v1/news');

    final news = List.from((response.data['data']))
        .map((e) => NewsModel.fromJson(e))
        .toList();

    return news;
  }

  @override
  Future<NewsModel> editNews(NewsModel news) async {
    final response = await restClient.put(
      '/api/v1/news/${news.id}/edit',
      data: {
        'title': news.title,
        'description': news.description,
      },
    );

    return NewsModel.fromJson(response.data['data']);
  }

  @override
  Future<void> uploadPhoto(int id, File file) async {
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      },
    );

    await restClient.patch(
      '/api/v1/news/$id/photo',
      data: formData,
    );
  }
}
