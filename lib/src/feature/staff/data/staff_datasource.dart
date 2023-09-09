import '/src/feature/staff/model/employee.dart';
import 'package:rest_client/rest_client.dart';

/// Datasource for staff data.
abstract interface class StaffDatasource {
  /// Fetch staff.
  Future<List<EmployeeModel>> fetchStaff();
}

/// Implementation of Staff datasource.
class StaffDatasourceImpl implements StaffDatasource {
  StaffDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<EmployeeModel>> fetchStaff() async {
    final response = await restClient.get('/api/employee/all');

    final staff = List.from((response['data'] as List))
        .map((e) => EmployeeModel.fromJson(e))
        .toList();

    return staff;
  }
}
