import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';
import 'package:ln_employee/src/feature/specialization/model/specialization.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import 'user.dart';

/// Represents an employee in a salon with its properties.
@immutable
final class Employee {
  const Employee({
    required this.id,
    this.workedDays,
    this.clients,
    required this.address,
    required this.jobId,
    required this.salonId,
    required this.description,
    required this.dateOfEmployment,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.isDismiss,
    required this.userModel,
    required this.jobModel,
    required this.salon,
    this.dismissDate,
  });

  /// UUID of employee.
  final int id;

  final int? workedDays;

  final int? clients;

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

  /// Indicates whether the employee is dismissed or not.
  final bool isDismiss;

  /// Date of dismissal (if applicable).
  final DateTime? dismissDate;

  /// User associated with the employee.
  final UserModel userModel;

  /// Job place associated with the employee's special skill.
  final Specialization jobModel;

  /// Salon associated with the employee.
  final Salon salon;

  /// Returns [Employee] from [json].
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      workedDays: json['worked_days'] as int?,
      clients: json['clients'] as int?,
      address: json['address'] as String,
      jobId: json['job_id'] as int,
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
      jobModel: Specialization.fromJson(
        json['job'] as Map<String, dynamic>,
      ),
      salon: Salon.fromJson(json['salon'] as Map<String, dynamic>),
    );
  }

  /// Converts [Employee] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'job_place_id': jobId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.jsonFormat(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'is_dismiss': isDismiss,
        'dismiss_date': dismissDate?.millisecondsSinceEpoch,
        'user': userModel.toJson(),
        'job_place': jobModel.toJson(),
        'salon': salon.toJson(),
      };
}
