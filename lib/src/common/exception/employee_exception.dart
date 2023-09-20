import 'package:flutter/foundation.dart';

import '/src/common/utils/annotation.dart';
import 'error_code.dart';

/// Custom errors.
@immutable
@exception
sealed class EmployeeException implements Exception {
  const EmployeeException({required this.message, required this.code});

  /// Error message.
  final String message;

  /// Error code.
  final ErrorCode code;

  @override
  String toString() => 'EmployeeException: $message, code: $code';
}

/// Unknown exception.
final class EmployeeException$Unknown extends EmployeeException {
  const EmployeeException$Unknown({super.message = 'Unknown'})
      : super(code: ErrorCode.unknown);
}

/// Phone already exists exception.
final class EmployeeException$PhoneExists extends EmployeeException {
  const EmployeeException$PhoneExists({super.message = 'Phone exists'})
      : super(code: ErrorCode.phoneExists);
}
