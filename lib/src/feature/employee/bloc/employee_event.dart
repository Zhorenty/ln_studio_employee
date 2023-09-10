import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent();

  /// Factory for filling timetable.
  const factory EmployeeEvent.editEmployee({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
    required String email,
  }) = EmployeeEvent$EditEmployee;
}

/// [EmployeeEvent.EditEmployee] event.
final class EmployeeEvent$EditEmployee extends EmployeeEvent {
  const EmployeeEvent$EditEmployee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.description,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.email,
  }) : super();

  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String description;
  final String email;
  final String contractNumber;
  final double percentageOfSales;
  final int stars;
}

/// Timetable events base class.
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeEvent$EditEmployee> editEmployee,
    deleteTimetableItems,
  }) =>
      switch (this) {
        final EmployeeEvent$EditEmployee s => editEmployee(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
  }) =>
      map<R>(
        editEmployee: editEmployee ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeEvent$EditEmployee>? editEmployee,
  }) =>
      map<R?>(
        editEmployee: editEmployee ?? (_) => null,
      );
}
