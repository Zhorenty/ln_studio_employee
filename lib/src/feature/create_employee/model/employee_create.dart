import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'user_create.dart';

@immutable
final class EmployeeModel$Create {
  const EmployeeModel$Create({
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

  /// User associated with the employee.
  final UserModel$Create userModel;

  /// Returns [EmployeeModel] from [json].
  factory EmployeeModel$Create.fromJson(Map<String, dynamic> json) {
    return EmployeeModel$Create(
      address: json['address'] as String,
      jobId: json['job_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'] as double,
      stars: json['stars'] as int,
      userModel:
          UserModel$Create.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// Converts [EmployeeModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'job_place_id': jobId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.format(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'user': userModel.toJson(),
      };
}
