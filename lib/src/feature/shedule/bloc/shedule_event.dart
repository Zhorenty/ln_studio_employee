import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

@immutable
sealed class SheduleEvent extends _$SheduleEventBase {
  const SheduleEvent();

  const factory SheduleEvent.fetch() = SheduleEvent$Fetch;
}

///
final class SheduleEvent$Fetch extends SheduleEvent {
  const SheduleEvent$Fetch() : super();
}

///
abstract base class _$SheduleEventBase {
  const _$SheduleEventBase();

  ///
  R map<R>({required PatternMatch<R, SheduleEvent$Fetch> fetch}) =>
      switch (this) {
        final SheduleEvent$Fetch s => fetch(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, SheduleEvent$Fetch>? fetch,
  }) =>
      map<R>(fetch: fetch ?? (_) => orElse());

  ///
  R? mapOrNull<R>({PatternMatch<R, SheduleEvent$Fetch>? fetch}) => map<R?>(
        fetch: fetch ?? (_) => null,
      );
}
