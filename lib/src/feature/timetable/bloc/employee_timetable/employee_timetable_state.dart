import 'package:flutter/foundation.dart';

import 'package:ln_employee/src/feature/timetable/model/timetable_item.dart';

/// {@template auth_state}
/// EmployeeTimetable.
/// {@endtemplate}
sealed class EmployeeTimetableState extends _$EmployeeTimetableBase {
  /// {@macro auth_state}
  const EmployeeTimetableState({
    required super.timetables,
    required super.message,
  });

  /// Idling state
  /// {@macro auth_state}
  const factory EmployeeTimetableState.idle({
    required List<TimetableItem> timetables,
    String message,
    String? error,
  }) = EmployeeTimetable$Idle;

  /// Processing
  /// {@macro auth_state}
  const factory EmployeeTimetableState.processing({
    required List<TimetableItem> timetables,
    String message,
  }) = EmployeeTimetable$Processing;

  /// Successful
  /// {@macro auth_state}
  const factory EmployeeTimetableState.successful({
    required List<TimetableItem> timetables,
  }) = EmployeeTimetable$Successful;
}

/// Idling state
/// {@nodoc}
final class EmployeeTimetable$Idle extends EmployeeTimetableState
    with _$EmployeeTimetable {
  /// {@nodoc}
  const EmployeeTimetable$Idle({
    required super.timetables,
    super.message = 'Idling',
    this.error,
  });

  @override
  final String? error;
}

/// Processing
/// {@nodoc}
final class EmployeeTimetable$Processing extends EmployeeTimetableState
    with _$EmployeeTimetable {
  /// {@nodoc}
  const EmployeeTimetable$Processing({
    required super.timetables,
    super.message = 'Successful',
  });

  @override
  String? get error => null;
}

/// Successful
/// {@nodoc}
final class EmployeeTimetable$Successful extends EmployeeTimetableState
    with _$EmployeeTimetable {
  /// {@nodoc}
  const EmployeeTimetable$Successful({
    required super.timetables,
    super.message = 'Successful',
  });

  @override
  String? get error => null;
}

/// {@nodoc}
base mixin _$EmployeeTimetable on EmployeeTimetableState {}

/// Pattern matching for [EmployeeTimetable].
typedef EmployeeTimetableMatch<R, S extends EmployeeTimetableState> = R
    Function(S state);

/// {@nodoc}
@immutable
abstract base class _$EmployeeTimetableBase {
  /// {@nodoc}
  const _$EmployeeTimetableBase({
    required this.timetables,
    required this.message,
  });

  /// Data entity payload.
  @nonVirtual
  final List<TimetableItem> timetables;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Error message.
  abstract final String? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isSuccessful => maybeMap<bool>(
        orElse: () => false,
        successful: (_) => true,
      );

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(
        orElse: () => false,
        processing: (_) => true,
      );

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [EmployeeTimetable].
  R map<R>({
    required EmployeeTimetableMatch<R, EmployeeTimetable$Idle> idle,
    required EmployeeTimetableMatch<R, EmployeeTimetable$Processing> processing,
    required EmployeeTimetableMatch<R, EmployeeTimetable$Successful> successful,
  }) =>
      switch (this) {
        final EmployeeTimetable$Idle s => idle(s),
        final EmployeeTimetable$Processing s => processing(s),
        final EmployeeTimetable$Successful s => successful(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [EmployeeTimetable].
  R maybeMap<R>({
    required R Function() orElse,
    EmployeeTimetableMatch<R, EmployeeTimetable$Idle>? idle,
    EmployeeTimetableMatch<R, EmployeeTimetable$Processing>? processing,
    EmployeeTimetableMatch<R, EmployeeTimetable$Successful>? successful,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
      );

  /// Pattern matching for [EmployeeTimetable].
  R? mapOrNull<R>({
    EmployeeTimetableMatch<R, EmployeeTimetable$Idle>? idle,
    EmployeeTimetableMatch<R, EmployeeTimetable$Processing>? processing,
    EmployeeTimetableMatch<R, EmployeeTimetable$Successful>? successful,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
      );

  @override
  int get hashCode => timetables.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('EmployeeTimetable(')
      ..write('timetable: $timetables, ');
    if (error != null) buffer.write('error: $error, ');
    buffer
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
