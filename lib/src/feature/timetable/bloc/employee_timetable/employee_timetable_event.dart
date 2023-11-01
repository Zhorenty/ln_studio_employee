import 'package:flutter/foundation.dart';

@immutable
sealed class EmployeeTimetableEvent extends _$EmployeeTimetableEventBase {
  const EmployeeTimetableEvent();

  const factory EmployeeTimetableEvent.fetchTimetable({
    required int employeeId,
    required int salonId,
  }) = EmployeeTimetableEvent$FetchTimetable;
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

typedef EmployeeTimetableEventMatch<R, S extends EmployeeTimetableEvent> = R
    Function(S event);

abstract base class _$EmployeeTimetableEventBase {
  const _$EmployeeTimetableEventBase();

  R map<R>({
    required EmployeeTimetableEventMatch<R,
            EmployeeTimetableEvent$FetchTimetable>
        fetchTimetable,
  }) =>
      switch (this) {
        final EmployeeTimetableEvent$FetchTimetable s => fetchTimetable(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    EmployeeTimetableEventMatch<R, EmployeeTimetableEvent$FetchTimetable>?
        fetchTimetable,
  }) =>
      map<R>(fetchTimetable: fetchTimetable ?? (_) => orElse());

  R? mapOrNull<R>({
    EmployeeTimetableEventMatch<R, EmployeeTimetableEvent$FetchTimetable>?
        fetchTimetable,
  }) =>
      map<R?>(fetchTimetable: fetchTimetable ?? (_) => null);
}
