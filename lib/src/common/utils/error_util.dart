import '/src/common/exception/employee_exception.dart';
import '/src/common/exception/error_code.dart';
import '/src/common/localization/app_localization.dart';

sealed class ErrorUtil {
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

  static String _localizeEmployeeException(
    EmployeeException exception,
  ) =>
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

  static Never throwEmployeeException(ErrorCode code, String message) =>
      throw switch (code) {
        ErrorCode.phoneExists => const EmployeeException$PhoneExists(),
        ErrorCode.unknown => EmployeeException$Unknown(message: message),
      };
}
