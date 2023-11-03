import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/common/utils/pattern_match.dart';

@immutable
sealed class EmployeeTimetableEvent extends _$EmployeeTimetableEventBase {
  const EmployeeTimetableEvent();

  const factory EmployeeTimetableEvent.fetchTimetable({
    required int employeeId,
    required int salonId,
  }) = EmployeeTimetableEvent$FetchTimetable;

  /// Factory for filling timetable.
  const factory EmployeeTimetableEvent.fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) = EmployeeTimetableEvent$FillTimetables;
}

final class EmployeeTimetableEvent$FetchTimetable
    extends EmployeeTimetableEvent {
  const EmployeeTimetableEvent$FetchTimetable({
    required this.employeeId,
    required this.salonId,
  });

  ///
  final int employeeId;

  ///
  final int salonId;
}

/// [TimetableEvent.fillTimetable] event.
final class EmployeeTimetableEvent$FillTimetables
    extends EmployeeTimetableEvent {
  const EmployeeTimetableEvent$FillTimetables({
    required this.employeeId,
    required this.salonId,
    required this.dateAt,
  });

  /// Employee's id.
  final int employeeId;

  /// Current salon id.
  final int salonId;

  /// Dates to fill.
  final DateTime dateAt;
}

abstract base class _$EmployeeTimetableEventBase {
  const _$EmployeeTimetableEventBase();

  R map<R>({
    required PatternMatch<R, EmployeeTimetableEvent$FetchTimetable>
        fetchTimetable,
    required PatternMatch<R, EmployeeTimetableEvent$FillTimetables>
        fillTimetable,
  }) =>
      switch (this) {
        final EmployeeTimetableEvent$FetchTimetable s => fetchTimetable(s),
        final EmployeeTimetableEvent$FillTimetables s => fillTimetable(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeTimetableEvent$FetchTimetable>? fetchTimetable,
    PatternMatch<R, EmployeeTimetableEvent$FillTimetables>? fillTimetable,
  }) =>
      map<R>(
        fetchTimetable: fetchTimetable ?? (_) => orElse(),
        fillTimetable: fillTimetable ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    PatternMatch<R, EmployeeTimetableEvent$FetchTimetable>? fetchTimetable,
    PatternMatch<R, EmployeeTimetableEvent$FillTimetables>? fillTimetable,
  }) =>
      map<R?>(
        fetchTimetable: fetchTimetable ?? (_) => null,
        fillTimetable: fillTimetable ?? (_) => null,
      );
}
