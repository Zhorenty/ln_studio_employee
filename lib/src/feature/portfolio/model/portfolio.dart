import 'package:flutter/foundation.dart';

@immutable
final class PortfolioModel {
  const PortfolioModel({
    required this.id,
    required this.employeeId,
    required this.photo,
  });

  final int id;
  final int employeeId;
  final String photo;

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        id: json['id'],
        employeeId: json['employee_id'],
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employee_id': employeeId,
        'photo': photo,
      };
}
