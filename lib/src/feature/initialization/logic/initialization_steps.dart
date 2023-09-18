import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../edit_employee/data/employee_datasource.dart';
import '../../edit_employee/data/employee_repository.dart';
import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/staff/data/staff_datasource.dart';
import '/src/feature/staff/data/staff_repository.dart';
import '/src/feature/timetable/data/timetable_datasource.dart';
import '/src/feature/timetable/data/timetable_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Rest Client': (progress) async {
      final restClient = RestClient(
        Dio(BaseOptions(baseUrl: 'http://31.129.104.75')),
      );
      progress.dependencies.restClient = restClient;
    },
    'Timetable repository': (progress) async {
      final TimetableDatasource timetableDatasource = TimetableDatasourceImpl(
        restClient: progress.dependencies.restClient,
      );
      final timetableRepository = TimetableRepositoryImpl(timetableDatasource);
      progress.dependencies.timetableRepository = timetableRepository;
    },
    'Staff repository': (progress) async {
      final StaffDatasource staffDatasource = StaffDatasourceImpl(
        restClient: progress.dependencies.restClient,
      );
      final staffRepository = StaffRepositoryImpl(staffDatasource);
      progress.dependencies.staffRepository = staffRepository;
    },
    'Employee repository': (progress) async {
      final EmployeeDatasource employeeDatasource = EmployeeDatasourceImpl(
        restClient: progress.dependencies.restClient,
      );
      final employeeRepository = EmployeeRepositoryImpl(employeeDatasource);
      progress.dependencies.employeeRepository = employeeRepository;
    }
  };
}
