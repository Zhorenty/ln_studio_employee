import 'package:flutter/foundation.dart';

import '/src/common/utils/annotation.dart';
import 'error_code.dart';

@immutable
@exception
sealed class EmployeeException implements Exception {
  const EmployeeException({
    required this.message,
    required this.code,
  });

  final String message;

  final ErrorCode code;

  @override
  String toString() => 'EmployeeException: $message, code: $code';
}

final class EmployeeException$Unknown extends EmployeeException {
  const EmployeeException$Unknown({super.message = 'Unknown'})
      : super(code: ErrorCode.unknown);
}

final class EmployeeException$PhoneExists extends EmployeeException {
  const EmployeeException$PhoneExists({super.message = 'Phone exists'})
      : super(code: ErrorCode.phoneExists);
}
