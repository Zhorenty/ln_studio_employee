import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

@immutable
sealed class TimetableEvent extends _$TimetableEventBase {
  const TimetableEvent();

  const factory TimetableEvent.fetch() = TimetableEvent$Fetch;
}

///
final class TimetableEvent$Fetch extends TimetableEvent {
  const TimetableEvent$Fetch() : super();
}

///
abstract base class _$TimetableEventBase {
  const _$TimetableEventBase();

  ///
  R map<R>({required PatternMatch<R, TimetableEvent$Fetch> fetch}) =>
      switch (this) {
        final TimetableEvent$Fetch s => fetch(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, TimetableEvent$Fetch>? fetch,
  }) =>
      map<R>(fetch: fetch ?? (_) => orElse());

  ///
  R? mapOrNull<R>({PatternMatch<R, TimetableEvent$Fetch>? fetch}) => map<R?>(
        fetch: fetch ?? (_) => null,
      );
}
