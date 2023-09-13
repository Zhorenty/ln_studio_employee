import 'dart:io';

import 'package:rest_client/rest_client.dart';

/// {@template create_employee_data_provider}
/// CreateEmployeeDataProvider class
/// {@endtemplate}
abstract interface class CreateEmployeeDataProvider {
  Future<void> createEmployee({
    File? avatar,
    required String firstName,
    required String lastName,
    required String phone,

    /// Аддресс проживания сотрудника
    String? address,
    required String description,
    required int specializationId,
    required int salonId,
    required int stars,
    required int percentageOfSales,
  });
}

final class CreateEmployeeDataProviderImpl
    implements CreateEmployeeDataProvider {
  const CreateEmployeeDataProviderImpl(RestClient restClient)
      : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<void> createEmployee({
    // TODO: Передавать в post
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
      _restClient.post(
        '/api/employee/create',
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'address': address,
          'description': description,
          'specializationId': specializationId,
          'salon_id': salonId,
          'stars': stars,
          'percentage_of_sales': percentageOfSales,
        },
      );
}
