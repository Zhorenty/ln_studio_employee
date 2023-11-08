import 'package:dio/dio.dart';
import 'package:ln_employee/src/feature/auth/data/auth_repository.dart';
import 'package:ln_employee/src/feature/book_history/data/booking_history_repository.dart';
import 'package:ln_employee/src/feature/news/data/news_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../portfolio/data/portfolio_repository.dart';
import '/src/feature/employee/data/employee_repository.dart';
import '/src/feature/timetable/data/timetable_repository.dart';
import '/src/feature/salon/data/salon_repository.dart';
import '/src/feature/specialization/data/specialization_repository.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// [SharedPreferences] instanse.
  abstract final SharedPreferences sharedPreferences;

  /// [Dio] instance.
  abstract final Dio restClient;

  /// Auth repository.
  abstract final AuthRepository authRepository;

  /// Salon  repository.
  abstract final SalonRepository salonRepository;

  /// Timetable repository.
  abstract final TimetableRepository timetableRepository;

  /// Employee  repository.
  abstract final EmployeeRepository employeeRepository;

  ///
  abstract final NewsRepository profileRepository;

  /// Salon  repository.
  abstract final SpecializationRepository specializationRepository;

  ///
  abstract final BookingHistoryRepository bookingHistoryRepository;

  ///
  abstract final PortfolioRepository portfolioRepository;

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
  late Dio restClient;

  @override
  late AuthRepository authRepository;

  @override
  late SalonRepository salonRepository;

  @override
  late TimetableRepository timetableRepository;

  @override
  late EmployeeRepository employeeRepository;

  @override
  late NewsRepository profileRepository;

  @override
  late SpecializationRepository specializationRepository;

  @override
  late BookingHistoryRepository bookingHistoryRepository;

  @override
  late PortfolioRepository portfolioRepository;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        sharedPreferences: sharedPreferences,
        restClient: restClient,
        authRepository: authRepository,
        salonRepository: salonRepository,
        timetableRepository: timetableRepository,
        employeeRepository: employeeRepository,
        profileRepository: profileRepository,
        specializationRepository: specializationRepository,
        bookingHistoryRepository: bookingHistoryRepository,
        portfolioRepository: portfolioRepository,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.sharedPreferences,
    required this.restClient,
    required this.authRepository,
    required this.salonRepository,
    required this.timetableRepository,
    required this.employeeRepository,
    required this.profileRepository,
    required this.specializationRepository,
    required this.bookingHistoryRepository,
    required this.portfolioRepository,
  });

  @override
  final SharedPreferences sharedPreferences;

  @override
  final Dio restClient;

  @override
  final AuthRepository authRepository;

  @override
  final SalonRepository salonRepository;

  @override
  final TimetableRepository timetableRepository;

  @override
  final EmployeeRepository employeeRepository;

  @override
  final NewsRepository profileRepository;

  @override
  final SpecializationRepository specializationRepository;

  @override
  final BookingHistoryRepository bookingHistoryRepository;

  @override
  final PortfolioRepository portfolioRepository;

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
