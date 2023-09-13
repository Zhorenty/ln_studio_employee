import 'package:rest_client/rest_client.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/staff/model/employee.dart';

/// Datasource for employee data.
abstract interface class EmployeeDatasource {
  /// Fetch employee by id.
  Future<EmployeeModel> fetchEmployee({required int id});

  /// Edit employee by [id].
  Future<EmployeeModel> editEmployee({
    /// Employee information
    required int id,
    required String description,
    required String address,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
    required DateTime dateOfEmployment,

    /// User information
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime birthDate,
  });

  /// Dismiss employee by id.
  Future<void> dismissEmployee({required int id});

  /// Reinstatement employee by id.
  Future<void> reinstatementEmployee({required int id});
}

/// Implementation of employee datasource.
class EmployeeDatasourceImpl implements EmployeeDatasource {
  EmployeeDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<EmployeeModel> fetchEmployee({required int id}) async {
    final response = await restClient.get('/api/employee/$id');

    return EmployeeModel.fromJson(response);
  }

  /// TODO(zhorenty): Может быть можно поменять это все на EmployeeModel
  ///  и UserModel.
  @override
  Future<EmployeeModel> editEmployee({
    /// Employee information
    required int id,
    required String description,
    required String address,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
    required DateTime dateOfEmployment,

    /// User information
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required DateTime birthDate,
  }) async {
    final result = await restClient.put(
      '/api/employee/edit/$id',
      body: {
        'address': address,
        'job_place_id': 1,
        'salon_id': 1,
        'description': description,
        'date_of_employment': dateOfEmployment.format(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'user': {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'birth_date': birthDate.format(),
        },
      },
    );

    return EmployeeModel.fromJson(result);
  }

  @override
  Future<void> dismissEmployee({required int id}) async =>
      await restClient.delete('/api/employee/dismiss/$id');

  @override
  Future<void> reinstatementEmployee({required int id}) async =>
      await restClient.patch('/api/employee/return/$id');
}
