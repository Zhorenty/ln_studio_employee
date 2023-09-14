import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/feature/employee/data/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

/// Employee bloc.
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.employeeRepository})
      : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchEmployee(event, emit),
        editEmployee: (event) => _editEmployee(event, emit),
        dismiss: (event) => _dismissEmployee(event, emit),
        reinstatement: (event) => _reinstatementEmployee(event, emit),
      ),
    );
  }

  /// Repository for employee data
  final EmployeeRepository employeeRepository;

  /// Edit employee from repository.
  Future<void> _fetchEmployee(
    EmployeeEvent$Fetch event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeState.processing(employee: state.employee));
    try {
      final employee = await employeeRepository.getEmployee(id: event.id);
      emit(EmployeeState.idle(employee: employee));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }

  /// Edit employee from repository.
  Future<void> _editEmployee(
    EmployeeEvent$EditEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final employee = await employeeRepository.editEmployee(
        /// Employee id
        id: event.id,

        /// Employee information
        description: event.description,
        address: event.address,
        contractNumber: event.contractNumber,
        percentageOfSales: event.percentageOfSales,
        stars: event.stars,
        dateOfEmployment: event.dateOfEmployment,

        /// User information
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        birthDate: event.birthDate,
      );
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
      await employeeRepository.dismissEmployee(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
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
      await employeeRepository.reinstatementmployee(id: event.id);
      add(EmployeeEvent.fetch(id: event.id));
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }
}