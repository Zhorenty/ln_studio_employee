import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// Category events.
@immutable
sealed class CategoryEvent extends _$CategoryEventBase {
  const CategoryEvent();

  /// Factory for fetching Category.
  const factory CategoryEvent.fetchServiceCategories() =
      CategoryEvent$FetchServiceCategories;
}

/// [CategoryEvent.fetchServiceCategories] event.
final class CategoryEvent$FetchServiceCategories extends CategoryEvent {
  const CategoryEvent$FetchServiceCategories();
}

/// Category events base class.
abstract base class _$CategoryEventBase {
  const _$CategoryEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, CategoryEvent$FetchServiceCategories>
        fetchServiceCategories,
  }) =>
      switch (this) {
        final CategoryEvent$FetchServiceCategories s =>
          fetchServiceCategories(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, CategoryEvent$FetchServiceCategories>?
        fetchServiceCategories,
  }) =>
      map<R>(
        fetchServiceCategories: fetchServiceCategories ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, CategoryEvent$FetchServiceCategories>?
        fetchServiceCategories,
  }) =>
      map<R?>(
        fetchServiceCategories: fetchServiceCategories ?? (_) => null,
      );
}
