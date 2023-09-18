import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/employee/data/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

/// Employee bloc.
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.repository}) : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchEmployee(event, emit),
        create: (event) => _create(event, emit),
        edit: (event) => _editEmployee(event, emit),
        dismiss: (event) => _dismissEmployee(event, emit),
        reinstatement: (event) => _reinstatementEmployee(event, emit),
      ),
    );
  }

  /// Repository for employee data
  final EmployeeRepository repository;

  /// Edit employee from repository.
  Future<void> _fetchEmployee(
    EmployeeEvent$Fetch event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      final employee = await repository.getEmployee(id: event.id);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Fetch event handler
  Future<void> _create(
    EmployeeEvent$Create event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeState.processing());
      await repository.createEmployee(employee: event.employee);
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Edit employee from repository.
  Future<void> _editEmployee(
    EmployeeEvent$Edit event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final employee = await repository.editEmployee(employee: event.employee);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Dismiss employee from repository.
  Future<void> _dismissEmployee(
    EmployeeEvent$Dismiss event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      await repository.dismissEmployee(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Reinstatement employee from repository.
  Future<void> _reinstatementEmployee(
    EmployeeEvent$Reinstatement event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      await repository.reinstatementmployee(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }
}
