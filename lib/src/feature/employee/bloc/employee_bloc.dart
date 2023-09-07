import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/common/utils/pattern_match.dart';
import 'package:ln_employee/src/feature/timetable/model/employee.dart';

import '../data/employee_repository.dart';
import '../model/employee.dart';

sealed class EmployeeState extends _$EmployeeStateBase {
  const EmployeeState._({
    required super.employee,
    super.error,
  });

  const factory EmployeeState.idle({
    EmployeeModel employee,
    String? error,
  }) = _EmployeeState$Idle;

  const factory EmployeeState.processing({
    EmployeeModel employee,
    String? error,
  }) = _EmployeeState$Processing;
}

final class _EmployeeState$Idle extends EmployeeState {
  const _EmployeeState$Idle({super.employee, super.error}) : super._();
}

final class _EmployeeState$Processing extends EmployeeState {
  const _EmployeeState$Processing({super.employee, super.error}) : super._();
}

@immutable
abstract base class _$EmployeeStateBase {
  const _$EmployeeStateBase({required this.employee, this.error});

  @nonVirtual
  final EmployeeModel? employee;

  @nonVirtual
  final String? error;

  bool get hasError => error != null;

  bool get isProcessing => maybeMap(
        processing: (_) => true,
        orElse: () => false,
      );

  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  R map<R>({
    required PatternMatch<R, _EmployeeState$Idle> idle,
    required PatternMatch<R, _EmployeeState$Processing> processing,
  }) =>
      switch (this) {
        final _EmployeeState$Idle idleState => idle(idleState),
        final _EmployeeState$Processing processingState =>
          processing(processingState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeState$Idle>? idle,
    PatternMatch<R, _EmployeeState$Processing>? processing,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  @override
  String toString() => 'EmployeeState(Employee: $employee, error: $error)';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => Object.hash(Employee, error);
}

sealed class EmployeeEvent extends _$EmployeeEventBase {
  const EmployeeEvent._();

  const factory EmployeeEvent.fetch(int id) = _EmployeeEvent$Fetch;
}

final class _EmployeeEvent$Fetch extends EmployeeEvent {
  const _EmployeeEvent$Fetch(this.id) : super._();

  /// Employeer id.
  final int id;
}

@immutable
abstract base class _$EmployeeEventBase {
  const _$EmployeeEventBase();

  R map<R>({
    required PatternMatch<R, _EmployeeEvent$Fetch> fetch,
  }) =>
      switch (this) {
        final _EmployeeEvent$Fetch fetchEvent => fetch(fetchEvent),
        _ => throw UnsupportedError('Unsupported event: $this'),
      };

  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _EmployeeEvent$Fetch>? fetch,
  }) =>
      map(
        fetch: fetch ?? (_) => orElse(),
      );

  @override
  String toString() => 'EmployeeEvent()';

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => 0;
}

final class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.employeeRepository})
      : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        fetch: (e) => _fetch(e, emit),
      ),
    );
  }

  final EmployeeRepository employeeRepository;

  Future<void> _fetch(
    _EmployeeEvent$Fetch event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeState.processing());
    try {
      final employee = await employeeRepository.getEmployee(event.id);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }
}
