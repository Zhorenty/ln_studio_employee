import '/src/feature/staff/model/employee.dart';
import 'staff_datasource.dart';

/// Repository for Staffs data.
abstract interface class StaffRepository {
  /// Get Staffs.
  Future<List<EmployeeModel>> getStaff();
}

/// Implementation of the Staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<EmployeeModel>> getStaff() => _dataSource.fetchStaff();
}
