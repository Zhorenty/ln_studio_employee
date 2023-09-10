import 'package:ln_employee/src/feature/employee/data/employee_datasource.dart';

/// Repository for timetables data.
abstract interface class EmployeeRepository {
  /// Fill time block items.
  Future<void> editEmployee({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String contractNumber,
    required String email,
    required double percentageOfSales,
    required int stars,
  });
}

/// Implementation of the timetable repository.
final class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._dataSource);

  /// Timetable data source.
  final EmployeeDatasource _dataSource;

  @override
  Future<void> editEmployee({
    required int id,
    required String firstName,
    required String email,
    required String lastName,
    required String phone,
    required String address,
    required String description,
    required String contractNumber,
    required double percentageOfSales,
    required int stars,
  }) =>
      _dataSource.editEmployee(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address,
        description: description,
        contractNumber: contractNumber,
        percentageOfSales: percentageOfSales,
        stars: stars,
        email: email,
      );
}
