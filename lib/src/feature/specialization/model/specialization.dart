import 'package:flutter/foundation.dart';

/// Representing a job place with its properties.
@immutable
final class Specialization {
  const Specialization({
    required this.id,
    required this.name,
    required this.oklad,
  });

  /// Id of the job place.
  final int id;

  /// Name of the job place.
  final String name;

  /// Salary of the job place.
  final int oklad;

  /// Returns [Specialization] from [json].
  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'] as int,
      name: json['name'] as String,
      oklad: json['oklad'] as int,
    );
  }

  /// Converts [Specialization] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'oklad': oklad,
      };
}
