import 'package:ln_employee/src/feature/profile/model/news.dart';

/// Business Logic Component News_event Events
sealed class NewsEvent {
  const NewsEvent();

  /// Fetch
  const factory NewsEvent.fetchAll() = NewsEvent$FetchAll;

  const factory NewsEvent.edit({required NewsModel news}) = NewsEvent$Edit;
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
