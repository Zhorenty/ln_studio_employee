import 'dart:io';

import 'package:flutter/foundation.dart';

import '/src/common/utils/pattern_match.dart';

/// EmployeeAvatar events.
@immutable
sealed class EmployeeAvatarEvent extends _$EmployeeAvatarEventBase {
  const EmployeeAvatarEvent();

  /// Factory for UploadAvataring employeeAvatar by id.
  const factory EmployeeAvatarEvent.uploadAvatar({
    required int id,
    required File file,
  }) = EmployeeAvatarEvent$UploadAvatar;
}

/// [EmployeeAvatarEvent.fetch] event.
final class EmployeeAvatarEvent$UploadAvatar extends EmployeeAvatarEvent {
  const EmployeeAvatarEvent$UploadAvatar({
    required this.id,
    required this.file,
  });

  /// EmployeeAvatar's id.
  final int id;

  ///
  final File file;
}

/// Timetable events base class.
abstract base class _$EmployeeAvatarEventBase {
  const _$EmployeeAvatarEventBase();

  /// Map over state union.
  R map<R>({
    required PatternMatch<R, EmployeeAvatarEvent$UploadAvatar> uploadAvatar,
  }) =>
      switch (this) {
        final EmployeeAvatarEvent$UploadAvatar s => uploadAvatar(s),
        _ => throw AssertionError(),
      };

  /// Map over state union or return default if no match.
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, EmployeeAvatarEvent$UploadAvatar>? uploadAvatar,
  }) =>
      map<R>(
        uploadAvatar: uploadAvatar ?? (_) => orElse(),
      );

  /// Map over state union or return null if no match.
  R? mapOrNull<R>({
    PatternMatch<R, EmployeeAvatarEvent$UploadAvatar>? uploadAvatar,
  }) =>
      map<R?>(
        uploadAvatar: uploadAvatar ?? (_) => null,
      );
}
