import 'package:flutter/foundation.dart';
import 'package:ln_employee/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_employee/src/feature/employee/model/employee/employee.dart';
import 'package:ln_employee/src/feature/salon/models/salon.dart';

import '../../employee/model/employee/user.dart';
import 'service.dart';
import 'timeblock.dart';

@immutable
final class BookingModel {
  const BookingModel({
    required this.id,
    required this.dateAt,
    required this.price,
    required this.salon,
    required this.employee,
    required this.service,
    required this.timeblock,
    required this.client,
    this.comment,
  });

  ///
  final int id;

  ///
  final DateTime dateAt;

  ///
  final int price;

  ///
  final String? comment;

  ///
  final Salon salon;

  ///
  final Employee employee;

  ///
  final ServiceModel service;

  ///
  final EmployeeTimeblock$Response timeblock;

  final ClientModel client;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'],
        dateAt: DateTime.parse(json['date_at']),
        price: json['price'],
        comment: json['comment'],
        salon: Salon.fromJson(json['salon']),
        employee: Employee.fromJson(json['employee']),
        service: ServiceModel.fromJson(json['service']),
        timeblock: EmployeeTimeblock$Response.fromJson(json['timeblock']),
        client: ClientModel.fromJson(json['client']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_at': dateAt.jsonFormat(),
        'price': price,
        'comment': comment,
        'salon': salon.toJson(),
        'employee': employee.toJson(),
        'service': service.toJson(),
        'timeblock': timeblock.toJson(),
      };
}

@immutable
final class ClientModel {
  const ClientModel({
    required this.id,
    required this.userId,
    required this.contractNumber,
    required this.user,
  });

  final int id;
  final int userId;
  final String contractNumber;
  final UserModel user;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['id'],
        userId: json['user_id'],
        contractNumber: json['contract_number'],
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'contract_number': contractNumber,
        'user': user.toJson(),
      };
}
