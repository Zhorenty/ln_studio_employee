import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/staff/model/employee.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/timetable/model/employee.dart';

sealed class EmployeeState extends _$EmployeeStateBase {
  const EmployeeState._({
    super.employee,
    super.error,
  });

  const factory EmployeeState.idle({
    EmployeeModel? employee,
    String? error,
  }) = _EmployeeState$Idle;

  const factory EmployeeState.processing({
    EmployeeModel? employee,
    String? error,
  }) = _EmployeeState$Processing;
}

final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({
    super.employee,
    super.error,
  }) : super._();
}

final class _EmployeeState$Processing extends EmployeeState {
  const _EmployeeState$Processing({
    super.employee,
    super.error,
  }) : super._();
}

@immutable
abstract base class _$EmployeeStateBase {
  const _$EmployeeStateBase({
    this.employee,
    this.error,
  });

  @nonVirtual
  final EmployeeModel? employee;

  @nonVirtual
  final String? error;

  bool get hasError => error != null;

  bool get hasEmployee => employee != null;

  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

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
  String toString() => 'EmployeeState(Employee: $Employee, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(Employee, error);
}
