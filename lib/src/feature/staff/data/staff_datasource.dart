import 'package:ln_employee/src/feature/staff/model/employee_preview.dart';
import 'package:rest_client/rest_client.dart';

///
abstract interface class StaffDatasource {
  ///
  Future<List<EmployeePreview>> fetchStaff();
}

/// Implementation of Staff datasource.
class StaffDatasourceImpl implements StaffDatasource {
  StaffDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<List<EmployeePreview>> fetchStaff() async {
    final response = await restClient.get('/api/employee/all');

    final staff = List.from((response['data'] as List))
        .map((e) => EmployeePreview.fromJson(e))
        .toList();

    return staff;
  }
}
