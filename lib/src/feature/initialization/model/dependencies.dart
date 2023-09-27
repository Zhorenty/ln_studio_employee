import 'package:ln_employee/src/feature/specialization/data/specialization_repository.dart';

import '/src/feature/salon/data/salon_repository.dart';
import 'package:rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/src/feature/employee/data/employee_repository.dart';
import '/src/feature/timetable/data/timetable_repository.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// [SharedPreferences] instanse.
  abstract final SharedPreferences sharedPreferences;

  /// [RestClient] instance.
  abstract final RestClient restClient;

  /// Timetable repository.
  abstract final TimetableRepository timetableRepository;

  /// Employee  repository.
  abstract final EmployeeRepository employeeRepository;

  /// Salon  repository.
  abstract final SalonRepository salonRepository;

  /// Salon  repository.
  abstract final SpecializationRepository specializationRepository;

  /// Freeze dependencies, so they cannot be modified.
  Dependencies freeze();
}

/// Mutable version of dependencies.
///
/// Used to build dependencies.
final class Dependencies$Mutable implements Dependencies {
  Dependencies$Mutable();

  @override
  late SharedPreferences sharedPreferences;

  @override
  late RestClient restClient;

  @override
  late TimetableRepository timetableRepository;

  @override
  late EmployeeRepository employeeRepository;

  @override
  late SalonRepository salonRepository;

  @override
  late SpecializationRepository specializationRepository;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        sharedPreferences: sharedPreferences,
        restClient: restClient,
        timetableRepository: timetableRepository,
        employeeRepository: employeeRepository,
        salonRepository: salonRepository,
        specializationRepository: specializationRepository,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.sharedPreferences,
    required this.restClient,
    required this.timetableRepository,
    required this.employeeRepository,
    required this.salonRepository,
    required this.specializationRepository,
  });

  @override
  final SharedPreferences sharedPreferences;

  @override
  final RestClient restClient;

  @override
  final TimetableRepository timetableRepository;

  @override
  final EmployeeRepository employeeRepository;

  @override
  final SalonRepository salonRepository;

  @override
  final SpecializationRepository specializationRepository;

  @override
  Dependencies freeze() => this;
}

/// Handles initialization result.
final class InitializationResult {
  const InitializationResult({
    required this.dependencies,
    required this.stepCount,
    required this.msSpent,
  });

  /// Dependencies container.
  final Dependencies dependencies;

  /// Total number of steps.
  final int stepCount;

  /// Time spent on current step in milliseconds.
  final int msSpent;
}
