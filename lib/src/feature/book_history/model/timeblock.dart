import 'package:flutter/foundation.dart';

///
@immutable
final class EmployeeTimeblock$Response {
  const EmployeeTimeblock$Response({
    required this.id,
    required this.time,
  });

  ///
  final int id;

  final String time;

  ///
  factory EmployeeTimeblock$Response.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeblock$Response(
      id: json['id'] as int,
      time: json['time'] as String,
    );
  }

  /// Converts [EmployeeTimeblock$Response] to a JSON object.
  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time,
      };
}
