import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'user_create.dart';

/// Represents an employee in a salon with its create properties.
@immutable
final class Employee$Create {
  const Employee$Create({
    required this.isDismiss,
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

  /// Indicator whether employee is dismissed.
  final bool isDismiss;

  /// User associated with the employee.
  final UserModel$Create userModel;

  /// Returns [Employee$Create] from [json].
  factory Employee$Create.fromJson(Map<String, dynamic> json) {
    return Employee$Create(
      address: json['address'] as String,
      jobId: json['job_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'] as double,
      stars: json['stars'] as int,
      isDismiss: json['is_dismiss'] as bool,
      userModel: UserModel$Create.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
    );
  }

  /// Converts [Employee$Create] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
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
