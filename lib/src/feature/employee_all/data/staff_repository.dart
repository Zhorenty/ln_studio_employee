import 'staff_datasource.dart';

import '/src/feature/employee/model/employee/employee.dart';

/// Repository for staff data.
abstract interface class StaffRepository {
  /// Get staff.
  Future<List<Employee>> getStaff();
}

/// Implementation of the staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<Employee>> getStaff() => _dataSource.fetchStaff();
}
