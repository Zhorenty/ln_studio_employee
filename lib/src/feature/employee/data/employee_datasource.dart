import 'package:rest_client/rest_client.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/staff/model/employee.dart';

/// Datasource for employee data.
abstract interface class EmployeeDatasource {
  /// Fetch employee by id.
  Future<EmployeeModel> fetchEmployee({required int id});

  ///
  Future<void> createEmployee({required EmployeeModel employee});

  /// Edit employee by [id].
  Future<EmployeeModel> editEmployee({required EmployeeModel employee});

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

  @override
  Future<void> createEmployee({required EmployeeModel employee}) async =>
      await restClient.post(
        '/api/employee/create',
        body: {
          'first_name': employee.userModel.firstName,
          'last_name': employee.userModel.lastName,
          'phone': employee.userModel.phone,
          'address': employee.address,
          'description': employee.description,
          'specializationId': employee.jobPlaceId,
          'salon_id': employee.salonId,
          'stars': employee.stars,
          'percentage_of_sales': employee.percentageOfSales,
        },
      );

  @override
  Future<EmployeeModel> editEmployee({required EmployeeModel employee}) async {
    final result = await restClient.put(
      '/api/employee/edit/${employee.id}',
      body: {
        'address': employee.address,
        'job_place_id': employee.salonId,
        'salon_id': employee.salonId,
        'description': employee.description,
        'date_of_employment': employee.dateOfEmployment.format(),
        'contract_number': employee.contractNumber,
        'percentage_of_sales': employee.percentageOfSales,
        'stars': employee.stars,
        'user': {
          'email': employee.userModel.email,
          'first_name': employee.userModel.firstName,
          'last_name': employee.userModel.lastName,
          'phone': employee.userModel.phone,
          'birth_date': employee.userModel.birthDate.format(),
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
