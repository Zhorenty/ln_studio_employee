import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/common/utils/pattern_match.dart';

@immutable
sealed class TimeblockEvent extends _$TimeblockEventBase {
  const TimeblockEvent();

  const factory TimeblockEvent.add({
    required int timetableId,
    required List<int> timeblockIds,
  }) = TimeblockEvent$Add;
}

final class TimeblockEvent$Add extends TimeblockEvent {
  const TimeblockEvent$Add({
    required this.timetableId,
    required this.timeblockIds,
  });

  ///
  final int timetableId;

  ///
  final List<int> timeblockIds;
}

abstract base class _$TimeblockEventBase {
  const _$TimeblockEventBase();

  R map<R>({
    required PatternMatch<R, TimeblockEvent$Add> add,
  }) =>
      switch (this) {
        final TimeblockEvent$Add s => add(s),
        _ => throw AssertionError(),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimeblockEvent$Add>? add,
  }) =>
      map<R>(
        add: add ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    PatternMatch<R, TimeblockEvent$Add>? add,
  }) =>
      map<R?>(
        add: add ?? (_) => null,
      );
}
