import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/common/utils/pattern_match.dart';

@immutable
sealed class TimeblockEvent extends _$TimeblockEventBase {
  const TimeblockEvent();

  const factory TimeblockEvent.fetch({
    required int timetableId,
    required int timeblockId,
  }) = TimeblockEvent$Fetch;

  const factory TimeblockEvent.toggle({
    required int timetableId,
    required int timeblockId,
    required bool onWork,
  }) = TimeblockEvent$Toggle;
}

final class TimeblockEvent$Fetch extends TimeblockEvent {
  const TimeblockEvent$Fetch({
    required this.timetableId,
    required this.timeblockId,
  });

  final int timetableId;
  final int timeblockId;
}

final class TimeblockEvent$Toggle extends TimeblockEvent {
  const TimeblockEvent$Toggle({
    required this.timetableId,
    required this.timeblockId,
    required this.onWork,
  });

  final int timetableId;
  final int timeblockId;
  final bool onWork;
}

abstract base class _$TimeblockEventBase {
  const _$TimeblockEventBase();

  R map<R>({
    required PatternMatch<R, TimeblockEvent$Fetch> fetch,
    required PatternMatch<R, TimeblockEvent$Toggle> toggle,
  }) =>
      switch (this) {
        final TimeblockEvent$Fetch s => fetch(s),
        final TimeblockEvent$Toggle s => toggle(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimeblockEvent$Fetch>? fetch,
    PatternMatch<R, TimeblockEvent$Toggle>? toggle,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        toggle: toggle ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    PatternMatch<R, TimeblockEvent$Fetch>? fetch,
    PatternMatch<R, TimeblockEvent$Toggle>? toggle,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        toggle: toggle ?? (_) => null,
      );
}
