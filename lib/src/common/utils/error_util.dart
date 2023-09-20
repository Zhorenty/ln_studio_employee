import '/src/common/exception/employee_exception.dart';
import '/src/common/exception/error_code.dart';
import '/src/common/localization/app_localization.dart';

/// Utility class for handling and formatting errors.
sealed class ErrorUtil {
  /// Formats an `EmployeeException` error message based on its type.
  static String formatError(Object error) => switch (error) {
        final EmployeeException e => _localizeEmployeeException(e),
        final Exception e => _localizeError(
            'Exception occured: $e',
            (l) => l.exceptionOccurred(e.toString()),
          ),
        final dynamic e => _localizeError(
            'Unknown Exception: $e',
            (l) => l.unknownError(e.toString()),
          ),
      };

  /// Formats an `EmployeeException` error message based on its type.
  static String _localizeEmployeeException(EmployeeException exception) =>
      switch (exception) {
        final EmployeeException$PhoneExists _ => _localizeError(
            'Phone exists',
            (l) => l.phoneExists,
          ),
        _ => _localizeError(
            'Unknown',
            (l) => l.unknownError(exception.toString()),
          ),
      };

  /// Localizes an error message using the provided `localize` function.
  static String _localizeError(
    String fallback,
    String Function(Localization l) localize,
  ) {
    try {
      return localize(Localization.current!);
    } on Object {
      return fallback;
    }
  }

  /// `Never` returns as it always throws an exception.
  static Never throwEmployeeException(ErrorCode code, String message) =>
      throw switch (code) {
        ErrorCode.phoneExists => const EmployeeException$PhoneExists(),
        ErrorCode.unknown => EmployeeException$Unknown(message: message),
      };
}
