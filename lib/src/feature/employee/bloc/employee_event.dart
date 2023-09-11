import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

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

    /// User information
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
  }) = EmployeeEvent$EditEmployee;
}

final class EmployeeEvent$Fetch extends EmployeeEvent {
  const EmployeeEvent$Fetch({required this.id}) : super();

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

    /// User information
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
  }) : super();

  /// Employee information
  final int id;
  final String description;
  final String address;
  final String contractNumber;
  final double percentageOfSales;
  final int stars;

  /// User information
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
}

/// Timetable events base class.
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeEvent$Fetch> fetch,
    required PatternMatch<R, EmployeeEvent$EditEmployee> editEmployee,
  }) =>
      switch (this) {
        final EmployeeEvent$Fetch s => fetch(s),
        final EmployeeEvent$EditEmployee s => editEmployee(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        editEmployee: editEmployee ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$Fetch>? fetch,
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        editEmployee: editEmployee ?? (_) => null,
      );
}
