import '/src/feature/employee/data/employee_datasource.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Edit employee by [id].
  Future<void> editEmployee({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String contractNumber,
    required String email,
    required double percentageOfSales,
    required int stars,
  });
}

/// Implementation of the employee repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final EmployeeDatasource _dataSource;

  @override
  Future<void> editEmployee({
    required int id,
    required String firstName,
    required String email,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
  }) =>
      _dataSource.editEmployee(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
        description: description,
        contractNumber: contractNumber,
        percentageOfSales: percentageOfSales,
        stars: stars,
        email: email,
      );
}
