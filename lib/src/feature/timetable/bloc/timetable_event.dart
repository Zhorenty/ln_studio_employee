import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/timetable/model/fill_time_blocks.dart';
import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';

import '/src/common/utils/pattern_match.dart';

/// Timetable events.
@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  const factory TimetableEvent.fetch() = TimetableEvent$Fetch;

  const factory TimetableEvent.fillTimetables(
    List<FillTimetable> fillTimetables,
  ) = TimetableEvent$FillTimetables;

  const factory TimetableEvent.deleteTimetableItems(
    List<TimetableItem> timetableItems,
  ) = TimetableEvent$DeleteTimetableItems;
}

/// [TimetableEvent.fetch] event.
final class TimetableEvent$Fetch extends TimetableEvent {
  const TimetableEvent$Fetch() : super();
}

/// [TimetableEvent.fillTimetables] event.
final class TimetableEvent$FillTimetables extends TimetableEvent {
  const TimetableEvent$FillTimetables(this.fillTimetables) : super();

  /// Timetable items to fill.
  final List<FillTimetable> fillTimetables;
}

/// [TimetableEvent.deleteTimetableItems] event.
final class TimetableEvent$DeleteTimetableItems extends TimetableEvent {
  const TimetableEvent$DeleteTimetableItems(this.timetableItems) : super();

  /// Timetable items to delete.
  final List<TimetableItem> timetableItems;
}

/// Timetable events base class.
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, TimetableEvent$Fetch> fetch,
    required PatternMatch<R, TimetableEvent$FillTimetables> fillTimetables,
    required PatternMatch<R, TimetableEvent$DeleteTimetableItems>
        deleteTimetableItems,
  }) =>
      switch (this) {
        final TimetableEvent$Fetch s => fetch(s),
        final TimetableEvent$FillTimetables s => fillTimetables(s),
        final TimetableEvent$DeleteTimetableItems s => deleteTimetableItems(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetables,
    PatternMatch<R, TimetableEvent$DeleteTimetableItems>? deleteTimetableItems,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        fillTimetables: fillTimetables ?? (_) => orElse(),
        deleteTimetableItems: deleteTimetableItems ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
    PatternMatch<R, TimetableEvent$FillTimetables>? fillTimetables,
    PatternMatch<R, TimetableEvent$DeleteTimetableItems>? deleteTimetableItems,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        fillTimetables: fillTimetables ?? (_) => null,
        deleteTimetableItems: deleteTimetableItems ?? (_) => null,
      );
}
