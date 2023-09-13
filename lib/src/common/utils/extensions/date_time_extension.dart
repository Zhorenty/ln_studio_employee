import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String format() => DateFormat('yyyy-MM-dd').format(this);
}
