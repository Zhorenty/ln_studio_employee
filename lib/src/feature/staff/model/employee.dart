// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'job_place.dart';
import 'salon.dart';
import 'user.dart';

class EmployeeModel {
  EmployeeModel({
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

  final int id;

  final String address;

  final int jobPlaceId;

  final int salonId;

  final String description;

  final DateTime dateOfEmployment;

  final String contractNumber;

  final double percentageOfSales;

  final int stars;

  final bool isDismiss;

  final DateTime? dismissDate;

  final UserModel userModel;

  final JobPlaceModel jobPlaceModel;

  final SalonModel salonModel;

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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'address': address,
        'job_place_id': jobPlaceId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.millisecondsSinceEpoch,
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
