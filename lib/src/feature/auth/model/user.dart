import 'package:flutter/foundation.dart';

typedef TokenPair = ({
  String accessToken,
  String refreshToken,
});

@immutable
final class User {
  const User({
    this.id,
    this.photo,
    this.phone,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.email,
    this.isSuperuser,
  });

  final int? id;

  final String? phone;

  final String? photo;

  final String? firstName;

  final String? lastName;

  final DateTime? birthDate;

  final String? email;

  /// Indicator whether user is a superuser.
  final bool? isSuperuser;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && phone == other.phone;

  @override
  int get hashCode => phone.hashCode;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      photo: json['photo'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: DateTime.parse(json['birth_date']),
      email: json['email'],
      isSuperuser: json['is_superuser'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phone,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'email': email,
      'is_superuser': isSuperuser,
    };
  }
}
