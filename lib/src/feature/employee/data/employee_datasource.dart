import 'package:rest_client/rest_client.dart';

import '../model/employee.dart';

///
abstract interface class EmployeeDatasource {
  ///
  Future<EmployeeModel> fetchEmployee(int id);
}

/// Implementation of Employee datasource.
class EmployeeDatasourceImpl implements EmployeeDatasource {
  EmployeeDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<EmployeeModel> fetchEmployee(int id) async {
    final response = await restClient.get('/api/employee/$id');

    final employee = response;

    final decoded = EmployeeModel.fromJson(employee);

    return decoded;
  }
}
