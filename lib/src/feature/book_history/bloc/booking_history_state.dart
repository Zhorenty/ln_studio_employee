import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/book_history/model/booking.dart';

import '/src/common/utils/pattern_match.dart';

/// BookingHistory states.
sealed class BookingHistoryState extends _$BookingHistoryStateBase {
  const BookingHistoryState._({required super.bookingHistory, super.error});

  /// BookingHistory is idle.
  const factory BookingHistoryState.idle({
    List<BookingModel> bookingHistory,
    String? error,
  }) = _BookingHistoryState$Idle;

  /// BookingHistory is processing.
  const factory BookingHistoryState.processing({
    List<BookingModel> bookingHistory,
    String? error,
  }) = _BookingHistoryState$Processing;

  /// BookingHistory is loaded.
  const factory BookingHistoryState.loaded({
    required List<BookingModel> bookingHistory,
    String? error,
  }) = _BookingHistoryState$Loaded;
}

/// [BookingHistoryState.idle] state matcher.
final class _BookingHistoryState$Idle extends BookingHistoryState {
  const _BookingHistoryState$Idle({
    super.bookingHistory = const [],
    super.error,
  }) : super._();
}

/// [BookingHistoryState.processing] state matcher.
final class _BookingHistoryState$Processing extends BookingHistoryState {
  const _BookingHistoryState$Processing({
    super.bookingHistory = const [],
    super.error,
  }) : super._();
}

/// [BookingHistoryState.loaded] state matcher.
final class _BookingHistoryState$Loaded extends BookingHistoryState {
  const _BookingHistoryState$Loaded({
    required super.bookingHistory,
    super.error,
  }) : super._();
}

/// BookingHistory state base class.
@immutable
abstract base class _$BookingHistoryStateBase {
  const _$BookingHistoryStateBase({required this.bookingHistory, this.error});

  @nonVirtual
  final List<BookingModel> bookingHistory;

  @nonVirtual
  final String? error;

  List<BookingModel> get upcomingEvents => bookingHistory.reversed
      .where(
        (e) => !e.isDone,
      )
      .toList();

  List<BookingModel> get pastEvents => bookingHistory.reversed
      .where(
        (e) => e.isDone,
      )
      .toList();

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether BookingHistory is not empty.
  bool get hasBookingHistory => bookingHistory.isNotEmpty;

  /// Indicator whether state is already loaded.
  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already loaded.
  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _BookingHistoryState$Idle> idle,
    required PatternMatch<R, _BookingHistoryState$Processing> processing,
    required PatternMatch<R, _BookingHistoryState$Loaded> loaded,
  }) =>
      switch (this) {
        final _BookingHistoryState$Idle idleState => idle(idleState),
        final _BookingHistoryState$Processing processingState =>
          processing(processingState),
        final _BookingHistoryState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _BookingHistoryState$Idle>? idle,
    PatternMatch<R, _BookingHistoryState$Processing>? processing,
    PatternMatch<R, _BookingHistoryState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'BookingHistoryState(BookingHistory: $bookingHistory, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(bookingHistory, error);
}

@Deprecated('Теперь сортируем по isDone')
// ignore: unused_element
bool _isAfter(String dateAt, String timeblock, bool isNegative) {
  // Разделяем значение timeblock на отдельные части
  List<String> timeblockParts = timeblock.split(':');
  int hours = int.parse(timeblockParts[0]);
  int minutes = int.parse(timeblockParts[1]);
  int seconds = int.parse(timeblockParts[2]);

  // Создаем объект DateTime для dateAt и timeblock
  DateTime dateAtDateTime = DateTime.parse(dateAt);
  DateTime timeblockDateTime = DateTime(
    dateAtDateTime.year,
    dateAtDateTime.month,
    dateAtDateTime.day,
    hours,
    minutes,
    seconds,
  );

  // Сравниваем даты
  DateTime now = DateTime.now();
  if (isNegative
      ? !now.isAfter(timeblockDateTime)
      : now.isAfter(timeblockDateTime)) {
    return true;
  } else {
    return false;
  }
}
