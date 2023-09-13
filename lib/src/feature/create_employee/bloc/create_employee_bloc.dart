import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ln_employee/src/feature/create_employee/bloc/create_employee_event.dart';
import 'package:ln_employee/src/feature/create_employee/bloc/create_employee_state.dart';
import 'package:ln_employee/src/feature/create_employee/data/create_employee_repository.dart';

// part 'create_employee_event.dart';
// part 'create_employee_state.dart';

/// Business Logic Component CreateEmployeeBLoC
class CreateEmployeeBLoC extends Bloc<CreateEmployeeEvent, CreateEmployeeState>
    implements EventSink<CreateEmployeeEvent> {
  CreateEmployeeBLoC({
    required final CreateEmployeeRepository repository,
    final CreateEmployeeState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const CreateEmployeeState.idle(message: 'Initial idle state'),
        ) {
    on<CreateEmployeeEvent>(
      (event, emit) => switch (event) {
        CreateEmployeeEvent$Create() => _create(event, emit),
      },
    );
  }

  final CreateEmployeeRepository _repository;

  /// Fetch event handler
  Future<void> _create(CreateEmployeeEvent$Create event,
      Emitter<CreateEmployeeState> emit) async {
    try {
      emit(const CreateEmployeeState.processing());
      await _repository.createEmployee(
        avatar: event.avatar,
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        address: event.address,
        description: event.description,
        specializationId: event.specializationId,
        salonId: event.salonId,
        stars: event.stars,
        percentageOfSales: event.percentageOfSales,
      );
      emit(const CreateEmployeeState.successful(message: 'Сотрудник создан'));
    } on Object catch (e) {
      emit(CreateEmployeeState.error(message: e.toString()));
      rethrow;
    } finally {
      emit(const CreateEmployeeState.idle());
    }
  }
}
