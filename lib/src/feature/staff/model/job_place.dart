import 'package:flutter/foundation.dart';

/// Representing a job place with its properties.
@immutable
final class JobPlaceModel {
  const JobPlaceModel({
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

  /// Returns [JobPlaceModel] from [json].
  factory JobPlaceModel.fromJson(Map<String, dynamic> json) {
    return JobPlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      oklad: json['oklad'] as int,
    );
  }

  /// Converts [JobPlaceModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'oklad': oklad,
      };
}
