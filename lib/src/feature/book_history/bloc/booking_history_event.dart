import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// BookingHistory events.
@immutable
sealed class BookingHistoryEvent extends _$BookingHistoryEventBase {
  const BookingHistoryEvent();

  /// Factory for fetching BookingHistory.
  const factory BookingHistoryEvent.fetchByEmployee({required int id}) =
      BookingHistoryEvent$Fetch;

  /// Factory for done booking.
  const factory BookingHistoryEvent.done({required int bookingId}) =
      BookingHistoryEvent$Done;
}

/// [BookingHistoryEvent.fetch] event.
final class BookingHistoryEvent$Fetch extends BookingHistoryEvent {
  const BookingHistoryEvent$Fetch({required this.id});

  /// Employee's id.
  final int id;
}

/// [BookingHistoryEvent.done] event.
final class BookingHistoryEvent$Done extends BookingHistoryEvent {
  const BookingHistoryEvent$Done({required this.bookingId});

  /// Booking's id.
  final int bookingId;
}

/// BookingHistory events base class.
abstract base class _$BookingHistoryEventBase {
  const _$BookingHistoryEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, BookingHistoryEvent$Fetch> fetch,
    required PatternMatch<R, BookingHistoryEvent$Done> done,
  }) =>
      switch (this) {
        final BookingHistoryEvent$Fetch s => fetch(s),
        final BookingHistoryEvent$Done s => done(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Done>? done,
  }) =>
      map<R>(
        fetch: fetch ?? (_) => orElse(),
        done: done ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, BookingHistoryEvent$Fetch>? fetch,
    PatternMatch<R, BookingHistoryEvent$Done>? done,
  }) =>
      map<R?>(
        fetch: fetch ?? (_) => null,
        done: done ?? (_) => null,
      );
}
