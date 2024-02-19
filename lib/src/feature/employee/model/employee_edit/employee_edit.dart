import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'user_edit.dart';

/// Represents an employee in a salon with its create properties.
@immutable
final class Employee$Edit {
  const Employee$Edit({
    required this.id,
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

  /// UUID of the employee.
  final int id;

  /// Residential address of employee.
  final String address;

  /// Id of employee's special skill.
  final int jobId;

  /// Id of employee's salon.
  final int salonId;

  /// Description of employee.
  final String description;

  /// Date of employment.
  final DateTime? dateOfEmployment;

  /// Contract number of employee.
  final String contractNumber;

  /// Percentage of sales earned by the employee.
  final double? percentageOfSales;

  /// Number of stars received by the employee.
  final int stars;

  /// Indicator whether employee is dismissed.
  final bool isDismiss;

  /// User associated with the employee.
  final UserModel$Edit userModel;

  /// Returns [Employee$Edit] from [json].
  factory Employee$Edit.fromJson(Map<String, dynamic> json) {
    return Employee$Edit(
      id: json['id'] as int,
      address: json['address'] as String,
      jobId: json['job_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'],
      stars: json['stars'] as int,
      isDismiss: json['is_dismiss'] as bool,
      userModel: UserModel$Edit.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// Converts [Employee$Edit] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'job_place_id': jobId,
        'salon_id': salonId,
        'description': description,
        if (dateOfEmployment != null)
          'date_of_employment': dateOfEmployment?.jsonFormat(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'is_dismiss': isDismiss,
        'user': userModel.toJson(),
      };

  Employee$Edit copyWith({
    int? id,
    bool? isDismiss,
    String? address,
    int? jobId,
    int? salonId,
    String? description,
    DateTime? dateOfEmployment,
    String? contractNumber,
    double? percentageOfSales,
    int? stars,
    UserModel$Edit? userModel,
  }) {
    return Employee$Edit(
      id: id ?? this.id,
      isDismiss: isDismiss ?? this.isDismiss,
      address: address ?? this.address,
      jobId: jobId ?? this.jobId,
      salonId: salonId ?? this.salonId,
      description: description ?? this.description,
      dateOfEmployment: dateOfEmployment ?? this.dateOfEmployment,
      contractNumber: contractNumber ?? this.contractNumber,
      percentageOfSales: percentageOfSales ?? this.percentageOfSales,
      stars: stars ?? this.stars,
      userModel: userModel ?? this.userModel,
    );
  }
}
