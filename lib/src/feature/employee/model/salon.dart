import 'package:flutter/foundation.dart';

@immutable
final class SalonModel {
  const SalonModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
  });

  final int id;

  final String address;

  final String phone;

  final String email;

  final String description;

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'] as int,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
    );
  }
}
