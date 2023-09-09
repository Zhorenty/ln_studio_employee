// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

@immutable
final class UserModel {
  const UserModel({
    required this.id,
    this.photo,
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
    required this.isSuperuser,
    required this.isActive,
  });

  final int id;

  final String? photo;

  final String username;

  final String password;

  final String email;

  final String firstName;

  final String lastName;

  final String phone;

  final DateTime birthDate;

  final bool isSuperuser;

  final bool isActive;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      photo: json['photo'] as String?,
      username: json['username'] as String,
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'photo': photo,
        'username': username,
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'birth_date': birthDate.millisecondsSinceEpoch,
        'is_superuser': isSuperuser,
        'is_active': isActive,
      };
}
