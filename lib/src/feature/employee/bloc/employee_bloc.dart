import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/employee/data/employee_repository.dart';
import '/src/feature/employee/bloc/employee_event.dart';
import '/src/feature/employee/bloc/employee_state.dart';

/// Employee bloc.
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.repository}) : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetch(event, emit),
        create: (event) => _create(event, emit),
        edit: (event) => _edit(event, emit),
        dismiss: (event) => _dismiss(event, emit),
        reinstatement: (event) => _reinstatement(event, emit),
      ),
    );
  }

  /// Repository for employee data
  final EmployeeRepository repository;

  /// Fetch employee from repository.
  Future<void> _fetch(
    EmployeeEvent$Fetch event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      final employee = await repository.get(id: event.id);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Create employee from repository.
  Future<void> _create(
    EmployeeEvent$Create event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeState.processing());
      await repository.create(employee: event.employee);
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Edit employee from repository.
  Future<void> _edit(
    EmployeeEvent$Edit event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final employee = await repository.edit(employee: event.employee);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Dismiss employee from repository.
  Future<void> _dismiss(
    EmployeeEvent$Dismiss event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      await repository.dismiss(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Reinstatement employee from repository.
  Future<void> _reinstatement(
    EmployeeEvent$Reinstatement event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      await repository.reinstatement(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
      emit(EmployeeState.successful(employee: state.employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }
}
