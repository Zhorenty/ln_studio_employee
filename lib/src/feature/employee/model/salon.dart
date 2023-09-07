import 'package:flutter/foundation.dart';

/// TODO: Add documentation
@immutable
final class SalonModel {
  const SalonModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
  });

  /// Salon id.
  final int id;

  /// Salon address.
  final String address;

  /// Salon phone number.
  final String phone;

  /// Salon email.
  final String email;

  /// Salon description.
  final String description;

  /// Returns [SalonModel] from [json].
  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      description: json['description'],
    );
  }

  /// Converts [SalonModel] to json.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['description'] = description;
    return data;
  }
}
