import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';
import '/src/feature/employee/model/employee/employee.dart';

/// Employee states.
sealed class EmployeeAvatarState extends _$EmployeeAvatarStateBase {
  const EmployeeAvatarState._({super.imageUrl, super.error});

  /// Employee is idling.
  const factory EmployeeAvatarState.idle({
    String? imageUrl,
    String? error,
  }) = _EmployeeAvatarState$Idle;

  /// Employee is processing.
  const factory EmployeeAvatarState.processing({
    String? imageUrl,
    String? error,
  }) = _EmployeeAvatarState$Processing;

  const factory EmployeeAvatarState.successful({String? imageUrl}) =
      _EmployeeAvatarState$Successful;
}

/// [EmployeeAvatarState.idle] state matcher.
final class _EmployeeAvatarState$Idle extends EmployeeAvatarState {
  const _EmployeeAvatarState$Idle({super.imageUrl, super.error}) : super._();
}

/// [EmployeeAvatarState.processing] state matcher.
final class _EmployeeAvatarState$Processing extends EmployeeAvatarState {
  const _EmployeeAvatarState$Processing({super.imageUrl, super.error})
      : super._();
}

/// [EmployeeAvatarState.successful] state matcher.
final class _EmployeeAvatarState$Successful extends EmployeeAvatarState {
  const _EmployeeAvatarState$Successful({super.imageUrl}) : super._();
}

/// Employee state base class.
@immutable
abstract base class _$EmployeeAvatarStateBase {
  const _$EmployeeAvatarStateBase({this.imageUrl, this.error});

  @nonVirtual
  final String? imageUrl;

  @nonVirtual
  final String? error;

  /// Indicator whether has error.
  bool get hasError => error != null;

  /// Indicator whether has [Employee] is not empty.
  bool get hasImage => imageUrl != null;

  /// Indicator whether state is processing now.
  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is idling now.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is succesful now.
  bool get isSuccessful => maybeMap(
        idle: (_) => false,
        orElse: () => false,
        successful: (_) => true,
      );

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, _EmployeeAvatarState$Idle> idle,
    required PatternMatch<R, _EmployeeAvatarState$Processing> processing,
    required PatternMatch<R, _EmployeeAvatarState$Successful> successful,
  }) =>
      switch (this) {
        final _EmployeeAvatarState$Idle idleState => idle(idleState),
        final _EmployeeAvatarState$Processing processingState =>
          processing(processingState),
        final _EmployeeAvatarState$Successful succesfulState =>
          successful(succesfulState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeAvatarState$Idle>? idle,
    PatternMatch<R, _EmployeeAvatarState$Processing>? processing,
    PatternMatch<R, _EmployeeAvatarState$Successful>? successful,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
      );

  R? mapOrNull<R>({
    PatternMatch<R, _EmployeeAvatarState$Idle>? idle,
    PatternMatch<R, _EmployeeAvatarState$Processing>? processing,
    PatternMatch<R, _EmployeeAvatarState$Successful>? successful,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
      );

  @override
  String toString() =>
      'EmployeeAvatarState(imageUrl: $imageUrl, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(imageUrl, error);
}
