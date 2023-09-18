import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/employee/model/employee_create/employee_create.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';

/// Employee events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

  /// Factory for fetching employee by id.
  const factory EmployeeEvent.fetch({required int id}) = EmployeeEvent$Fetch;

  /// Factory for creating employee.
  const factory EmployeeEvent.create({required Employee$Create employee}) =
      EmployeeEvent$Create;

  /// Factory for editing current employee.
  const factory EmployeeEvent.edit({required Employee$Edit employee}) =
      EmployeeEvent$Edit;

  /// Factory for dismissing employee by id.
  const factory EmployeeEvent.dismiss({required int id}) =
      EmployeeEvent$Dismiss;

  /// Factory for reinstatement employee by id.
  const factory EmployeeEvent.reinstatement({required int id}) =
      EmployeeEvent$Reinstatement;
}

/// [EmployeeEvent.fetch] event.
final class EmployeeEvent$Fetch extends EmployeeEvent {
  const EmployeeEvent$Fetch({required this.id}) : super();

  /// Employee's id.
  final int id;
}

/// [EmployeeEvent.create] event.
final class EmployeeEvent$Create extends EmployeeEvent {
  const EmployeeEvent$Create({required this.employee}) : super();

  ///
  final Employee$Create employee;
}

/// [EmployeeEvent.edit] event.
final class EmployeeEvent$Edit extends EmployeeEvent {
  const EmployeeEvent$Edit({required this.employee}) : super();

  ///
  final Employee$Edit employee;
}

/// [EmployeeEvent.dismiss] event.
final class EmployeeEvent$Dismiss extends EmployeeEvent {
  const EmployeeEvent$Dismiss({required this.id}) : super();

  /// Employee's id.
  final int id;
}

/// [EmployeeEvent.reinstatement] event.
final class EmployeeEvent$Reinstatement extends EmployeeEvent {
  const EmployeeEvent$Reinstatement({required this.id}) : super();

  /// Employee's id.
  final int id;
}

/// Timetable events base class.
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeEvent$Fetch> fetch,
    required PatternMatch<R, EmployeeEvent$Create> create,
    required PatternMatch<R, EmployeeEvent$Edit> edit,
    required PatternMatch<R, EmployeeEvent$Dismiss> dismiss,
    required PatternMatch<R, EmployeeEvent$Reinstatement> reinstatement,
  }) =>
      switch (this) {
        final EmployeeEvent$Fetch s => fetch(s),
        final EmployeeEvent$Create s => create(s),
        final EmployeeEvent$Edit s => edit(s),
        final EmployeeEvent$Dismiss s => dismiss(s),
        final EmployeeEvent$Reinstatement s => reinstatement(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$Create>? create,
    PatternMatch<R, EmployeeEvent$Edit>? edit,
    PatternMatch<R, EmployeeEvent$Dismiss>? dismiss,
    PatternMatch<R, EmployeeEvent$Reinstatement>? reinstatement,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        create: create ?? (_) => orElse(),
        edit: edit ?? (_) => orElse(),
        dismiss: dismiss ?? (_) => orElse(),
        reinstatement: reinstatement ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$Create>? create,
    PatternMatch<R, EmployeeEvent$Edit>? edit,
    PatternMatch<R, EmployeeEvent$Dismiss>? dismiss,
    PatternMatch<R, EmployeeEvent$Reinstatement>? reinstatement,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        create: create ?? (_) => null,
        edit: edit ?? (_) => null,
        dismiss: dismiss ?? (_) => null,
        reinstatement: reinstatement ?? (_) => null,
      );
}
