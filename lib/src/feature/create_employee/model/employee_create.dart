import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'user_create.dart';

@immutable
final class Employee$Editable {
  const Employee$Editable({
    this.id,
    this.isDismiss,
    required this.address,
    required this.jobId,
    required this.salonId,
    required this.description,
    required this.dateOfEmployment,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.userModel,
  });

  final int? id;

  /// Residential address of employee.
  final String address;

  /// Id of employee's special skill.
  final int jobId;

  /// Id of employee's salon.
  final int salonId;

  /// Description of employee.
  final String description;

  /// Date of employment.
  final DateTime dateOfEmployment;

  /// Contract number of employee.
  final String contractNumber;

  /// Percentage of sales earned by the employee.
  final double percentageOfSales;

  /// Number of stars received by the employee.
  final int stars;

  final bool? isDismiss;

  /// User associated with the employee.
  final UserModel$Editable userModel;

  /// Returns [Employee$Editable] from [json].
  factory Employee$Editable.fromJson(Map<String, dynamic> json) {
    return Employee$Editable(
      id: json['id'] as int,
      address: json['address'] as String,
      jobId: json['job_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'] as double,
      stars: json['stars'] as int,
      isDismiss: json['is_dismiss'] as bool,
      userModel:
          UserModel$Editable.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// Converts [Employee] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'job_place_id': jobId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.format(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'is_dismiss': isDismiss,
        'user': userModel.toJson(),
      };
}
