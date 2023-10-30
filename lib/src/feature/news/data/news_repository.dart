import 'dart:async';
import 'dart:io';

import '../model/news.dart';
import 'news_data_provider.dart';

/// Repository for Record data.
abstract interface class NewsRepository {
  /// Get
  Future<List<NewsModel>> getNews();

  /// Get
  Future<void> createNews({required String title, required String description});

  Future<NewsModel> editNews(NewsModel news);

  Future<void> uploadPhoto(int id, File file);

  Future<void> deleteNews(int id);
}

/// Implementation of the Record repository.
final class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._dataProvider);

  /// Record data source.
  final NewsDataProvider _dataProvider;

  @override
  Future<List<NewsModel>> getNews() => _dataProvider.fetchNews();

  @override
  Future<void> createNews({
    required String title,
    required String description,
  }) =>
      _dataProvider.createNews(title: title, description: description);

  @override
  Future<NewsModel> editNews(NewsModel news) => _dataProvider.editNews(news);

  @override
  Future<void> uploadPhoto(int id, File file) =>
      _dataProvider.uploadPhoto(id, file);

  @override
  Future<void> deleteNews(int id) => _dataProvider.deleteNews(id);
}
