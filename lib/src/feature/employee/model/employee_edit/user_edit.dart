import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';

///
@immutable
final class UserModel$Edit {
  const UserModel$Edit({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
  });

  ///
  final String phone;

  ///
  final String firstName;

  ///
  final String lastName;

  ///
  final String email;

  ///
  final DateTime birthDate;

  /// Returns [UserModel$Edit] from [json].
  factory UserModel$Edit.fromJson(Map<String, dynamic> json) {
    return UserModel$Edit(
      phone: json['phone'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
    );
  }

  /// Converts [UserModel$Edit] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'phone': phone,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': birthDate.format(),
      };
}
