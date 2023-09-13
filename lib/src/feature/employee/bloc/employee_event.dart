import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Employee events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

  /// Factory for fetching employee by id.
  const factory EmployeeEvent.fetch({required int id}) = EmployeeEvent$Fetch;

  /// Factory for filling timetable.
  const factory EmployeeEvent.editEmployee({
    /// Employee information
    required int id,
    required String description,
    required String address,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
    required DateTime dateOfEmployment,

    /// User information
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime birthDate,
  }) = EmployeeEvent$EditEmployee;

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

/// [EmployeeEvent.editEmployee] event.
final class EmployeeEvent$EditEmployee extends EmployeeEvent {
  const EmployeeEvent$EditEmployee({
    /// Employee information
    required this.id,
    required this.description,
    required this.address,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.dateOfEmployment,

    /// User information
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
  }) : super();

  /// Employee information
  final int id;
  final String description;
  final String address;
  final String contractNumber;
  final double percentageOfSales;
  final int stars;
  final DateTime dateOfEmployment;

  /// User information
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime birthDate;
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
    required PatternMatch<R, EmployeeEvent$EditEmployee> editEmployee,
    required PatternMatch<R, EmployeeEvent$Dismiss> dismiss,
    required PatternMatch<R, EmployeeEvent$Reinstatement> reinstatement,
  }) =>
      switch (this) {
        final EmployeeEvent$Fetch s => fetch(s),
        final EmployeeEvent$EditEmployee s => editEmployee(s),
        final EmployeeEvent$Dismiss s => dismiss(s),
        final EmployeeEvent$Reinstatement s => reinstatement(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
    PatternMatch<R, EmployeeEvent$Dismiss>? dismiss,
    PatternMatch<R, EmployeeEvent$Reinstatement>? reinstatement,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        editEmployee: editEmployee ?? (_) => orElse(),
        dismiss: dismiss ?? (_) => orElse(),
        reinstatement: reinstatement ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
    PatternMatch<R, EmployeeEvent$Dismiss>? dismiss,
    PatternMatch<R, EmployeeEvent$Reinstatement>? reinstatement,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        editEmployee: editEmployee ?? (_) => null,
        dismiss: dismiss ?? (_) => null,
        reinstatement: reinstatement ?? (_) => null,
      );
}
