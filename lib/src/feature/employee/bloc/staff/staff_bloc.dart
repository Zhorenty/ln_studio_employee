import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/error_util.dart';
import '/src/feature/employee/data/employee_repository.dart';
import 'staff_event.dart';
import 'staff_state.dart';

/// Staff bloc.
class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc({required this.repository}) : super(const StaffState.idle()) {
    on<StaffEvent>(
      (event, emit) => event.map(
        fetch: (event) => _fetchAllEmployees(event, emit),
        fetchSalonEmployees: (event) => _fetchSalonEmployees(event, emit),
      ),
    );
  }

  /// Repository for staff data.
  final EmployeeRepository repository;

  /// Fetch staff from repository.
  Future<void> _fetchAllEmployees(
    StaffEvent$Fetch event,
    Emitter<StaffState> emit,
  ) async {
    try {
      final employees = await repository.getAll();
      emit(StaffState.loaded(staff: employees));
    } on Object catch (e) {
      emit(
        StaffState.idle(staff: state.staff, error: ErrorUtil.formatError(e)),
      );
      rethrow;
    }
  }

  /// Fetch staff from repository.
  Future<void> _fetchSalonEmployees(
    StaffEvent$FetchSalonEmployees event,
    Emitter<StaffState> emit,
  ) async {
    try {
      final employees = await repository.getAllBySalon(event.salonId);
      emit(StaffState.loaded(staff: employees));
    } on Object catch (e) {
      emit(
        StaffState.idle(staff: state.staff, error: ErrorUtil.formatError(e)),
      );
      rethrow;
    }
  }
}
