import 'package:ln_employee/src/feature/staff/model/employee.dart';

import '/src/feature/employee/data/employee_datasource.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Fetch employee by id.
  Future<EmployeeModel> getEmployee({required int id});

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
  Future<void> reinstatementmployee({required int id});
}

/// Implementation of the employee repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final EmployeeDatasource _dataSource;

  @override
  Future<EmployeeModel> getEmployee({required int id}) =>
      _dataSource.fetchEmployee(id: id);

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
  }) =>
      _dataSource.editEmployee(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        dateOfEmployment: dateOfEmployment,
        address: address,
        description: description,
        contractNumber: contractNumber,
        percentageOfSales: percentageOfSales,
        stars: stars,
        email: email,
        birthDate: birthDate,
      );

  @override
  Future<void> dismissEmployee({required int id}) =>
      _dataSource.dismissEmployee(id: id);

  @override
  Future<void> reinstatementmployee({required int id}) =>
      _dataSource.reinstatementEmployee(id: id);
}
