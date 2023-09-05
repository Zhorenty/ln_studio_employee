import 'package:flutter/foundation.dart';

/// Employee's timetable
@immutable
final class Employee {
  const Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  /// Employee's ID
  final int id;

  /// Employee's first name
  final String firstName;

  /// Employee's last name
  final String lastName;

  /// Returns employee from [json].
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
