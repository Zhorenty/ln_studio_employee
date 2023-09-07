import '../model/employee.dart';
import '/src/feature/employee/data/employee_datasource.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Get employee.
  Future<EmployeeModel> getEmployee(int id);
}

/// Implementation of the employee repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Employee data source.
  final EmployeeDatasource _dataSource;

  @override
  Future<EmployeeModel> getEmployee(int id) => _dataSource.fetchEmployee(id);
}
