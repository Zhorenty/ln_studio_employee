import 'package:rest_client/rest_client.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/employee/model/employee/employee.dart';
import '/src/feature/employee/model/employee_create/employee_create.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';

/// Datasource for employee data.
abstract interface class EmployeeDataProvider {
  /// Fetch employee by id.
  Future<Employee> fetch({required int id});

  /// Create new employee.
  Future<void> createEmployee({required Employee$Create employee});

  /// Edit employee.
  Future<Employee> editEmployee({required Employee$Edit employee});

  /// Dismiss employee by id.
  Future<void> dismissEmployee({required int id});

  /// Reinstatement employee by id.
  Future<void> reinstatementEmployee({required int id});
}

/// Implementation of employee datasource.
class EmployeeDataProviderImpl implements EmployeeDataProvider {
  EmployeeDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<Employee> fetch({required int id}) async {
    final response = await restClient.get('/api/employee/$id');
    return Employee.fromJson(response);
  }

  @override
  Future<void> createEmployee({required Employee$Create employee}) async =>
      await restClient.post(
        '/api/employee/create',
        body: {
          "address": employee.address,
          "job_id": 1,
          "salon_id": 1,
          "description": employee.description,
          "date_of_employment": employee.dateOfEmployment.format(),
          "contract_number": employee.contractNumber,
          "percentage_of_sales": employee.percentageOfSales,
          "stars": employee.stars,
          "user": {
            "phone": employee.userModel.phone,
            "first_name": employee.userModel.firstName,
            "last_name": employee.userModel.lastName,
            "email": employee.userModel.email,
            "birth_date": employee.userModel.birthDate.format(),
          }
        },
      );

  @override
  Future<Employee> editEmployee({required Employee$Edit employee}) async {
    final result = await restClient.put(
      '/api/employee/edit/${employee.id}',
      body: {
        'address': employee.address,
        'job_id': employee.salonId,
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
    return Employee.fromJson(result);
  }

  @override
  Future<void> dismissEmployee({required int id}) async =>
      await restClient.patch('/api/employee/dismiss/$id');

  @override
  Future<void> reinstatementEmployee({required int id}) async =>
      await restClient.patch('/api/employee/reinstatement/$id');
}
