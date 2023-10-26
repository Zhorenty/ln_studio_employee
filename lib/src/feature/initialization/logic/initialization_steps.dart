import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/auth/data/auth_data_provider.dart';
import 'package:ln_employee/src/feature/auth/data/auth_repository.dart';
import 'package:ln_employee/src/feature/auth/logic/oauth_interceptor.dart';
import 'package:ln_employee/src/feature/profile/data/profile_data_provider.dart';
import 'package:ln_employee/src/feature/profile/data/profile_repository.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/employee/data/employee_data_provider.dart';
import '/src/feature/employee/data/employee_repository.dart';
import '/src/feature/initialization/model/initialization_progress.dart';
import '/src/feature/timetable/data/timetable_datasource.dart';
import '/src/feature/timetable/data/timetable_repository.dart';
import '/src/feature/salon/data/salon_data_provider.dart';
import '/src/feature/salon/data/salon_repository.dart';
import '/src/feature/specialization/data/specialization_data_provider.dart';
import '/src/feature/specialization/data/specialization_repository.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

const kBaseUrl = 'http://31.129.104.75';

/// Handles initialization steps.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Auth Repository & Rest Client': (progress) async {
      final authDataProvider = AuthDataProviderImpl(
        baseUrl: kBaseUrl,
        sharedPreferences: progress.dependencies.sharedPreferences,
      );
      final restClient = RestClient(
        Dio(BaseOptions(baseUrl: kBaseUrl))
          ..interceptors.add(
            OAuthInterceptor(
              refresh: authDataProvider.refreshTokenPair,
              loadTokens: authDataProvider.getTokenPair,
              clearTokens: authDataProvider.signOut,
            ),
          ),
      );
      progress.dependencies.restClient = restClient;
      final authRepository = AuthRepositoryImpl(
        authDataProvider: authDataProvider,
      );
      progress.dependencies.authRepository = authRepository;
    },
    'Salon repository': (progress) async {
      final salonDataProvider = SalonDataProviderImpl(
        restClient: progress.dependencies.restClient,
        prefs: progress.dependencies.sharedPreferences,
      );
      final salonRepository = SalonRepositoryImpl(salonDataProvider);
      progress.dependencies.salonRepository = salonRepository;
    },
    'Timetable repository': (progress) async {
      final timetableDatasource = TimetableDatasourceImpl(
        restClient: progress.dependencies.restClient,
      );
      final timetableRepository = TimetableRepositoryImpl(timetableDatasource);
      progress.dependencies.timetableRepository = timetableRepository;
    },
    'Employee repository': (progress) async {
      final employeeDatasource = EmployeeDataProviderImpl(
        restClient: progress.dependencies.restClient,
      );
      final employeeRepository = EmployeeRepositoryImpl(employeeDatasource);
      progress.dependencies.employeeRepository = employeeRepository;
    },
    'Profile repository': (progress) async {
      final profileDataProvider = ProfileDataProviderImpl(
        restClient: progress.dependencies.restClient,
      );
      final profileRepository = ProfileRepositoryImpl(profileDataProvider);
      progress.dependencies.profileRepository = profileRepository;
    },
    'Specialization repository': (progress) async {
      final specializationDataProvider = SpecializationDataProviderImpl(
        restClient: progress.dependencies.restClient,
      );
      final specializationRepository = SpecializationRepositoryImpl(
        specializationDataProvider,
      );
      progress.dependencies.specializationRepository = specializationRepository;
    },
  };
}
