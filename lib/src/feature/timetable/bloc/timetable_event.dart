import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  const factory TimetableEvent.fetch() = TimetableEvent$Fetch;

  const factory TimetableEvent.fillTimetable({
    required int employeeId,
    required int salonId,
    required DateTime dateAt,
  }) = TimetableEvent$FillTimetables;
}

/// [TimetableEvent.fetch] event.
final class TimetableEvent$Fetch extends TimetableEvent {
  const TimetableEvent$Fetch() : super();
}

/// [TimetableEvent.fillTimetable] event.
final class TimetableEvent$FillTimetables extends TimetableEvent {
  const TimetableEvent$FillTimetables({
    required this.employeeId,
    required this.salonId,
    required this.dateAt,
  }) : super();

  /// Employee's id.
  final int employeeId;

  /// Current salon id.
  final int salonId;

  /// Dates to fill.
  final DateTime dateAt;
}

/// Timetable events base class.
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimetableEvent$Fetch> fetch,
    required PatternMatch<R, TimetableEvent$FillTimetables> fillTimetable,
    deleteTimetableItems,
  }) =>
      switch (this) {
        final TimetableEvent$Fetch s => fetch(s),
        final TimetableEvent$FillTimetables s => fillTimetable(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetable,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        fillTimetable: fillTimetable ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetable,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        fillTimetable: fillTimetable ?? (_) => null,
      );
}
