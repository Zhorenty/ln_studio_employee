import 'package:ln_employee/src/feature/staff/model/employee_preview.dart';

import 'staff_datasource.dart';

/// Repository for Staffs data.
abstract interface class StaffRepository {
  /// Get Staffs.
  Future<List<EmployeePreview>> getStaff();
}

/// Implementation of the Staff repository.
final class StaffRepositoryImpl implements StaffRepository {
  StaffRepositoryImpl(this._dataSource);

  /// Staff data source.
  final StaffDatasource _dataSource;

  @override
  Future<List<EmployeePreview>> getStaff() => _dataSource.fetchStaff();
}
