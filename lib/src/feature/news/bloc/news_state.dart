import 'dart:io';

import 'package:flutter/foundation.dart';

import '../model/news.dart';
import '/src/common/utils/pattern_match.dart';

/// {@template News_state_placeholder}
/// Entity placeholder for NewsState
/// {@endtemplate}
typedef NewsEntity = List<NewsModel>;

/// {@template News_state}
/// NewsState.
/// {@endtemplate}
sealed class NewsState extends _$NewsStateBase {
  /// Idling state
  /// {@macro News_state}
  const factory NewsState.idle({
    required NewsEntity news,
    required NewsModel? currentNews,
    required File? photo,
    String message,
  }) = NewsState$Idle;

  /// Processing
  /// {@macro News_state}
  const factory NewsState.processing({
    required NewsEntity news,
    required NewsModel? currentNews,
    required File? photo,
    String message,
  }) = NewsState$Processing;

  /// Successful
  /// {@macro News_state}
  const factory NewsState.successful({
    required NewsEntity news,
    required NewsModel? currentNews,
    required File? photo,
    String message,
  }) = NewsState$Successful;

  /// An error has occurred
  /// {@macro News_state}
  const factory NewsState.error({
    required NewsEntity news,
    required NewsModel? currentNews,
    required File? photo,
    String message,
  }) = NewsState$Error;

  /// {@macro News_state}
  const NewsState({
    required super.news,
    required super.currentNews,
    required super.photo,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class NewsState$Idle extends NewsState with _$NewsState {
  /// {@nodoc}
  const NewsState$Idle({
    required super.news,
    required super.currentNews,
    required super.photo,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class NewsState$Processing extends NewsState with _$NewsState {
  /// {@nodoc}
  const NewsState$Processing({
    required super.news,
    required super.currentNews,
    required super.photo,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class NewsState$Successful extends NewsState with _$NewsState {
  /// {@nodoc}
  const NewsState$Successful({
    required super.news,
    required super.currentNews,
    required super.photo,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class NewsState$Error extends NewsState with _$NewsState {
  /// {@nodoc}
  const NewsState$Error({
    required super.news,
    required super.currentNews,
    required super.photo,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$NewsState on NewsState {}

/// {@nodoc}
@immutable
abstract base class _$NewsStateBase {
  /// {@nodoc}
  const _$NewsStateBase({
    required this.news,
    required this.currentNews,
    required this.photo,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final NewsEntity news;

  /// Data entity payload.
  @nonVirtual
  final NewsModel? currentNews;

  /// Data entity payload.
  @nonVirtual
  final File? photo;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasNews => news.isNotEmpty;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(
        orElse: () => false,
        error: (_) => true,
      );

  bool get isImageLoaded => maybeMap(
        idle: (_) => true,
        processing: (s) => s.hasNews,
        orElse: () => false,
      );

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  bool get isSuccessful => maybeMap<bool>(
        orElse: () => false,
        successful: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [NewsState].
  R map<R>({
    required PatternMatch<R, NewsState$Idle> idle,
    required PatternMatch<R, NewsState$Processing> processing,
    required PatternMatch<R, NewsState$Successful> successful,
    required PatternMatch<R, NewsState$Error> error,
  }) =>
      switch (this) {
        NewsState$Idle s => idle(s),
        NewsState$Processing s => processing(s),
        NewsState$Successful s => successful(s),
        NewsState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [NewsState].
  R maybeMap<R>({
    PatternMatch<R, NewsState$Idle>? idle,
    PatternMatch<R, NewsState$Processing>? processing,
    PatternMatch<R, NewsState$Successful>? successful,
    PatternMatch<R, NewsState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [NewsState].
  R? mapOrNull<R>({
    PatternMatch<R, NewsState$Idle>? idle,
    PatternMatch<R, NewsState$Processing>? processing,
    PatternMatch<R, NewsState$Successful>? successful,
    PatternMatch<R, NewsState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => news.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
