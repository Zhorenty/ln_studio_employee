import 'package:ln_employee/src/feature/salon/models/salon.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

/// {@template salon_state_placeholder}
/// Entity placeholder for SalonState
/// {@endtemplate}
typedef SalonEntity = List<Salon>;

/// {@template salon_state}
/// SalonState.
/// {@endtemplate}
sealed class SalonState extends _$SalonStateBase {
  /// Idling state
  /// {@macro salon_state}
  const factory SalonState.idle({
    required SalonEntity? data,
    required Salon? currentSalon,
    String message,
  }) = SalonState$Idle;

  /// Processing
  /// {@macro salon_state}
  const factory SalonState.processing({
    required SalonEntity? data,
    required Salon? currentSalon,
    String message,
  }) = SalonState$Processing;

  /// Successful
  /// {@macro salon_state}
  const factory SalonState.successful({
    required SalonEntity? data,
    required Salon? currentSalon,
    String message,
  }) = SalonState$Successful;

  /// An error has occurred
  /// {@macro salon_state}
  const factory SalonState.error({
    required SalonEntity? data,
    required Salon? currentSalon,
    String message,
  }) = SalonState$Error;

  /// {@macro salon_state}
  const SalonState({
    required super.data,
    required super.currentSalon,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class SalonState$Idle extends SalonState with _$SalonState {
  /// {@nodoc}
  const SalonState$Idle(
      {required super.data,
      required super.currentSalon,
      super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class SalonState$Processing extends SalonState with _$SalonState {
  /// {@nodoc}
  const SalonState$Processing(
      {required super.data,
      required super.currentSalon,
      super.message = 'Processing'});
}

/// Successful
/// {@nodoc}
final class SalonState$Successful extends SalonState with _$SalonState {
  /// {@nodoc}
  const SalonState$Successful(
      {required super.data,
      required super.currentSalon,
      super.message = 'Successful'});
}

/// Error
/// {@nodoc}
final class SalonState$Error extends SalonState with _$SalonState {
  /// {@nodoc}
  const SalonState$Error(
      {required super.data,
      required super.currentSalon,
      super.message = 'An error has occurred.'});
}

/// {@nodoc}
base mixin _$SalonState on SalonState {}

/// Pattern matching for [SalonState].
typedef SalonStateMatch<R, S extends SalonState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$SalonStateBase {
  /// {@nodoc}
  const _$SalonStateBase({
    required this.data,
    required this.currentSalon,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final SalonEntity? data;

  final Salon? currentSalon;

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

  /// Pattern matching for [SalonState].
  R map<R>({
    required SalonStateMatch<R, SalonState$Idle> idle,
    required SalonStateMatch<R, SalonState$Processing> processing,
    required SalonStateMatch<R, SalonState$Successful> successful,
    required SalonStateMatch<R, SalonState$Error> error,
  }) =>
      switch (this) {
        SalonState$Idle s => idle(s),
        SalonState$Processing s => processing(s),
        SalonState$Successful s => successful(s),
        SalonState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [SalonState].
  R maybeMap<R>({
    SalonStateMatch<R, SalonState$Idle>? idle,
    SalonStateMatch<R, SalonState$Processing>? processing,
    SalonStateMatch<R, SalonState$Successful>? successful,
    SalonStateMatch<R, SalonState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [SalonState].
  R? mapOrNull<R>({
    SalonStateMatch<R, SalonState$Idle>? idle,
    SalonStateMatch<R, SalonState$Processing>? processing,
    SalonStateMatch<R, SalonState$Successful>? successful,
    SalonStateMatch<R, SalonState$Error>? error,
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
