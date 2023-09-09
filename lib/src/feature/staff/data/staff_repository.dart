import '/src/feature/staff/model/employee.dart';
import 'staff_datasource.dart';

/// Repository for staff data.
abstract interface class StaffRepository {
  /// Get staff.
  Future<List<EmployeeModel>> getStaff();
}

/// Implementation of the staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<EmployeeModel>> getStaff() => _dataSource.fetchStaff();
}
