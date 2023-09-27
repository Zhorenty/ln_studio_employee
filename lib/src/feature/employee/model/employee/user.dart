import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';

/// Represents a user model.
@immutable
final class UserModel {
  const UserModel({
    required this.id,
    this.photo,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
    required this.isSuperuser,
    required this.isActive,
  });

  /// UUID of the user.
  final int id;

  /// User's photo as [String].
  final String? photo;

  /// Password of the user.
  final String password;

  /// Email address of the user.
  final String email;

  /// First name of the user.
  final String firstName;

  /// Last name of the user.
  final String lastName;

  /// Phone number of the user.
  final String phone;

  /// Birth date of the user.
  final DateTime birthDate;

  /// Indicator whether user is a superuser.
  final bool isSuperuser;

  /// Indicator whether user is active.
  final bool isActive;

  ///
  String get fullName => '$firstName $lastName';

  /// Returns [UserModel] from [json].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      photo: json['photo'] as String?,
      password: json['password'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      isSuperuser: json['is_superuser'] as bool,
      isActive: json['is_active'] as bool,
    );
  }

  /// Converts [UserModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'photo': photo,
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'birth_date': birthDate.jsonFormat(),
        'is_superuser': isSuperuser,
        'is_active': isActive,
      };
}
