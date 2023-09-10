import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_employee/src/feature/employee/data/employee_repository.dart';

import 'employee_event.dart';
import 'employee_state.dart';

/// Timetable bloc.
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.employeeRepository})
      : super(const EmployeeState.idle()) {
    on<EmployeeEvent>(
      (event, emit) => event.map(
        editEmployee: (event) => _editEmployee(event, emit),
      ),
    );
  }

  /// Repository for timetables data
  final EmployeeRepository employeeRepository;

  /// Fill timetable items from repository.
  Future<void> _editEmployee(
    EmployeeEvent$EditEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      await employeeRepository.editEmployee(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        address: event.address,
        description: event.description,
        contractNumber: event.contractNumber,
        percentageOfSales: event.percentageOfSales,
        stars: event.stars,
        email: event.email,
      );
    } on Object catch (e) {
      emit(EmployeeState.idle(error: e.toString()));
      rethrow;
    }
  }
}
