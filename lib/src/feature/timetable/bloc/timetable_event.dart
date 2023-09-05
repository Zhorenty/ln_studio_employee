import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/timetable/model/fill_time_blocks.dart';

/// Timetable events.
@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  const factory TimetableEvent.fetch() = TimetableEvent$Fetch;

  const factory TimetableEvent.fillTimetable(
    FillTimetable fillTimetables,
  ) = TimetableEvent$FillTimetables;
}

/// [TimetableEvent.fetch] event.
final class TimetableEvent$Fetch extends TimetableEvent {
  const TimetableEvent$Fetch() : super();
}

/// [TimetableEvent.fillTimetable] event.
final class TimetableEvent$FillTimetables extends TimetableEvent {
  const TimetableEvent$FillTimetables(this.fillTimetables) : super();

  /// Timetable items to fill.
  final FillTimetable fillTimetables;
}

/// Timetable events base class.
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimetableEvent$Fetch> fetch,
    required PatternMatch<R, TimetableEvent$FillTimetables> fillTimetables,
    deleteTimetableItems,
  }) =>
      switch (this) {
        final TimetableEvent$Fetch s => fetch(s),
        final TimetableEvent$FillTimetables s => fillTimetables(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetables,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        fillTimetables: fillTimetables ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetables,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        fillTimetables: fillTimetables ?? (_) => null,
      );
}
