import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Staff events.
@immutable
sealed class StaffEvent extends _$StaffEventBase {
  const StaffEvent();

  /// Factory for fetching staff.
  const factory StaffEvent.fetch() = StaffEvent$Fetch;
}

/// [StaffEvent.fetch] event.
final class StaffEvent$Fetch extends StaffEvent {
  const StaffEvent$Fetch() : super();
}

/// Staff events base class.
abstract base class _$StaffEventBase {
  const _$StaffEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, StaffEvent$Fetch> fetch,
  }) =>
      switch (this) {
        final StaffEvent$Fetch s => fetch(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, StaffEvent$Fetch>? fetch,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, StaffEvent$Fetch>? fetch,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
      );
}
