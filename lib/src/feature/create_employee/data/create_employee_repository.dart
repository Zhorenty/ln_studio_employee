import 'dart:io';

import 'package:ln_employee/src/feature/create_employee/data/create_employee_data_provider.dart';

abstract interface class CreateEmployeeRepository {
  Future<void> createEmployee({
    File? avatar,
    required String firstName,
    required String lastName,
    required String phone,
    String? address,
    required String description,
    required int specializationId,
    required int salonId,
    required int stars,
    required int percentageOfSales,
  });
}

/// {@template create_employee_repository}
/// CreateEmployeeRepository class
/// {@endtemplate}
final class CreateEmployeeRepositoryImpl implements CreateEmployeeRepository {
  /// {@macro create_employee_repository}
  const CreateEmployeeRepositoryImpl(CreateEmployeeDataProvider dataProvider)
      : _dataProvider = dataProvider;

  final CreateEmployeeDataProvider _dataProvider;

  @override
  Future<void> createEmployee({
    File? avatar,
    required String firstName,
    required String lastName,
    required String phone,
    String? address,
    required String description,
    required int specializationId,
    required int salonId,
    required int stars,
    required int percentageOfSales,
  }) =>
      _dataProvider.createEmployee(
        avatar: avatar,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
        description: description,
        specializationId: specializationId,
        salonId: salonId,
        stars: stars,
        percentageOfSales: percentageOfSales,
      );
}
