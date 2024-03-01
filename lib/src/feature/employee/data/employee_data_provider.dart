import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/book_history/model/booking.dart';
import 'package:ln_employee/src/feature/employee/model/review.dart';

import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/employee/model/employee/employee.dart';
import '/src/feature/employee/model/employee_create/employee_create.dart';
import '/src/feature/employee/model/employee_edit/employee_edit.dart';

/// Datasource for employee data.
abstract interface class EmployeeDataProvider {
  /// Fetch employee by id.
  Future<Employee> fetchEmployee(int id);

  /// Fetch staff by salon id
  Future<List<Employee>> fetchSalonEmployees(int salonId);

  /// Fetch all employees.
  Future<List<Employee>> fetchAllEmployee();

  /// Create new employee.
  Future<void> createEmployee(Employee$Create employee);

  /// Edit employee.
  Future<Employee> editEmployee(Employee$Edit employee);

  Future<void> uploadAvatar(int id, File avatar);

  /// Dismiss employee by id.
  Future<void> dismissEmployee(int id);

  /// Reinstatement employee by id.
  Future<void> reinstatementEmployee(int id);

  /// Fetch reviews
  Future<List<Review>> fetchReviews(int employeeId);
}

/// Implementation of employee datasource.
class EmployeeDataProviderImpl implements EmployeeDataProvider {
  EmployeeDataProviderImpl({required this.restClient});

  /// REST client to call API.
  final Dio restClient;

  @override
  Future<Employee> fetchEmployee(int id) async {
    final response = await restClient.get('/api/v1/employee/$id');
    return Employee.fromJson(response.data['data']);
  }

  @override
  Future<List<Employee>> fetchAllEmployee() async {
    final response = await restClient.get('/api/v1/employee');

    final staff = List.from((response.data['data']))
        .map((e) => Employee.fromJson(e))
        .toList();
    return staff;
  }

  @override
  Future<List<Employee>> fetchSalonEmployees(int salonId) async {
    final response = await restClient.get('/api/v1/salon/$salonId/employees');

    final staff = List.from((response.data['data']))
        .map((e) => Employee.fromJson(e))
        .toList();

    return staff;
  }

  @override
  Future<void> createEmployee(Employee$Create employee) async =>
      await restClient.post(
        '/api/v1/employee/create',
        data: {
          "address": employee.address,
          "job_id": employee.jobId,
          "salon_id": employee.salonId,
          "description": employee.description,
          "date_of_employment": employee.dateOfEmployment.jsonFormat(),
          "contract_number": employee.contractNumber,
          "percentage_of_sales": employee.percentageOfSales,
          "stars": employee.stars,
          "user": {
            "phone": employee.userModel.phone,
            "first_name": employee.userModel.firstName,
            "last_name": employee.userModel.lastName,
            "email": employee.userModel.email,
            "birth_date": employee.userModel.birthDate.jsonFormat(),
          }
        },
      );

  @override
  Future<Employee> editEmployee(Employee$Edit employee) async {
    final result = await restClient.put(
      '/api/v1/employee/${employee.id}/edit',
      data: {
        'address': employee.address,
        'job_id': employee.jobId,
        'salon_id': employee.salonId,
        'description': employee.description,
        'date_of_employment':
            // TODO: Попрвить
            (employee.dateOfEmployment ?? DateTime.now()).jsonFormat(),
        'contract_number': employee.contractNumber,
        // TODO: Попрвить
        'percentage_of_sales': employee.percentageOfSales ?? 0,
        'stars': employee.stars,
        'user': {
          'email': employee.userModel.email,
          'first_name': employee.userModel.firstName,
          'last_name': employee.userModel.lastName,
          'phone': employee.userModel.phone,
          'birth_date': employee.userModel.birthDate.jsonFormat(),
        },
      },
    );
    return Employee.fromJson(result.data['data']);
  }

  @override
  Future<void> uploadAvatar(int id, File avatar) async {
    String fileName = avatar.path.split('/').last;

    FormData formData = FormData.fromMap(
      {
        'avatar': await MultipartFile.fromFile(avatar.path, filename: fileName),
      },
    );

    await restClient.patch('/api/v1/employee/$id/avatar', data: formData);
  }

  @override
  Future<void> dismissEmployee(int id) async =>
      await restClient.patch('/api/v1/employee/$id/dismiss');

  @override
  Future<void> reinstatementEmployee(int id) async =>
      await restClient.patch('/api/v1/employee/$id/reinstatement');

  @override
  Future<List<Review>> fetchReviews(int employeeId) async {
    final response =
        await restClient.get('/api/v1/employee/$employeeId/service_sales');

    final employeeBookings = List.from((response.data['data'] as List))
        .map((e) => BookingModel.fromJson(e))
        .toList();
    // TODO: Отрефачить
    final employeeBookingsWithReviews =
        employeeBookings.where((booking) => booking.isHasReview).toList();
    final reviews = employeeBookingsWithReviews.map((e) => e.review!).toList();

    return reviews;
  }
}
