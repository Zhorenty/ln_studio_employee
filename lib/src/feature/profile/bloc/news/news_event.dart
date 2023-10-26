import 'dart:io';

import 'package:ln_employee/src/feature/profile/model/news.dart';

/// Business Logic Component News_event Events
sealed class NewsEvent {
  const NewsEvent();

  /// Fetch
  const factory NewsEvent.fetchAll() = NewsEvent$FetchAll;

  const factory NewsEvent.edit({required NewsModel news}) = NewsEvent$Edit;

  const factory NewsEvent.uploadPhoto({
    required int id,
    required File photo,
  }) = NewsEvent$UploadPhoto;
}

/// Fetch all News.
class NewsEvent$FetchAll extends NewsEvent {
  const NewsEvent$FetchAll();
}

///
class NewsEvent$Edit extends NewsEvent {
  const NewsEvent$Edit({required this.news});

  ///
  final NewsModel news;
}

///
class NewsEvent$UploadPhoto extends NewsEvent {
  const NewsEvent$UploadPhoto({required this.photo, required this.id});

  final int id;

  ///
  final File photo;
}
