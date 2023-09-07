import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// TODO: Add documentation
@immutable
final class UserDetailModel {
  const UserDetailModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
    required this.isSuperuser,
    required this.isActive,
    this.photo,
  });

  /// User id.
  final int id;

  /// Optional user photo.
  final String? photo;

  /// User's username.
  final String username;

  /// User's password.
  final String password;

  /// User's email.
  final String email;

  /// User's first name.
  final String firstName;

  /// User's last name.
  final String lastName;

  /// User's phone number.
  final String phone;

  /// User's birth date.
  final DateTime birthDate;

  /// Indicator whether user is a super user.
  final bool isSuperuser;

  /// Indicator whether user account is active.
  final bool isActive;

  /// Returns [UserDetailModel] from [json].
  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'],
      photo: json['photo'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      birthDate: DateTime.parse(json['birth_date'] as String),
      isSuperuser: json['is_superuser'],
      isActive: json['is_active'],
    );
  }

  /// Converts [UserDetailModel] to json.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['birth_date'] = DateFormat('yyyy-MM-dd').format(birthDate);
    data['is_superuser'] = isSuperuser;
    data['is_active'] = isActive;
    return data;
  }
}
