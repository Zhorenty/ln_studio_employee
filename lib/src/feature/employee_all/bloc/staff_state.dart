import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/employee/model/employee/employee.dart';

/// Staff states.
sealed class StaffState extends _$StaffStateBase {
  const StaffState._({required super.staff, super.error});

  /// Staff is idle.
  const factory StaffState.idle({
    List<Employee> staff,
    String? error,
  }) = _StaffState$Idle;

  /// Staff is loaded.
  const factory StaffState.loaded({
    required List<Employee> staff,
    String? error,
  }) = _StaffState$Loaded;
}

/// [StaffState.idle] state matcher.
final class _StaffState$Idle extends StaffState {
  const _StaffState$Idle({
    super.staff = const [],
    super.error,
  }) : super._();
}

/// [StaffState.loaded] state matcher.
final class _StaffState$Loaded extends StaffState {
  const _StaffState$Loaded({
    required super.staff,
    super.error,
  }) : super._();
}

/// Staff state base class.
@immutable
abstract base class _$StaffStateBase {
  const _$StaffStateBase({required this.staff, this.error});

  @nonVirtual
  final List<Employee> staff;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether staff is not empty.
  bool get hasStaff => staff.isNotEmpty;

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
  String toString() => 'StaffState(Staff: $staff, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(staff, error);
}
