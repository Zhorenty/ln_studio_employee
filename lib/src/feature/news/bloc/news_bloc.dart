import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/news/data/news_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

/// Business Logic Component NewsBLoC
class NewsBLoC extends Bloc<NewsEvent, NewsState> {
  NewsBLoC({
    required final NewsRepository repository,
    final NewsState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const NewsState.idle(
                news: [],
                currentNews: null,
                photo: null,
                message: 'Initial idle state',
              ),
        ) {
    on<NewsEvent>(
      (event, emit) => switch (event) {
        NewsEvent$FetchAll() => _fetchAll(event, emit),
        NewsEvent$Create() => _create(event, emit),
        NewsEvent$Edit() => _edit(event, emit),
        NewsEvent$UploadPhoto() => _uploadPhoto(event, emit),
        NewsEvent$Delete() => _delete(event, emit),
      },
    );
  }

  ///
  final NewsRepository _repository;

  /// Fetch event handler
  Future<void> _fetchAll(
    NewsEvent$FetchAll event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ),
    );
    try {
      final news = await _repository.getNews();
      emit(NewsState.successful(
        news: news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(NewsState.error(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _create(
    NewsEvent$Create event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ),
    );
    try {
      await _repository.createNews(
        title: event.title,
        description: event.description,
      );
      emit(NewsState.successful(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(NewsState.error(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _edit(
    NewsEvent$Edit event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(
        currentNews: state.currentNews,
        news: state.news,
        photo: state.photo,
      ),
    );
    try {
      final news = await _repository.editNews(event.news);
      emit(NewsState.successful(
        news: state.news,
        currentNews: news,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(NewsState.error(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _uploadPhoto(
    NewsEvent$UploadPhoto event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(
        currentNews: state.currentNews,
        news: state.news,
        photo: state.photo,
      ),
    );
    try {
      await _repository.uploadPhoto(event.id, event.photo);
      emit(NewsState.successful(
        news: state.news,
        currentNews: state.currentNews,
        photo: event.photo,
      ));
    } on Object catch (err, _) {
      emit(NewsState.error(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _delete(
    NewsEvent$Delete event,
    Emitter<NewsState> emit,
  ) async {
    emit(
      NewsState.processing(
        currentNews: state.currentNews,
        news: state.news,
        photo: state.photo,
      ),
    );
    try {
      await _repository.deleteNews(event.id);
      emit(NewsState.successful(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
    } on Object catch (err, _) {
      emit(NewsState.error(
        news: state.news,
        currentNews: state.currentNews,
        photo: state.photo,
      ));
      rethrow;
    }
  }
}
