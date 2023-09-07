import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'job_place.dart';
import 'salon.dart';
import 'user.dart';

/// TODO: Add documentation and translate.
@immutable
final class EmployeeModel {
  const EmployeeModel({
    required this.id,
    required this.address,
    required this.jobPlaceId,
    required this.salonId,
    required this.description,
    required this.isDismiss,
    required this.dateOfEmployment,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.salon,
    required this.user,
    required this.jobPlace,
    this.dismissDate,
  });

  /// Уникальный идентификатор сотрудника
  final int id;

  /// Адрес проживания сотрудника
  final String address;

  /// Должность сотрудника
  final int jobPlaceId;

  /// Идентификатор салона
  final int salonId;

  /// Краткое описание сотрудника
  final String description;

  /// Индикатор того, уволен сотрудник или нет
  final bool isDismiss;

  /// Дата увольнения на работу
  final DateTime? dismissDate;

  /// Дата приема на работу
  final DateTime dateOfEmployment;

  /// Номер трудового договора
  final String contractNumber;

  /// Процент от продаж
  final int percentageOfSales;

  /// Рейтинг сотрудника
  final int stars;

  /// Салон, в котором работает сотрудник
  final SalonModel salon;

  /// Сотрудник как юзер
  final UserDetailModel user;

  /// Место работы сотрудника
  final JobPlaceModel jobPlace;

  /// Returns [EmployeeModel] from [json].
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      address: json['address'] as String,
      jobPlaceId: json['job_place_id'] as int,
      salonId: json['salon_id'],
      description: json['description'],
      isDismiss: json['is_dismiss'],
      dismissDate: DateTime.parse(json['dismiss_date'] as String),
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'],
      percentageOfSales: json['percentage_of_sales'],
      stars: json['stars'],
      salon: SalonModel.fromJson(json['salon']),
      user: UserDetailModel.fromJson(json['user']),
      jobPlace: JobPlaceModel.fromJson(json['job_place']),
    );
  }

  /// Convert [EmployeeModel] to json.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['job_place_id'] = jobPlaceId;
    data['salon_id'] = salonId;
    data['description'] = description;
    data['is_dismiss'] = isDismiss;
    data['dismiss_date'] = DateFormat('yyyy-MM-dd').format(dismissDate!);
    data['date_of_employment'] = DateFormat('yyyy-MM-dd').format(
      dateOfEmployment,
    );
    data['contract_number'] = contractNumber;
    data['percentage_of_sales'] = percentageOfSales;
    data['stars'] = stars;
    data['salon'] = salon.toJson();
    data['user'] = user.toJson();
    data['job_place'] = jobPlace.toJson();
    return data;
  }
}
