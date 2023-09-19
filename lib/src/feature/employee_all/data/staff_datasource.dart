import 'package:rest_client/rest_client.dart';

import '/src/feature/employee/model/employee/employee.dart';

/// Datasource for staff data.
abstract interface class StaffDatasource {
  /// Fetch staff.
  Future<List<Employee>> fetchStaff();

  /// Fetch staff by salon id
  Future<List<Employee>> fetchSalonEmployees(int salonId);
}

/// Implementation of Staff datasource.
class StaffDatasourceImpl implements StaffDatasource {
  StaffDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<Employee>> fetchStaff() async {
    final response = await restClient.get('/api/employee/all');

    final staff = List.from((response['data'] as List))
        .map((e) => Employee.fromJson(e))
        .toList();
    return staff;
  }

  @override
  Future<List<Employee>> fetchSalonEmployees(int salonId) async {
    final response = await restClient.get('/api/employee/by_salon_id/$salonId');

    final staff = List.from((response['data'] as List))
        .map((e) => Employee.fromJson(e))
        .toList();

    return staff;
  }
}
