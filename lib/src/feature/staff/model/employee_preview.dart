// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ln_employee/src/feature/staff/model/job_place_preview.dart';
import 'package:ln_employee/src/feature/staff/model/user_preview.dart';

class EmployeePreview {
  EmployeePreview({
    required this.stars,
    required this.userPreview,
    required this.jobPlaceName,
  });

  final int stars;

  final UserPreview userPreview;

  final JobPlacePreview jobPlaceName;

  factory EmployeePreview.fromJson(Map<String, dynamic> json) {
    return EmployeePreview(
      stars: json['stars'] as int,
      userPreview: UserPreview.fromJson(json['user']),
      jobPlaceName: JobPlacePreview.fromJson(json['job_place']),
    );
  }
}
