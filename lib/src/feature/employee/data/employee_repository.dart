import '/src/feature/employee/data/employee_data_provider.dart';
import '/src/feature/employee/model/employee/employee.dart';
import '/src/feature/employee/model/employee_create/employee_create.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Get employee by id.
  Future<Employee> get({required int id});

  /// Fetch staff by salon id
  Future<List<Employee>> getAllBySalon(int salonId);

  /// Get staff.
  Future<List<Employee>> getAll();

  /// Create employee.
  Future<void> create({required Employee$Create employee});

  /// Edit employee by id.
  Future<Employee> edit({required Employee$Edit employee});

  /// Dismiss employee by id.
  Future<void> dismiss({required int id});

  /// Reinstatement employee by id.
  Future<void> reinstatement({required int id});
}

/// Implementation of the employee repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Employee data provider.
  final EmployeeDataProvider _dataSource;

  @override
  Future<Employee> get({required int id}) => _dataSource.fetchEmployee(id);

  @override
  Future<List<Employee>> getAllBySalon(int salonId) =>
      _dataSource.fetchSalonEmployees(salonId);

  @override
  Future<List<Employee>> getAll() => _dataSource.fetchAllEmployee();

  @override
  Future<void> create({required Employee$Create employee}) =>
      _dataSource.createEmployee(employee);

  @override
  Future<Employee> edit({required Employee$Edit employee}) =>
      _dataSource.editEmployee(employee);

  @override
  Future<void> dismiss({required int id}) => _dataSource.dismissEmployee(id);

  @override
  Future<void> reinstatement({required int id}) =>
      _dataSource.reinstatementEmployee(id);
}
