import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/profile/data/profile_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

/// Business Logic Component NewsBLoC
class NewsBLoC extends Bloc<NewsEvent, NewsState> {
  NewsBLoC({
    required final ProfileRepository repository,
    final NewsState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const NewsState.idle(
                news: [],
                currentNews: null,
                message: 'Initial idle state',
              ),
        ) {
    on<NewsEvent>(
      (event, emit) => switch (event) {
        NewsEvent$FetchAll() => _fetchAll(event, emit),
        NewsEvent$Edit() => _edit(event, emit),
      },
    );
  }

  ///
  final ProfileRepository _repository;

  /// Fetch event handler
  Future<void> _fetchAll(
    NewsEvent$FetchAll event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(news: state.news, currentNews: state.currentNews),
    );
    try {
      final news = await _repository.getNews();
      emit(NewsState.successful(news: news, currentNews: state.currentNews));
    } on Object catch (err, _) {
      emit(NewsState.error(news: state.news, currentNews: state.currentNews));
      rethrow;
    } finally {
      emit(NewsState.idle(news: state.news, currentNews: state.currentNews));
    }
  }

  /// Fetch event handler
  Future<void> _edit(
    NewsEvent$Edit event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(currentNews: state.currentNews, news: state.news),
    );
    try {
      final news = await _repository.editNews(event.news);
      emit(NewsState.successful(news: state.news, currentNews: news));
    } on Object catch (err, _) {
      emit(NewsState.error(news: state.news, currentNews: state.currentNews));
      rethrow;
    } finally {
      emit(NewsState.idle(news: state.news, currentNews: state.currentNews));
    }
  }
}
