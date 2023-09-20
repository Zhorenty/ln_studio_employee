import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';

/// Represents a user model with its create properties.
@immutable
final class UserModel$Create {
  const UserModel$Create({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
  });

  /// Phone number of user.
  final String phone;

  /// First name of user.
  final String firstName;

  /// Last name of user.
  final String lastName;

  /// Email of user.
  final String email;

  /// Birth date of user.
  final DateTime birthDate;

  /// Returns [UserModel$Create] from [json].
  factory UserModel$Create.fromJson(Map<String, dynamic> json) {
    return UserModel$Create(
      phone: json['phone'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
    );
  }

  /// Converts [UserModel$Create] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'phone': phone,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': birthDate.jsonFormat(),
      };
}
