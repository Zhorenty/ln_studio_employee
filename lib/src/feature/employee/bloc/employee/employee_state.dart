import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/employee/model/employee/employee.dart';

/// Employee states.
sealed class EmployeeState extends _$EmployeeStateBase {
  const EmployeeState._({super.employee, super.error});

  /// Employee is idling.
  const factory EmployeeState.idle({
    Employee? employee,
    String? error,
  }) = _EmployeeState$Idle;

  /// Employee is processing.
  const factory EmployeeState.processing({
    Employee? employee,
    String? error,
  }) = _EmployeeState$Processing;

  const factory EmployeeState.successful({Employee? employee}) =
      _EmployeeState$Successful;
}

/// [EmployeeState.idle] state matcher.
final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({super.employee, super.error}) : super._();
}

/// [EmployeeState.processing] state matcher.
final class _EmployeeState$Processing extends EmployeeState {
  const _EmployeeState$Processing({super.employee, super.error}) : super._();
}

/// [EmployeeState.successful] state matcher.
final class _EmployeeState$Successful extends EmployeeState {
  const _EmployeeState$Successful({super.employee}) : super._();
}

/// Employee state base class.
@immutable
abstract base class _$EmployeeStateBase {
  const _$EmployeeStateBase({this.employee, this.error});

  @nonVirtual
  final Employee? employee;

  @nonVirtual
  final String? error;

  /// Indicator whether has error.
  bool get hasError => error != null;

  /// Indicator whether has [Employee] is not empty.
  bool get hasEmployee => employee != null;

  /// Indicator whether state is processing now.
  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is idling now.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is succesful now.
  bool get isSuccessful => maybeMap(
        idle: (_) => false,
        orElse: () => false,
        successful: (_) => true,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _EmployeeState$Idle> idle,
    required PatternMatch<R, _EmployeeState$Processing> processing,
    required PatternMatch<R, _EmployeeState$Successful> successful,
  }) =>
      switch (this) {
        final _EmployeeState$Idle idleState => idle(idleState),
        final _EmployeeState$Processing processingState =>
          processing(processingState),
        final _EmployeeState$Successful succesfulState =>
          successful(succesfulState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Processing>? processing,
    PatternMatch<R, _EmployeeState$Successful>? successful,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Processing>? processing,
    PatternMatch<R, _EmployeeState$Successful>? successful,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
      );

  @override
  String toString() => 'EmployeeState(Employee: $employee, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(employee, error);
}
