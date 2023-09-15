import '/src/feature/staff/model/employee.dart';
import 'staff_datasource.dart';

/// Repository for staff data.
abstract interface class StaffRepository {
  /// Get staff.
  Future<List<EmployeeModel>> getStaff();

  /// Fetch staff by salon id
  Future<List<EmployeeModel>> fetchSalonEmployees(int salonId);
}

/// Implementation of the staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<EmployeeModel>> getStaff() => _dataSource.fetchStaff();

  @override
  Future<List<EmployeeModel>> fetchSalonEmployees(int salonId) =>
      _dataSource.fetchSalonEmployees(salonId);
}
