import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Specialization events.
@immutable
sealed class SpecializationEvent extends _$SpecializationEventBase {
  const SpecializationEvent();

  /// Factory for fetching staff.
  const factory SpecializationEvent.fetchAll() = SpecializationEvent$FetchAll;
}

/// [SpecializationEvent.fetchAll] event.
final class SpecializationEvent$FetchAll extends SpecializationEvent {
  const SpecializationEvent$FetchAll() : super();
}

/// Specialization events base class.
abstract base class _$SpecializationEventBase {
  const _$SpecializationEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, SpecializationEvent$FetchAll> fetchAll,
  }) =>
      switch (this) {
        final SpecializationEvent$FetchAll s => fetchAll(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, SpecializationEvent$FetchAll>? fetchAll,
  }) =>
      map<R>(fetchAll: fetchAll ?? (_) => orElse());

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, SpecializationEvent$FetchAll>? fetchAll,
  }) =>
      map<R?>(fetchAll: fetchAll ?? (_) => null);
}
