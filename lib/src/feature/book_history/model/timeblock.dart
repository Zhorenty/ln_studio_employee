import 'package:flutter/foundation.dart';

///
@immutable
final class EmployeeTimeblock$Response {
  const EmployeeTimeblock$Response({
    required this.id,
    required this.time,
    required this.onWork,
  });

  ///
  final int id;
  final String time;
  final bool onWork;

  ///
  factory EmployeeTimeblock$Response.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeblock$Response(
      id: json['id'] as int,
      time: json['time'] as String,
      onWork: json['on_work'] ?? false,
    );
  }

  /// Converts [EmployeeTimeblock$Response] to a JSON object.
  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time,
        'on_work': onWork,
      };

  EmployeeTimeblock$Response copyWith({
    int? id,
    String? time,
    bool? onWork,
  }) =>
      EmployeeTimeblock$Response(
        id: id ?? this.id,
        time: time ?? this.time,
        onWork: onWork ?? this.onWork,
      );
}
