import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/staff/model/employee_preview.dart';

import '/src/common/utils/pattern_match.dart';

/// Staff states.
sealed class StaffState extends _$StaffStateBase {
  const StaffState._({required super.employeeStaff, super.error});

  /// Staff is idle.
  const factory StaffState.idle({
    List<EmployeePreview> employeeStaff,
    String? error,
  }) = _StaffState$Idle;

  /// Staff is loaded.
  const factory StaffState.loaded({
    required List<EmployeePreview> employeeStaff,
    String? error,
  }) = _StaffState$Loaded;
}

/// [StaffState.idle] state matcher.
final class _StaffState$Idle extends StaffState {
  const _StaffState$Idle({
    super.employeeStaff = const [],
    super.error,
  }) : super._();
}

/// [StaffState.loaded] state matcher.
final class _StaffState$Loaded extends StaffState {
  const _StaffState$Loaded({
    required super.employeeStaff,
    super.error,
  }) : super._();
}

/// Staff state base class.
@immutable
abstract base class _$StaffStateBase {
  const _$StaffStateBase({required this.employeeStaff, this.error});

  @nonVirtual
  final List<EmployeePreview> employeeStaff;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Staffs is not empty.
  bool get hasStaffs => employeeStaff.isNotEmpty;

  /// Indicator whether state is already loaded.
  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _StaffState$Idle> idle,
    required PatternMatch<R, _StaffState$Loaded> loaded,
  }) =>
      switch (this) {
        final _StaffState$Idle idleState => idle(idleState),
        final _StaffState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _StaffState$Idle>? idle,
    PatternMatch<R, _StaffState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'StaffState(Staff: $employeeStaff, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(employeeStaff, error);
}
