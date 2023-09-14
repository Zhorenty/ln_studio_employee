// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

// /// {@template create_employee_state_placeholder}
// /// Entity placeholder for CreateEmployeeState
// /// {@endtemplate}
// typedef CreateEmployeeEntity = Object;

/// {@template create_employee_state}
/// CreateEmployeeState.
/// {@endtemplate}
sealed class CreateEmployeeState extends _$CreateEmployeeStateBase {
  /// Idling state
  /// {@macro create_employee_state}
  const factory CreateEmployeeState.idle({
    // required CreateEmployeeEntity? data,
    String message,
  }) = CreateEmployeeState$Idle;

  /// Processing
  /// {@macro create_employee_state}
  const factory CreateEmployeeState.processing({
    // required CreateEmployeeEntity? data,
    String message,
  }) = CreateEmployeeState$Processing;

  /// Successful
  /// {@macro create_employee_state}
  const factory CreateEmployeeState.successful({
    // required CreateEmployeeEntity? data,
    String message,
  }) = CreateEmployeeState$Successful;

  /// An error has occurred
  /// {@macro create_employee_state}
  const factory CreateEmployeeState.error({
    // required CreateEmployeeEntity? data,
    String message,
  }) = CreateEmployeeState$Error;

  /// {@macro create_employee_state}
  const CreateEmployeeState({
    // required super.data,
    required super.message,
  });
}

/// Idling state
/// {@nodoc}
final class CreateEmployeeState$Idle extends CreateEmployeeState
    with _$CreateEmployeeState {
  /// {@nodoc}
  const CreateEmployeeState$Idle({
    // required super.data,
    super.message = 'Idling',
  });
}

/// Processing
/// {@nodoc}
final class CreateEmployeeState$Processing extends CreateEmployeeState
    with _$CreateEmployeeState {
  /// {@nodoc}
  const CreateEmployeeState$Processing({
    // required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class CreateEmployeeState$Successful extends CreateEmployeeState
    with _$CreateEmployeeState {
  /// {@nodoc}
  const CreateEmployeeState$Successful({
    // required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class CreateEmployeeState$Error extends CreateEmployeeState
    with _$CreateEmployeeState {
  /// {@nodoc}
  const CreateEmployeeState$Error({
    // required super.data,
    super.message = 'Произошла ошибка',
  });
}

/// {@nodoc}
base mixin _$CreateEmployeeState on CreateEmployeeState {}

/// Pattern matching for [CreateEmployeeState].
typedef CreateEmployeeStateMatch<R, S extends CreateEmployeeState> = R Function(
    S state);

/// {@nodoc}
@immutable
abstract base class _$CreateEmployeeStateBase {
  /// {@nodoc}
  const _$CreateEmployeeStateBase({
    // required this.data,
    required this.message,
  });

  // /// Data entity payload.
  // @nonVirtual
  // final CreateEmployeeEntity? data;

  /// Message or state description.
  @nonVirtual
  final String message;

  // /// Has data?
  // bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [CreateEmployeeState].
  R map<R>({
    required CreateEmployeeStateMatch<R, CreateEmployeeState$Idle> idle,
    required CreateEmployeeStateMatch<R, CreateEmployeeState$Processing>
        processing,
    required CreateEmployeeStateMatch<R, CreateEmployeeState$Successful>
        successful,
    required CreateEmployeeStateMatch<R, CreateEmployeeState$Error> error,
  }) =>
      switch (this) {
        CreateEmployeeState$Idle s => idle(s),
        CreateEmployeeState$Processing s => processing(s),
        CreateEmployeeState$Successful s => successful(s),
        CreateEmployeeState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [CreateEmployeeState].
  R maybeMap<R>({
    CreateEmployeeStateMatch<R, CreateEmployeeState$Idle>? idle,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Processing>? processing,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Successful>? successful,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Error>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [CreateEmployeeState].
  R? mapOrNull<R>({
    CreateEmployeeStateMatch<R, CreateEmployeeState$Idle>? idle,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Processing>? processing,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Successful>? successful,
    CreateEmployeeStateMatch<R, CreateEmployeeState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  // // @override
  // // int get hashCode => data.hashCode;

  // @override
  // bool operator ==(Object other) => identical(this, other);
}
