import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'job_place.dart';
import 'salon.dart';
import 'user.dart';

/// Represents an employee in a salon with its properties.
@immutable
final class EmployeeModel {
  const EmployeeModel({
    required this.id,
    required this.address,
    required this.jobPlaceId,
    required this.salonId,
    required this.description,
    required this.dateOfEmployment,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.isDismiss,
    required this.userModel,
    required this.jobPlaceModel,
    required this.salonModel,
    this.dismissDate,
  });

  /// UUID of employee.
  final int id;

  /// Residential address of employee.
  final String address;

  /// Id of employee's special skill.
  final int jobPlaceId;

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

  /// Indicates whether the employee is dismissed or not.
  final bool isDismiss;

  /// Date of dismissal (if applicable).
  final DateTime? dismissDate;

  /// User associated with the employee.
  final UserModel userModel;

  /// Job place associated with the employee's special skill.
  final JobPlaceModel jobPlaceModel;

  /// Salon associated with the employee.
  final SalonModel salonModel;

  /// Returns [EmployeeModel] from [json].
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      address: json['address'] as String,
      jobPlaceId: json['job_place_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'] as double,
      stars: json['stars'] as int,
      isDismiss: json['is_dismiss'] as bool,
      dismissDate: json['dismiss_date'] != null
          ? DateTime.parse(json['dismiss_date'] as String)
          : null,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      jobPlaceModel: JobPlaceModel.fromJson(
        json['job_place'] as Map<String, dynamic>,
      ),
      salonModel: SalonModel.fromJson(json['salon'] as Map<String, dynamic>),
    );
  }

  /// Converts [EmployeeModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'job_place_id': jobPlaceId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.format(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'is_dismiss': isDismiss,
        'dismiss_date': dismissDate?.millisecondsSinceEpoch,
        'user': userModel.toJson(),
        'job_place': jobPlaceModel.toJson(),
        'salon': salonModel.toJson(),
      };
}
