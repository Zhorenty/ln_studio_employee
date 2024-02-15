import 'package:meta/meta.dart';

/// {@template timeblocks_state_placeholder}
/// Entity placeholder for TimeblocksState
/// {@endtemplate}
typedef TimeblocksEntity = Object;

/// {@template timeblocks_state}
/// TimeblocksState.
/// {@endtemplate}
sealed class TimeblocksState extends _$TimeblocksStateBase {
  /// Idling state
  /// {@macro timeblocks_state}
  const factory TimeblocksState.idle({
    required TimeblocksEntity? data,
    String message,
  }) = TimeblocksState$Idle;

  /// Processing
  /// {@macro timeblocks_state}
  const factory TimeblocksState.processing({
    required TimeblocksEntity? data,
    String message,
  }) = TimeblocksState$Processing;

  /// Successful
  /// {@macro timeblocks_state}
  const factory TimeblocksState.successful({
    required TimeblocksEntity? data,
    String message,
  }) = TimeblocksState$Successful;

  /// An error has occurred
  /// {@macro timeblocks_state}
  const factory TimeblocksState.error({
    required TimeblocksEntity? data,
    String message,
  }) = TimeblocksState$Error;

  /// {@macro timeblocks_state}
  const TimeblocksState({required super.data, required super.message});
}

/// Idling state
/// {@nodoc}
final class TimeblocksState$Idle extends TimeblocksState
    with _$TimeblocksState {
  /// {@nodoc}
  const TimeblocksState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class TimeblocksState$Processing extends TimeblocksState
    with _$TimeblocksState {
  /// {@nodoc}
  const TimeblocksState$Processing(
      {required super.data, super.message = 'Processing'});
}

/// Successful
/// {@nodoc}
final class TimeblocksState$Successful extends TimeblocksState
    with _$TimeblocksState {
  /// {@nodoc}
  const TimeblocksState$Successful(
      {required super.data, super.message = 'Successful'});
}

/// Error
/// {@nodoc}
final class TimeblocksState$Error extends TimeblocksState
    with _$TimeblocksState {
  /// {@nodoc}
  const TimeblocksState$Error(
      {required super.data, super.message = 'An error has occurred.'});
}

/// {@nodoc}
base mixin _$TimeblocksState on TimeblocksState {}

/// Pattern matching for [TimeblocksState].
typedef TimeblocksStateMatch<R, S extends TimeblocksState> = R Function(
    S state);

/// {@nodoc}
@immutable
abstract base class _$TimeblocksStateBase {
  /// {@nodoc}
  const _$TimeblocksStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final TimeblocksEntity? data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [TimeblocksState].
  R map<R>({
    required TimeblocksStateMatch<R, TimeblocksState$Idle> idle,
    required TimeblocksStateMatch<R, TimeblocksState$Processing> processing,
    required TimeblocksStateMatch<R, TimeblocksState$Successful> successful,
    required TimeblocksStateMatch<R, TimeblocksState$Error> error,
  }) =>
      switch (this) {
        TimeblocksState$Idle s => idle(s),
        TimeblocksState$Processing s => processing(s),
        TimeblocksState$Successful s => successful(s),
        TimeblocksState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [TimeblocksState].
  R maybeMap<R>({
    TimeblocksStateMatch<R, TimeblocksState$Idle>? idle,
    TimeblocksStateMatch<R, TimeblocksState$Processing>? processing,
    TimeblocksStateMatch<R, TimeblocksState$Successful>? successful,
    TimeblocksStateMatch<R, TimeblocksState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [TimeblocksState].
  R? mapOrNull<R>({
    TimeblocksStateMatch<R, TimeblocksState$Idle>? idle,
    TimeblocksStateMatch<R, TimeblocksState$Processing>? processing,
    TimeblocksStateMatch<R, TimeblocksState$Successful>? successful,
    TimeblocksStateMatch<R, TimeblocksState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
