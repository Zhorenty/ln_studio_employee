// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ln_employee/src/feature/staff/model/job_place_preview.dart';

class EmployeePreview {
  EmployeePreview({
    this.photo,
    required this.firstName,
    required this.lastName,
    required this.stars,
    required this.jobPlaceName,
  });

  final String? photo;

  final String firstName;

  final String lastName;

  final int stars;

  final JobPlacePreview jobPlaceName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photo': photo,
      'firstName': firstName,
      'lastName': lastName,
      'stars': stars,
      'jobPlaceName': jobPlaceName,
    };
  }

  factory EmployeePreview.fromMap(Map<String, dynamic> map) {
    return EmployeePreview(
      photo: map['photo'] != null ? map['photo'] as String : null,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      stars: map['stars'] as int,
      jobPlaceName: JobPlacePreview.fromJson(map['job_place']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeePreview.fromJson(String source) =>
      EmployeePreview.fromMap(json.decode(source) as Map<String, dynamic>);
}
