import 'package:intl/intl.dart';
import 'package:rest_client/rest_client.dart';

/// Datasource for employee data.
abstract interface class EmployeeDatasource {
  /// Edit employee by [id].
  Future<void> editEmployee({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String email,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
  });
}

/// Implementation of employee datasource.
class EmployeeDatasourceImpl implements EmployeeDatasource {
  EmployeeDatasourceImpl({required this.restClient});

  /// REST client to call API.
  final RestClient restClient;

  @override
  Future<void> editEmployee({
    /// Employee information
    required int id,
    required String description,
    required String address,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,

    /// User information
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    restClient.put(
      '/api/employee/edit/$id',
      body: {
        'address': address,
        'job_place_id': 1,
        'salon_id': 1,
        'description': description,
        'date_of_employment': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'user': {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'birth_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        },
      },
    );
  }
}
