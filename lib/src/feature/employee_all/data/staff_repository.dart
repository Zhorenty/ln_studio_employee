import 'staff_datasource.dart';

import '/src/feature/employee/model/employee/employee.dart';

/// Repository for staff data.
abstract interface class StaffRepository {
  /// Get staff.
  Future<List<Employee>> getStaff();

  /// Fetch staff by salon id
  Future<List<Employee>> fetchSalonEmployees(int salonId);
}

/// Implementation of the staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<Employee>> getStaff() => _dataSource.fetchStaff();

  @override
  Future<List<Employee>> fetchSalonEmployees(int salonId) =>
      _dataSource.fetchSalonEmployees(salonId);
}
