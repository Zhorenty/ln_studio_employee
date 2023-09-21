import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/specialization/model/specialization.dart';

/// Specialization states.
sealed class SpecializationState extends _$SpecializationStateBase {
  const SpecializationState._({required super.specializations, super.error});

  /// Specialization is idle.
  const factory SpecializationState.idle({
    List<Specialization> specializations,
    String? error,
  }) = _SpecializationState$Idle;

  /// Specialization is loaded.
  const factory SpecializationState.loaded({
    required List<Specialization> specializations,
    String? error,
  }) = _SpecializationState$Loaded;
}

/// [SpecializationState.idle] state matcher.
final class _SpecializationState$Idle extends SpecializationState {
  const _SpecializationState$Idle({
    super.specializations = const [],
    super.error,
  }) : super._();
}

/// [SpecializationState.loaded] state matcher.
final class _SpecializationState$Loaded extends SpecializationState {
  const _SpecializationState$Loaded({
    required super.specializations,
    super.error,
  }) : super._();
}

/// Specialization state base class.
@immutable
abstract base class _$SpecializationStateBase {
  const _$SpecializationStateBase({required this.specializations, this.error});

  @nonVirtual
  final List<Specialization> specializations;

  @nonVirtual
  final String? error;

  /// Indicator of whether there is an error.
  bool get hasError => error != null;

  /// Indicator whether Specialization is not empty.
  bool get hasSpecializations => specializations.isNotEmpty;

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
    required PatternMatch<R, _SpecializationState$Idle> idle,
    required PatternMatch<R, _SpecializationState$Loaded> loaded,
  }) =>
      switch (this) {
        final _SpecializationState$Idle idleState => idle(idleState),
        final _SpecializationState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _SpecializationState$Idle>? idle,
    PatternMatch<R, _SpecializationState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'SpecializationState(Specialization: $specializations, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(specializations, error);
}
