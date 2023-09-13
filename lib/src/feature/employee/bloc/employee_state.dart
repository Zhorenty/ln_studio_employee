import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/staff/model/employee.dart';

/// Employee states.
sealed class EmployeeState extends _$EmployeeStateBase {
  const EmployeeState._({super.employee, super.error});

  /// Employee is idling.
  const factory EmployeeState.idle({
    EmployeeModel? employee,
    String? error,
  }) = _EmployeeState$Idle;

  /// Employee is processing.
  const factory EmployeeState.processing({
    EmployeeModel? employee,
    String? error,
  }) = _EmployeeState$Processing;
}

/// [EmployeeState.idle] state matcher.
final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({super.employee, super.error}) : super._();
}

/// [EmployeeState.processing] state matcher.
final class _EmployeeState$Processing extends EmployeeState {
  const _EmployeeState$Processing({super.employee, super.error}) : super._();
}

/// Employee state base class.
@immutable
abstract base class _$EmployeeStateBase {
  const _$EmployeeStateBase({this.employee, this.error});

  @nonVirtual
  final EmployeeModel? employee;

  @nonVirtual
  final String? error;

  /// Indicator whether has error.
  bool get hasError => error != null;

  /// Indicator whether has [EmployeeModel] is not empty.
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

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _EmployeeState$Idle> idle,
    required PatternMatch<R, _EmployeeState$Processing> processing,
  }) =>
      switch (this) {
        final _EmployeeState$Idle idleState => idle(idleState),
        final _EmployeeState$Processing processingState =>
          processing(processingState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Processing>? processing,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  @override
  String toString() => 'EmployeeState(Employee: $employee, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(employee, error);
}
