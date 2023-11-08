import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/portfolio/model/portfolio.dart';

import '/src/common/utils/pattern_match.dart';

/// {@template Portfolio_state_placeholder}
/// Entity placeholder for PortfolioState
/// {@endtemplate}
typedef PortfolioEntity = List<PortfolioModel>;

/// {@template Portfolio_state}
/// PortfolioState.
/// {@endtemplate}
sealed class PortfolioState extends _$PortfolioStateBase {
  /// Idling state
  /// {@macro Portfolio_state}
  const factory PortfolioState.idle({
    required PortfolioEntity portfolio,
    required File? photo,
    String message,
  }) = PortfolioState$Idle;

  /// Processing
  /// {@macro Portfolio_state}
  const factory PortfolioState.processing({
    required PortfolioEntity portfolio,
    required File? photo,
    String message,
  }) = PortfolioState$Processing;

  /// Successful
  /// {@macro Portfolio_state}
  const factory PortfolioState.successful({
    required PortfolioEntity portfolio,
    required File? photo,
    String message,
  }) = PortfolioState$Successful;

  /// An error has occurred
  /// {@macro Portfolio_state}
  const factory PortfolioState.error({
    required PortfolioEntity portfolio,
    required File? photo,
    String message,
  }) = PortfolioState$Error;

  /// {@macro Portfolio_state}
  const PortfolioState({
    required super.portfolio,
    required super.photo,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class PortfolioState$Idle extends PortfolioState with _$PortfolioState {
  /// {@nodoc}
  const PortfolioState$Idle({
    required super.portfolio,
    required super.photo,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class PortfolioState$Processing extends PortfolioState
    with _$PortfolioState {
  /// {@nodoc}
  const PortfolioState$Processing({
    required super.portfolio,
    required super.photo,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class PortfolioState$Successful extends PortfolioState
    with _$PortfolioState {
  /// {@nodoc}
  const PortfolioState$Successful({
    required super.portfolio,
    required super.photo,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class PortfolioState$Error extends PortfolioState with _$PortfolioState {
  /// {@nodoc}
  const PortfolioState$Error({
    required super.portfolio,
    required super.photo,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$PortfolioState on PortfolioState {}

/// {@nodoc}
@immutable
abstract base class _$PortfolioStateBase {
  /// {@nodoc}
  const _$PortfolioStateBase({
    required this.portfolio,
    required this.photo,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final PortfolioEntity portfolio;

  /// Data entity payload.
  @nonVirtual
  final File? photo;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasPortfolio => portfolio.isNotEmpty;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(
        orElse: () => false,
        error: (_) => true,
      );

  bool get isImageLoaded => maybeMap(
        idle: (_) => true,
        processing: (s) => s.hasPortfolio,
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

  /// Pattern matching for [PortfolioState].
  R map<R>({
    required PatternMatch<R, PortfolioState$Idle> idle,
    required PatternMatch<R, PortfolioState$Processing> processing,
    required PatternMatch<R, PortfolioState$Successful> successful,
    required PatternMatch<R, PortfolioState$Error> error,
  }) =>
      switch (this) {
        PortfolioState$Idle s => idle(s),
        PortfolioState$Processing s => processing(s),
        PortfolioState$Successful s => successful(s),
        PortfolioState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [PortfolioState].
  R maybeMap<R>({
    PatternMatch<R, PortfolioState$Idle>? idle,
    PatternMatch<R, PortfolioState$Processing>? processing,
    PatternMatch<R, PortfolioState$Successful>? successful,
    PatternMatch<R, PortfolioState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [PortfolioState].
  R? mapOrNull<R>({
    PatternMatch<R, PortfolioState$Idle>? idle,
    PatternMatch<R, PortfolioState$Processing>? processing,
    PatternMatch<R, PortfolioState$Successful>? successful,
    PatternMatch<R, PortfolioState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => portfolio.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
