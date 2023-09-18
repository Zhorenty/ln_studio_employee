import 'package:ln_employee/src/feature/create_employee/model/employee_create.dart';
import 'package:ln_employee/src/feature/employee/data/employee_data_provider.dart';
import 'package:ln_employee/src/feature/employee/model/employee/employee.dart';

/// Repository for employee data.
abstract interface class EmployeeRepository {
  /// Fetch employee by id.
  Future<Employee> get({required int id});

  /// Create employee.
  Future<void> create({required Employee$Editable employee});

  /// Edit employee by id.
  Future<Employee> edit({required Employee$Editable employee});

  /// Dismiss employee by id.
  Future<void> dismiss({required int id});

  /// Reinstatement employee by id.
  Future<void> reinstatement({required int id});
}

/// Implementation of the employee repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final EmployeeDataProvider _dataSource;

  @override
  Future<Employee> get({required int id}) => _dataSource.fetch(id: id);

  @override
  Future<void> create({required Employee$Editable employee}) =>
      _dataSource.createEmployee(employee: employee);

  @override
  Future<Employee> edit({required Employee$Editable employee}) =>
      _dataSource.editEmployee(employee: employee);

  @override
  Future<void> dismiss({required int id}) =>
      _dataSource.dismissEmployee(id: id);

  @override
  Future<void> reinstatement({required int id}) =>
      _dataSource.reinstatementEmployee(id: id);
}
