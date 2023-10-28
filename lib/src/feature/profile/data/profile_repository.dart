import 'dart:io';

import '../model/news.dart';
import 'profile_data_provider.dart';

/// Repository for Record data.
abstract interface class ProfileRepository {
  /// Get
  Future<List<NewsModel>> getNews();

  Future<NewsModel> editNews(NewsModel news);

  Future<void> uploadPhoto(int id, File file);
}

/// Implementation of the Record repository.
final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataProvider);

  /// Record data source.
  final ProfileDataProvider _dataProvider;

  @override
  Future<List<NewsModel>> getNews() => _dataProvider.fetchNews();

  @override
  Future<NewsModel> editNews(NewsModel news) => _dataProvider.editNews(news);

  @override
  Future<void> uploadPhoto(int id, File file) =>
      _dataProvider.uploadPhoto(id, file);
}
