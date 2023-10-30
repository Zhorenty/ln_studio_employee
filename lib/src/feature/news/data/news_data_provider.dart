import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../model/news.dart';

/// Datasource for Record NewsDataProvider.
abstract interface class NewsDataProvider {
  /// Fetch RecordHomeDataProvider
  Future<List<NewsModel>> fetchNews();

  Future<void> createNews({required String title, required String description});

  Future<NewsModel> editNews(NewsModel news);

  Future<void> uploadPhoto(int id, File file);

  Future<void> deleteNews(int id);
}

/// Implementation of Record RecordDataProvider.
class NewsDataProviderImpl implements NewsDataProvider {
  NewsDataProviderImpl({required this.restClient});

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
  Future<void> createNews({
    required String title,
    required String description,
  }) async =>
      await restClient.post(
        '/api/v1/news/create',
        data: {
          "title": title,
          "description": description,
        },
      );

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

  @override
  Future<void> deleteNews(int id) async =>
      await restClient.delete('/api/v1/news/$id/delete');
}
