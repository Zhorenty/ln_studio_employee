import 'package:flutter/foundation.dart';

@immutable
final class JobPlaceModel {
  const JobPlaceModel({
    required this.id,
    required this.name,
    required this.oklad,
  });

  final int id;

  final String name;

  final int oklad;

  factory JobPlaceModel.fromJson(Map<String, dynamic> json) {
    return JobPlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      oklad: json['oklad'] as int,
    );
  }
}
