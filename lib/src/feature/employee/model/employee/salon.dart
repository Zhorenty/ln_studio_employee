import 'package:flutter/foundation.dart';

/// Represents a salon with its properties.
@immutable
final class SalonModel {
  const SalonModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
  });

  /// The id of the salon.
  final int id;

  /// The address of the salon.
  final String address;

  /// The phone number of the salon.
  final String phone;

  /// The email of the salon.
  final String email;

  /// The description of the salon.
  final String description;

  /// Returns [SalonModel] from [json].
  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'] as int,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts [SalonModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'phone': phone,
        'email': email,
        'description': description,
      };
}
