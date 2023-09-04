import 'package:ln_employee/src/feature/timetable/data/timetable_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dependencies container.
abstract interface class Dependencies {
  /// Shared preferences
  abstract final SharedPreferences sharedPreferences;

  /// Wardrobe repository.
  abstract final TimetableRepository timetableRepository;

  /// Freeze dependencies, so they cannot be modified.
  Dependencies freeze();
}

/// Mutable version of dependencies.
///
/// Used to build dependencies.
final class Dependencies$Mutable implements Dependencies {
  Dependencies$Mutable();

  @override
  late TimetableRepository timetableRepository;

  @override
  late SharedPreferences sharedPreferences;

  @override
  Dependencies freeze() => _Dependencies$Immutable(
        sharedPreferences: sharedPreferences,
        timetableRepository: timetableRepository,
      );
}

/// Immutable version of dependencies.
///
/// Used to store dependencies.
final class _Dependencies$Immutable implements Dependencies {
  const _Dependencies$Immutable({
    required this.sharedPreferences,
    required this.timetableRepository,
  });

  @override
  final SharedPreferences sharedPreferences;

  @override
  final TimetableRepository timetableRepository;

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
