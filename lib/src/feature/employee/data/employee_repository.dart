import 'package:ln_employee/src/feature/staff/model/employee.dart';

import '/src/feature/employee/data/employee_datasource.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Fetch employee by id.
  Future<EmployeeModel> getEmployee({required int id});

  /// Create employee.
  Future<void> createEmployee({required EmployeeModel employee});

  /// Edit employee by id.
  Future<EmployeeModel> editEmployee({required EmployeeModel employee});

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
  Future<void> createEmployee({required EmployeeModel employee}) =>
      _dataSource.createEmployee(employee: employee);

  @override
  Future<EmployeeModel> editEmployee({required EmployeeModel employee}) =>
      _dataSource.editEmployee(employee: employee);

  @override
  Future<void> dismissEmployee({required int id}) =>
      _dataSource.dismissEmployee(id: id);

  @override
  Future<void> reinstatementmployee({required int id}) =>
      _dataSource.reinstatementEmployee(id: id);
}
