import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/employee/model/review.dart';

import '/src/common/utils/pattern_match.dart';

/// {@template EmployeeReviews_state}
/// EmployeeReviewsState.
/// {@endtemplate}
sealed class EmployeeReviewsState extends _$EmployeeReviewsStateBase {
  /// Idling state
  /// {@macro EmployeeReviews_state}
  const factory EmployeeReviewsState.idle({
    required List<Review> reviews,
    String message,
  }) = EmployeeReviewsState$Idle;

  /// Processing
  /// {@macro EmployeeReviews_state}
  const factory EmployeeReviewsState.processing({
    required List<Review> reviews,
    String message,
  }) = EmployeeReviewsState$Processing;

  /// Successful
  /// {@macro EmployeeReviews_state}
  const factory EmployeeReviewsState.successful({
    required List<Review> reviews,
    String message,
  }) = EmployeeReviewsState$Successful;

  /// An error has occurred
  /// {@macro EmployeeReviews_state}
  const factory EmployeeReviewsState.error({
    required List<Review> reviews,
    String message,
  }) = EmployeeReviewsState$Error;

  /// {@macro EmployeeReviews_state}
  const EmployeeReviewsState({
    required super.reviews,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class EmployeeReviewsState$Idle extends EmployeeReviewsState
    with _$EmployeeReviewsState {
  /// {@nodoc}
  const EmployeeReviewsState$Idle({
    required super.reviews,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class EmployeeReviewsState$Processing extends EmployeeReviewsState
    with _$EmployeeReviewsState {
  /// {@nodoc}
  const EmployeeReviewsState$Processing({
    required super.reviews,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class EmployeeReviewsState$Successful extends EmployeeReviewsState
    with _$EmployeeReviewsState {
  /// {@nodoc}
  const EmployeeReviewsState$Successful({
    required super.reviews,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class EmployeeReviewsState$Error extends EmployeeReviewsState
    with _$EmployeeReviewsState {
  /// {@nodoc}
  const EmployeeReviewsState$Error({
    required super.reviews,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$EmployeeReviewsState on EmployeeReviewsState {}

/// {@nodoc}
@immutable
abstract base class _$EmployeeReviewsStateBase {
  /// {@nodoc}
  const _$EmployeeReviewsStateBase({
    required this.reviews,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final List<Review> reviews;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasEmployeeReviews => reviews.isNotEmpty;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(
        orElse: () => false,
        error: (_) => true,
      );

  bool get isImageLoaded => maybeMap(
        idle: (_) => true,
        processing: (s) => s.hasEmployeeReviews,
        orElse: () => false,
      );

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [EmployeeReviewsState].
  R map<R>({
    required PatternMatch<R, EmployeeReviewsState$Idle> idle,
    required PatternMatch<R, EmployeeReviewsState$Processing> processing,
    required PatternMatch<R, EmployeeReviewsState$Successful> successful,
    required PatternMatch<R, EmployeeReviewsState$Error> error,
  }) =>
      switch (this) {
        EmployeeReviewsState$Idle s => idle(s),
        EmployeeReviewsState$Processing s => processing(s),
        EmployeeReviewsState$Successful s => successful(s),
        EmployeeReviewsState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [EmployeeReviewsState].
  R maybeMap<R>({
    PatternMatch<R, EmployeeReviewsState$Idle>? idle,
    PatternMatch<R, EmployeeReviewsState$Processing>? processing,
    PatternMatch<R, EmployeeReviewsState$Successful>? successful,
    PatternMatch<R, EmployeeReviewsState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [EmployeeReviewsState].
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeReviewsState$Idle>? idle,
    PatternMatch<R, EmployeeReviewsState$Processing>? processing,
    PatternMatch<R, EmployeeReviewsState$Successful>? successful,
    PatternMatch<R, EmployeeReviewsState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => reviews.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
