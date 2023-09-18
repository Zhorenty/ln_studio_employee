import 'package:flutter/foundation.dart';

/// Representing a job place with its properties.
@immutable
final class JobModel {
  const JobModel({
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

  /// Returns [JobModel] from [json].
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int,
      name: json['name'] as String,
      oklad: json['oklad'] as int,
    );
  }

  /// Converts [JobModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'oklad': oklad,
      };
}
