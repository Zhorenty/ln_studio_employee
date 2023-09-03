import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/shedule/model/timetable.dart';

/// Wardrobe event.
sealed class SheduleState extends _$SheduleStateBase {
  const SheduleState._({
    required super.timetables,
    super.error,
  });

  /// Wardrobe is idle.
  const factory SheduleState.idle({
    List<Timetable> timetables,
    String? error,
  }) = _SheduleState$Idle;

  /// Wardrobe is loaded.
  const factory SheduleState.loaded({
    required List<Timetable> timetables,
    String? error,
  }) = _SheduleState$Loaded;
}

/// [SheduleState.idle] state matcher.
final class _SheduleState$Idle extends SheduleState {
  const _SheduleState$Idle({
    super.timetables = const [],
    super.error,
  }) : super._();
}

/// [SheduleState.loaded] state matcher.
final class _SheduleState$Loaded extends SheduleState {
  const _SheduleState$Loaded({
    required super.timetables,
    super.error,
  }) : super._();
}

/// Wardrobe state base class.
@immutable
abstract base class _$SheduleStateBase {
  const _$SheduleStateBase({required this.timetables, this.error});

  @nonVirtual
  final List<Timetable> timetables;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether timetables is not empty.
  bool get hasTimetables => timetables.isNotEmpty;

  /// Indicator whether state is already loaded.
  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _SheduleState$Idle> idle,
    required PatternMatch<R, _SheduleState$Loaded> loaded,
  }) =>
      switch (this) {
        final _SheduleState$Idle idleState => idle(idleState),
        final _SheduleState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _SheduleState$Idle>? idle,
    PatternMatch<R, _SheduleState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'SheduleState(Wardrobe: $timetables, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(timetables, error);
}
