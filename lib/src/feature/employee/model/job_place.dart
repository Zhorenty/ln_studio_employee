import 'package:flutter/foundation.dart';

/// TODO: Add documentation
@immutable
final class JobPlaceModel {
  const JobPlaceModel({
    required this.id,
    required this.name,
    required this.oklad,
  });

  /// Job place id.
  final int id;

  /// Job place name.
  final String name;

  /// Monthly salary.
  final int oklad;

  /// Returns [JobPlaceModel] from [json].
  factory JobPlaceModel.fromJson(Map<String, dynamic> json) {
    return JobPlaceModel(
      id: json['id'],
      name: json['name'],
      oklad: json['oklad'],
    );
  }

  /// Converts [JobPlaceModel] to json.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['oklad'] = oklad;
    return data;
  }
}
